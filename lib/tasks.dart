import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// defines the task object
class Tasks {
  final String title;
  final int id;
  bool isDone;

  Tasks({required this.title, required this.id, required this.isDone});
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _controller = TextEditingController();
  List<Tasks> tasks = [];
  final player = AudioPlayer();
  int uniqueId = 0;
  bool showPopUp = false;
  double popUpPosition = -1200;

  void addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        tasks.add(
          Tasks(title: _controller.text, id: uniqueId++, isDone: false),
        );
      });
    }

    _controller.clear();
  }

  void playSound() async {
    await player.play(AssetSource("assets/sounds/try.wav"));
  }

  void markAsDone(int id, int index) {
    setState(() {
      if (tasks[index].isDone == false) {
        tasks[index].isDone = true;
        showPopUp = true;
        popUpPosition = 300;

        playSound();
      } else {
        tasks.removeWhere((task) => task.id == id);
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        popUpPosition = -1200;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        
        children: [
          Container( // container of background
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg2.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding( // padding for contents
            
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Column( // contents
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(// Progress bar
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerLeft,
                    children: [
                      SizedBox( // container of progress bar
                        width: 250,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Color(0xFFAB4A9A),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align( // the bar that moves
                            alignment: Alignment.centerLeft,
                            child: AnimatedContainer(
                              duration: Duration(
                                milliseconds: 500,
                              ), 
                              curve: Curves.easeInOut,
                              width:
                                  tasks.isEmpty
                                      ? 0
                                      : tasks
                                              .where((task) => task.isDone)
                                              .length *
                                          (250 / tasks.length),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFFFA6AE0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned( // heart icon on the left side
                        left: -30,
                        height: 100,
                        child: Image.asset("assets/images/heart.png"),
                      ),
                    ],
                  ),
                  Expanded( // the list of tasks
                    child: Padding( // padding for task container
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return Padding( // padding for each task
                            padding: const EdgeInsets.all(3.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container( // container of each task
                                width: 350,
                                constraints: BoxConstraints(minHeight: 50),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/taskBg.png",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Row( // contents of task
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,

                                      children: [
                                        Expanded(
                                          child: Text( // task text
                                            task.title,
                                            softWrap: true,

                                            style: TextStyle(
                                              decoration:
                                                  task.isDone
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                              decorationThickness: 4,
                                              fontFamily: "PressStart2P",
                                            ),
                                          ),
                                        ),

                                        GestureDetector( // task button
                                          onTap:
                                              () => markAsDone(task.id, index),
                                          child: Container(
                                            width: 75,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  task.isDone == true
                                                      ? "assets/images/deleteBg.png"
                                                      : "assets/images/doneBg.png",
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                task.isDone ? "Delete" : "Done",
                                                style: TextStyle(
                                                  fontFamily: "PressStart2P",
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Align( // input field and button
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        TextField(// text field
                          controller: _controller,
                          style: TextStyle(fontFamily: "PressStart2P"),
                        ),

                        GestureDetector( // add button
                          onTap: addTask,
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/buttonBg.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "ADD TASK",
                                style: TextStyle(
                                  fontFamily: "PressStart2P",
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedPositioned( // mario pop up animation 
            duration: Duration(milliseconds: 600),
            left: 0,
            right: 0,
            top: 0,
            curve: Curves.easeInBack, // Smooth transition curve
            bottom: popUpPosition,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Image.asset("assets/images/mario.png", width: 350),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
