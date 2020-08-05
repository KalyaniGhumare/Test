import 'package:floor/floor.dart';
import 'package:test_app/database/model/Task.dart';
@dao
abstract class TaskDao
{
	/*
	* Read Single Task details by task id
	* */
	@Query('SELECT * FROM table_task WHERE id = :id')
	Future<Task> readSingleTaskById(int id);
	
	/*
	* Read all Task list
	* */
	@Query('SELECT * FROM table_task')
	Future<List<Task>> readAllTask();
	
	/*
	* Insert New Task
	* */
	@Insert(onConflict: OnConflictStrategy.REPLACE)
	Future<int> insertTask(Task task);
	
	/*
	* Update Task using task id
	* */
	@update
	Future<int> updateTask(Task task);
}