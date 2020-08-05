import 'package:flutter/material.dart';
import 'package:test_app/database/model/Task.dart';
import 'package:test_app/details/TaskDetails.dart';

class TaskListItem extends StatelessWidget {
  /*
  * Instance of Task
  * */
  final Task task;

  /*
  * TaskListItem Contructor
  * */
  TaskListItem({@required this.task});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20.0),
      child: Card(
        elevation: 6.0,
        child: Container(
          margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              * Text
              * Task Details
              * */
              task.taskDetails == null || task.taskDetails.isEmpty
                  ? Container()
                  : Text(
                      task.taskDetails,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey),
                    ),
              /*
              * Text
              * Project and And Start button
              * */
              Container(
                margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                child: Row(
                  children: [
                    /*
                    * Text Project
                    * */
                    task.project == null
                        ? Container()
                        : Container(
                            child: ButtonTheme(
                              minWidth: 150.0,
                              height: 46.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.grey[300])),
                                onPressed: () {},
                                color: Colors.grey[300],
                                textColor: Colors.black,
                                child: Text(task.project.toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ),
                          ),
                    /*
                    * Button Start
                    * */
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: InkWell(
                          onTap: () => openTaskDetailsData(context, task),
                          child: Text("START",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 16.0)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /*
  * User define method
  * open task details screen
  * */
  void openTaskDetailsData(BuildContext context, Task task) async {
    /*
    * Open Task Details Screen On Click On Single Card
    * */
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TaskDetailsScreen(task)));
  }
}
