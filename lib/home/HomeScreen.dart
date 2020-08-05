import 'package:flutter/material.dart';
import 'package:test_app/Utils.dart';
import 'package:test_app/database/model/Task.dart';
import 'package:test_app/home/TaskListItem.dart';
import 'package:test_app/home/bloc/TaskBloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  /*
  * Global Instance of Controller
  * */
  TextEditingController taskDetailsController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController projectecrController = new TextEditingController();

  /*
  * Global Instacne of Global Key
  * */
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    /*
    * Read Task List
    * */
    taskBloc.fetchTaskData();

    var search = Card(
      elevation: 6.0,
      child: Container(
        height: 54.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 0.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            children: <Widget>[
              /*
              * Icon Search
              * */
              Container(
                width: 30.0,
                child: Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: 30.0,
                ),
              ),
              /*
              * Space Between Icon and Search text
              * */
              SizedBox(
                width: 10.0,
              ),
              /*
              * Text Search Task
              * */
              Expanded(
                child: Text(
                  "Search Task",
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      fontSize: 18.0),
                ),
              ),
              /*
              * Icon more
              * */
              Icon(
                Icons.more_vert,
                color: Colors.black54,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
          color: Colors.white70,
          child: Column(
            children: [
              /*
              * Search Card UI
              * */
              search,
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: StreamBuilder(
                  stream: taskBloc.taskDetails,
                  builder: (context, AsyncSnapshot<List<Task>> snapShot) {
                    if (snapShot.hasData)
                    {
                      return snapShot.data.isEmpty
                          ? SizedBox()
                          : loadTaskData(snapShot.data);
                    } else if (snapShot.hasError) return SizedBox();

                    return Container(
                      child: Center(
                          child: Text("Loading data..",
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  fontSize: 18.5,
                                  color: Colors.black.withOpacity(0.9),
                                  fontWeight: FontWeight.w600))),
                    );
                  },
                ),
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAlertDialog();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /*
  * Dialog Box
  * Open New Pop to add new task
  * */
  showAlertDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                * Space Above Top
                * Of Add Task
                * */
                SizedBox(height: 10.0),
                
                /*
                * Text Add Text
                * */
                Text('Add Task',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.w300)),
                /*
                * Space between Text and
                * EditText taskDetails
                * */
                SizedBox(height: 10.0),
                /*
                * EditText Task Details
                * */
                TextField(
                    maxLines: 5,
                    controller: taskDetailsController,
                    decoration: InputDecoration(
                      hintText: "Task Details",
                      border: OutlineInputBorder(),
                    )),
                /*
                * Space between Text and
                * EditText taskDetails
                * */
                SizedBox(height: 24.0),
                /*
                * EditText Estimated Time
                * */
                Utils.textFrormField(timeController, 'Estimated Time (in Hrs)',
                    TextInputType.text),
                /*
                * Space between EditText Estimated Time
                * EditText Select Project
                * */
                SizedBox(height: 24.0),
                /*
                * EditText Select Project
                * */
                Utils.textFrormField(
                    projectecrController, 'Select Project', TextInputType.text),
                SizedBox(height: 15.0),
              ],
            ),
          ),
          actions: <Widget>[
            /*
            * Button Cancel
            * */
            FlatButton(
              child: Text('CANCEL',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            
            /*
            * Button Save
            * */
            FlatButton(
              child: Text('SAVE',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue)),
              onPressed: () {
                addTaskIntoDatabase();
              },
            ),
            SizedBox(width: 10.0)
          ],
        );
      },
    );
  }

  /*
  * Add New Task
  * into Database
  * */
  void addTaskIntoDatabase() async {
    /*
    * Init Database
    * */
    var dao = await Utils.intiDatabase();

    /*
    * Get Data From TextFormField
    * And
    * Insert Data into Database
    * */
    int insertTask = await dao.insertTask(Task(
      null,
      taskDetailsController.text.trim(),
      timeController.text.trim(),
      projectecrController.text.trim(),
    ));

    if (insertTask > 0)
    {
      /*
      * Reload List When new enter
      * added
      * */
      taskBloc.fetchTaskData();
      
      /*
      * Dismiss AlertDialog
      * */
      Navigator.of(context).pop();
      
      /*
      * Display SnackBar
      * */
      scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("New Task added successfully."),
          duration: const Duration(seconds: 5)));
    }
  }

  /*
  * Load Task List
  * */
  loadTaskData(List<Task> taskList)
  {
    return taskList.length == 0
        ? Container()
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (ctx, index)
            {
              return TaskListItem(task: taskList[index]);
            },
            itemCount: taskList.length,
          );
  }
}
