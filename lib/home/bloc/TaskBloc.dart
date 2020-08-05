import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:test_app/database/model/Task.dart';
import 'package:test_app/home/repository/TaskRepository.dart';

class TaskBloc{
	
	/*
	* Instance of TaskRespository
	* */
	final repository = TaskRepository();
	
	/*
	* Instance of Fetcher
	* */
	final taskDataFetcher = PublishSubject<List<Task>>();
	
	/*
	* Instance of StreamController
	* */
	StreamController<List<Task>> streamController = StreamController<List<Task>>.broadcast();
	
	
	/*
	* taskDetails Method
	* */
	get taskDetails => streamController.stream;
	
	/*
	* Fetch Task from local Databse
	* */
	fetchTaskData() async {
		streamController.sink.add(await repository.fetchAllTask());
	}
	
	dispose()
	{
		/*
		* Close Controller and Fetcher Instance
		* */
		taskDataFetcher.close();
		streamController.close();
	}
}

/*
* Object of Bloc
* */
final taskBloc = TaskBloc();