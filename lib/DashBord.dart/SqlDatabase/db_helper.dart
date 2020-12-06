import 'dart:io';
import 'package:firebase_app/DashBord.dart/SqlDatabase/to_do_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


class DatBaseHelper {
  String tableName = "db_tableName";
  String id = "id";
  String title = "title";
  String description = "description";
  String status = "status";
  String date = "date";

  static DatBaseHelper _dataBaseHelper; //singleton class
  DatBaseHelper._createInstance();

  factory DatBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DatBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Database _database; //singleton e object

  get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

//create datase path
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = directory.path + "my_database_list.db";
    return await openDatabase(path, version: 1, onCreate: _create);
  }

  _create(Database database, int version) async {
    return await database.execute(
        "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT , $title TEXT, $description TEXT, $status TEXT, $date TEXT)");
  }

//insert data to database
  Future<int> insert(ToDoModel toDoModel) async {
    Database db = await this.database;
    var result = db.insert(tableName, toDoModel.toMap());
    print("Data Inserted to DataBase");
    return result;
  }

//get Data From database
  Future<List<Map<String, dynamic>>> getDatainMaps() async {
    Database dataBase = await this.database;
    print("Data eceved from DataBase");
    return dataBase.query(tableName);
  }

  //convert data to pojo model
  Future<List<ToDoModel>> getModelsFromMapList() async {
    List<Map<String, dynamic>> mapList = await getDatainMaps();

    //to set each data item from db
    List<ToDoModel> toDoListModel = new List();

    for (int i = 0; i < mapList.length; i++) {
      toDoListModel.add(ToDoModel.fromMap(mapList[i]));
    }
    return toDoListModel;
  }

  //upDate data
  Future<int> upDateData(ToDoModel toDoModel) async {
    Database _db = await this.database;
    return _db.update(tableName, toDoModel.toMap(),
        where: "$id = ?", whereArgs: [toDoModel.id]);
  }

  Future<int> deleteData(ToDoModel toDoModel) async {
    Database deleteItem = await this.database;
    return deleteItem.delete(tableName, where: "$id = ?", whereArgs: [toDoModel.id]);
  }
}
