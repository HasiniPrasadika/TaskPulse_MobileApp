import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:TaskPulse/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> AddTodo(String description, String title, String type) async {
    try {
      var uuid = const Uuid().v4();
      DateTime data = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(data).toString();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('$type todos')
          .doc(uuid)
          .set({
        'id': uuid,
        'description': description,
        'isDon': false,
        'time': '${data.hour}:${data.minute}',
        'date': formattedDate,
        'title': title,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  List getTodos(AsyncSnapshot snapshot) {
    try {
      final todoList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Todo(
          data['id'],
          data['description'],
          data['time'],
          data['date'],
          data['title'],
          data['isDon'],
        );
      }).toList();
      print(todoList);
      return todoList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone, String type) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('${type} todos')
        .where('isDon', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> isdone(String uuid, bool isDon, String type) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('${type} todos')
          .doc(uuid)
          .update({'isDon': isDon});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> Update_Todo(
      String uuid, String title, String description, String type) async {
    try {
      DateTime data = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(data).toString();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('${type} todos')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'date': formattedDate,
        'description': description,
        'title': title,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> delet_todo(String uuid, String type) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('${type} todos')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }
}
