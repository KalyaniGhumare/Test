import 'package:test_app/database/model/Task.dart';
import 'package:test_app/home/ApiHelper/TaskAPIHelper.dart';

class TaskRepository
{
	/*
	* Instance of Provider
	* */
	final taskApiProvider = TaskApiBaseHelper();
	
	/*
	* Fetch All Task Method
	* */
	Future<List<Task>> fetchAllTask() => taskApiProvider.getAllTask();
}