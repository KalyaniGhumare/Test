import 'package:floor/floor.dart';


@Entity(tableName: 'table_task')
class Task
{
	@PrimaryKey(autoGenerate: true)
	final int  id;
	
	final String taskDetails, estimateTime, project;
	
	Task(this.id, this.taskDetails, this.estimateTime, this.project);
	
	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
			other is Task &&
				runtimeType == other.runtimeType &&
				id == other.id &&
				taskDetails == other.taskDetails &&
				estimateTime == other.estimateTime &&
				project == other.project;
	
	@override
	int get hashCode => id.hashCode ^ taskDetails.hashCode ^ estimateTime.hashCode  ^ project.hashCode;
	
	@override
	String toString() {
		return 'Task{id: $id, taskDetails: $taskDetails, estimateTime: $estimateTime,  project: $project}';
	}
}