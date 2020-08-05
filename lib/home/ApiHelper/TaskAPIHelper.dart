import 'package:test_app/Utils.dart';
import 'package:test_app/database/model/Task.dart';

class TaskApiBaseHelper
{
	Future<List<Task>> getAllTask() async
	{
		/*
		* Init Database
		* */
		var dbDao = await Utils.intiDatabase();
		
		/*
		* Read All Task From Local Database
		* */
		List<Task> taskList = await dbDao.readAllTask();
		
		print("taskList ${taskList.length}");
		
		return taskList;
		
	}
}