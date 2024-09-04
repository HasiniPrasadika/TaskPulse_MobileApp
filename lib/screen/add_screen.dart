import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/data/todo_data.dart';

class AddTodoPage extends StatefulWidget {
  final String type;
  const AddTodoPage({super.key, required this.type});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final title = TextEditingController();
  final description = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.09),
          child: AppBar(
            title: Text(
              '${widget.type} TaskPulse',
              style: TextStyle(
                color: const Color.fromARGB(255, 26, 26, 26),
                fontWeight: FontWeight.bold,
                fontSize: width * 0.055,
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.02, 0, 0, 0),
                  child: Icon(
                    Boxicons.bx_chevron_left,
                    color: const Color.fromARGB(255, 128, 128, 128),
                    size: width * 0.1,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Image.asset(
                  'assets/images/login.png', // replace with your image path
                  width: double.infinity,
                  height: width * 0.55,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                title_widgets(),
                SizedBox(
                  height: height * 0.02,
                ),
                subtite_wedgite(),
                SizedBox(
                  height: height * 0.06,
                ),
                button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: width * 0.05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: custom_purple,
            minimumSize: Size(width * 0.1, height * 0.055),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Set your desired border radius here
            ),
          ),
          onPressed: () {
            Firestore_Datasource()
                .AddTodo(description.text, title.text, widget.type);
            Navigator.pop(context);
          },
          child: Text(
            'Add Task',
            style: TextStyle(color: Colors.white, fontSize: width * 0.038),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            minimumSize: Size(width * 0.1, height * 0.055),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10), // Set your desired border radius here
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white, fontSize: width * 0.038),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget title_widgets() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: width * 0.04, color: Colors.black),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.018),
              hintText: 'Title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: custom_purple,
                  width: 1.0,
                ),
              )),
        ),
      ),
    );
  }

  Padding subtite_wedgite() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: description,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: width * 0.04, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.018),
            hintText: 'Description',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffc5c5c5),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_purple,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
