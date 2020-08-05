// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorTaskDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TaskDatabaseBuilder databaseBuilder(String name) =>
      _$TaskDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TaskDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TaskDatabaseBuilder(null);
}

class _$TaskDatabaseBuilder {
  _$TaskDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$TaskDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TaskDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TaskDatabase> build() async {
    final database = _$TaskDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TaskDatabase extends TaskDatabase {
  _$TaskDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao _taskDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `taskDetails` TEXT, `estimateTime` TEXT, `project` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'table_task',
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'taskDetails': item.taskDetails,
                  'estimateTime': item.estimateTime,
                  'project': item.project
                }),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'table_task',
            ['id'],
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'taskDetails': item.taskDetails,
                  'estimateTime': item.estimateTime,
                  'project': item.project
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _table_taskMapper = (Map<String, dynamic> row) => Task(
      row['id'] as int,
      row['taskDetails'] as String,
      row['estimateTime'] as String,
      row['project'] as String);

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  @override
  Future<Task> readSingleTaskById(int id) async {
    return _queryAdapter.query('SELECT * FROM table_task WHERE id = ?',
        arguments: <dynamic>[id], mapper: _table_taskMapper);
  }

  @override
  Future<List<Task>> readAllTask() async {
    return _queryAdapter.queryList('SELECT * FROM table_task',
        mapper: _table_taskMapper);
  }

  @override
  Future<int> insertTask(Task task) {
    return _taskInsertionAdapter.insertAndReturnId(
        task, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<int> updateTask(Task task) {
    return _taskUpdateAdapter.updateAndReturnChangedRows(
        task, sqflite.ConflictAlgorithm.abort);
  }
}
