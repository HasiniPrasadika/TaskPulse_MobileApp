import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/data/todo_data.dart';
import 'package:TaskPulse/models/todo_model.dart';
import 'package:TaskPulse/screen/edit_screen.dart';

class TodoWidget extends StatefulWidget {
  final Todo _todo;
  final String type;
  const TodoWidget(this._todo, {super.key, required this.type});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._todo.isDon;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: IntrinsicHeight(
        // Wrap Row with IntrinsicHeight
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 6,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                // Date and time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        widget._todo.time,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        widget._todo.date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(189, 189, 189, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 1,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(189, 189, 189, 1)),
                ),
                const SizedBox(
                  width: 10,
                ),
                // Title, subtitle and other contents
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget._todo.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MSHCheckbox(
                            size: 25,
                            value: isDone,
                            colorConfig:
                                MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: custom_purple,
                            ),
                            style: MSHCheckboxStyle.stroke,
                            onChanged: (value) {
                              setState(() {
                                isDone = !isDone;
                              });
                              Firestore_Datasource()
                                  .isdone(widget._todo.id, isDone, widget.type);
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                        child: Text(
                          widget._todo.description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      edit_time()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget edit_time() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Edit_Screen(
                  widget._todo,
                  type: widget.type,
                ),
              ));
            },
            child: Container(
              width: 80,
              height: 26,
              decoration: BoxDecoration(
                color: custom_purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.penToSquare,
                        size: 12,
                        color: Colors.white,
                      ),
                      Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
