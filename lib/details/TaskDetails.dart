import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/database/model/Task.dart';

class TaskDetailsScreen extends StatefulWidget
{
  /*
  * Global Instance of Task
  * */
  final Task task;

  /*
  * TaskDetailsScreen Constructor
  * */
  TaskDetailsScreen(this.task);

  @override
  TaskDetailsScreenState createState() => TaskDetailsScreenState();
}

class TaskDetailsScreenState extends State<TaskDetailsScreen> with TickerProviderStateMixin
{
  /*
  * Global instance of AnimationController
  * */
  AnimationController controller;
  
  /*
  * user defined method
  *  calculate string
  * */
  String get timerString {
    /*
    * Calculate Durartion
    * */
    Duration duration = controller.duration * controller.value;
    /*
    * return Hours and Mins in String formate
    * */
    return '${duration.inMinutes} Hours :${(duration.inSeconds % 60).toString().padLeft(2, '0')} Mins';
  }
  
  @override
  void initState()
  {
    super.initState();
    /*
    * Converts Hours into Mins
    * */
    int timerTime =  int.parse(widget.task.estimateTime)* 60;

    /*
    * Init Controller
    * */
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: timerTime),
    );

    /*
    * Start Counter
    * */
    controller.reverse(
        from: controller.value == 0.0
            ? 1.0
            : controller.value);
    
  }
  
  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 10.0, bottom: 20.0, right: 12.0, left: 12.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                    * Text task Details
                    * */
                    widget.task.taskDetails == null ||
                        widget.task.taskDetails.isEmpty
                        ? Container()
                        : Container(
                      margin: EdgeInsets.only(top: 30.0, left: 16.0),
                      child: Text(
                        widget.task.taskDetails,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700]),
                      ),
                    ),
                    /*
                    * Text Time in hours and mins
                    * */
                    timerString == null ||
                        timerString.isEmpty
                        ? Container()
                        : Container(
                      margin: EdgeInsets.only(top: 40.0, left: 20.0),
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child){
                          return Text(
                            timerString,
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.black),
                          );
                        },
                      )
                    ),
                    /*
                    * Text task estimate time and project
                    * */
                    Container(
                      margin: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                      child: Row(
                        children: [
                          /*
                          * Text task estimate time
                          * */
                          Expanded(
                            flex: 1,
                            child: widget.task.estimateTime == null ||
                                widget.task.estimateTime.isEmpty
                                ? Container()
                                : Container(
                              child: Text(
                                "Estimated: ${widget.task.estimateTime} Hour",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ),
                          /*
                          * Text task  project
                          * */
                          Expanded(
                            flex: 1,
                            child: widget.task.project == null ||
                                widget.task.project.isEmpty
                                ? Container()
                                : Container(
                              margin:
                              EdgeInsets.only(left: 10.0, right: 10.0),
                              child: ButtonTheme(
                                minWidth: 150.0,
                                height: 50.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Colors.grey[300])),
                                  onPressed: () {},
                                  color: Colors.grey[300],
                                  textColor: Colors.black,
                                  child: Text(
                                      widget.task.project.toUpperCase(),
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*
                    * Buttol Hold and Complete
                    * */
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /*
                                * Hold Text
                                * */
                                InkWell(
                                  onTap: () {
                                    /*
                                    * if controller is animating
                                    * then stop the animation on click on hold
                                    * */
                                    if(controller.isAnimating)
                                      {
                                        controller.stop();
                                      }
                                  },
                                  child: Container(
                                      height: 46.0,
                                      margin: EdgeInsets.only(right: 30.0),
                                      alignment: Alignment.center,
                                      child: Text("HOLD",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue))),
                                ),
                                /*
                                * Text Complete
                                * */
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 46.0,
                                    width: 170.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(80.0),
                                        color: Colors.blue),
                                    child: Center(
                                        child: Text(
                                          "COMPLETE",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Sofia",
                                              letterSpacing: 0.9),
                                        )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
  
  @override
  void dispose() {
    /*
    * Dispose controller
    * */
    controller.dispose();
    super.dispose();
  }
}
