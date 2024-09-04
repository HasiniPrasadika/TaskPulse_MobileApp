import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/screen/add_screen.dart';
import 'package:TaskPulse/widgets/stream_todo.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({super.key});

  @override
  State<OfficePage> createState() => _OfficePageState();
}

bool show = true;

class _OfficePageState extends State<OfficePage> {
  int totalTasks = 0;
  int completedTasks = 0;
  int ongoingTasks = 0;
  double completedPercentage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddTodoPage(
                type: 'Office',
              ),
            ));
          },
          backgroundColor: custom_purple,
          child: Icon(
            Icons.add,
            size: width * 0.07,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  show = true;
                });
              }
              if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  show = false;
                });
              }
              return true;
            },
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('Office todos')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                  color: custom_purple,
                ));
                }

                final List<DocumentSnapshot> tasks = snapshot.data!.docs;
                totalTasks = tasks.length;
                completedTasks =
                    tasks.where((task) => task['isDon'] == true).length;
                ongoingTasks = totalTasks - completedTasks;
              completedPercentage =
                    tasks.length == 0 ? 0 : (completedTasks / totalTasks) * 100;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.01),
                      child: Container(
                        width: double.infinity,
                        height: height * 0.26,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 84, 195, 239),
                                Color.fromARGB(255, 6, 87, 185)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.08,
                                  vertical: height * 0.01),
                              child: Text(
                                'TaskPulse Progress Summary',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.05,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.08),
                              child: Text(
                                '$totalTasks Office Tasks',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.037,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width * 0.08,
                                      height * 0.01, 0, height * 0.01),
                                  child: Container(
                                    width: width * 0.14,
                                    height: width * 0.14,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/progress.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.08),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Progress',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.035,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.14),
                                          Text(
                                            '${completedPercentage.toStringAsFixed(0)}%',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                          trackHeight: height * 0.012,
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor:
                                              const Color.fromARGB(
                                                  127, 255, 255, 255),
                                          thumbColor: Colors.transparent,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                                  enabledThumbRadius: 0),
                                          overlayColor: Colors.transparent,
                                          valueIndicatorColor: Colors.blue,
                                        ),
                                        child: Slider(
                                          value: completedTasks.toDouble(),
                                          min: 0,
                                          max: totalTasks.toDouble(),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.005),
                      child: Row(
                        children: [
                          Text(
                            'Ongoing',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: height * 0.03,
                                color: custom_purple,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Icon(
                            FontAwesomeIcons.listUl,
                            color: const Color.fromARGB(255, 72, 72, 72),
                            size: width * 0.05,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    StreamTodo(
                      false,
                      type: 'Office',
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.005),
                      child: Row(
                        children: [
                          Text(
                            'Completed',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: height * 0.03,
                                color: const Color.fromARGB(255, 72, 72, 72),
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Icon(
                            FontAwesomeIcons.checkDouble,
                            color: const Color.fromARGB(255, 72, 72, 72),
                            size: width * 0.05,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    StreamTodo(
                      true,
                      type: 'Office',
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
