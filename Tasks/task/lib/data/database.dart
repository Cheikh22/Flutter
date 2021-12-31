import 'dart:io';
import 'package:intl/intl.dart';
import 'package:task/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;
  static DatabaseHelper instance = DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  static final _dbName = 'tasks.db';
  static final _dbVersion = 1;
  static final _tableName = 'tasks';

  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';

  factory DatabaseHelper() {
    if (instance == null) {
      instance = DatabaseHelper._createInstance();
    }
    return instance;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  // open or create database
  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _dbName);
    return await openDatabase(dbPath,
        version: _dbVersion, onCreate: onCreateDB);
  }

  // create table
  onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT NOT NULL,
        $colDescription TEXT NOT NULL,
        $colDate TEXT NOT NULL
      )
    ''');
  }

  // get all tasks
  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await instance.database;
    var list = await db.query(_tableName, orderBy: '$colDate DESC');
    return list;
  }

// get task by id
  Future<Task> getTask(int id) async {
    Database db = await instance.database;
    var result =
        await db.rawQuery('SELECT * FROM $_tableName WHERE $colId = $id');
    return Task.fromJson(result.first);
  }

//insert a task
  Future<int> InsertTask(Task task) async {
    Database db = await instance.database;
    var result = await db.insert(_tableName, task.toJson());
    return result;
  }

//update a task
  Future<int> UpdateTask(Task task) async {
    Database db = await instance.database;
    var result = await db.update(_tableName, task.toJson(),
        where: '$colId =?', whereArgs: [task.id]);
    return result;
  }

// delete a task
  Future<int> DeleteTask(int id) async {
    Database db = await instance.database;
    var result =
        await db.delete(_tableName, where: '$colId =?', whereArgs: [id]);
    return result;
  }

  Future close() async {
    Database db = await instance.database;
    return db.close();
  }

  String Dateformatter() {
    var date = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy HH:mm');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }
}
