import 'package:flutter/material.dart';
import 'package:test_app/database/dao/TaskDao.dart';
import 'package:test_app/database/db/task_database.dart';

class Utils {
  /*
  * Common TextFormField
  * */
  static Widget textFrormField(TextEditingController controller, String labelText, TextInputType inputType) {
    return Container(
      height: 70.5,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border(
          bottom: BorderSide(width: 2.0, color: Colors.black54),
        ),
      ),
      child: TextFormField(
        style: new TextStyle(color: Colors.black),
        controller: controller,
        textAlign: TextAlign.start,
        keyboardType: inputType,
        autocorrect: false,
        autofocus: false,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(0.0),
            filled: true,
            fillColor: Colors.transparent,
            labelText: labelText,
            hintStyle: TextStyle(color: Colors.white),
            labelStyle: TextStyle(
              color: Colors.black45,
            )),
      ),
    );
  }

  /*
  * Init Local Database
  * */
  static Future<TaskDao> intiDatabase() async
  {
    TaskDatabase database = await $FloorTaskDatabase.databaseBuilder("task.db").build();
    final dao = database.taskDao;
    return dao;
  }
}