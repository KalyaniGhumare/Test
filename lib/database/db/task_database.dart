import 'dart:async';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:test_app/database/dao/TaskDao.dart';
import 'package:test_app/database/model/Task.dart';

part 'task_database.g.dart';

@Database(version: 1, entities: [Task])
abstract class TaskDatabase extends FloorDatabase {
	TaskDao get taskDao;
}