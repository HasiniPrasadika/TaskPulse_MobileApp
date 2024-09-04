import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/data/todo_data.dart';
import 'package:TaskPulse/widgets/todo_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamTodo extends StatefulWidget {
  final String type;
  final bool done;
  StreamTodo(this.done, {super.key, required this.type});

  @override
  State<StreamTodo> createState() => _StreamTodoState();
}

class _StreamTodoState extends State<StreamTodo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore_Datasource().stream(widget.done, widget.type),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: custom_purple,
              ),
            );
          }
          final todoList = Firestore_Datasource().getTodos(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final todo = todoList[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  Firestore_Datasource().delet_todo(todo.id, widget.type);
                },
                child: TodoWidget(todo, type: widget.type),
              );
            },
            itemCount: todoList.length,
          );
        },
      ),
    );
  }
}
