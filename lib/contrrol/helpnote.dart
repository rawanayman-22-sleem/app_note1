import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../model/todomodel.dart';

class HelpNote {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "notetodo.db");

    var mydb = await openDatabase(path, version: 26, onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo(id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,description	TEXT NOT NULL,title	TEXT NOT NULL,date TEXT NOT NULL,done TEXT NOT NULL  )');
  }

  Future<int> insertdb(Map<String, dynamic> data) async {
    Database? db_clint = await db;
    var result = db_clint!.insert("todo", data);
    return result;
  }

  delet_DB_ByID(int id) async {
    Database? db_clint = await db;
    var result = db_clint!.rawUpdate('DELETE FROM todo WHERE id="$id"');
    return result;
  }

  update_DB_ByID(String description, int id) async {
    Database? db_clint = await db;
    var result = db_clint!
        .rawUpdate('UPDATE todo SET description="$description" WHERE id="$id"');
    return result;
  }
  getSingleRowDB(int id) async {
    Database? db_clint = await db;
    var result = db_clint!.query('todo', where: 'id"$id"');
    print("result====> $result");
    return result;
  }

// in inprog
  Future<List<TodoModel>> getDB() async {
    List<TodoModel> list = [];
    Database? db_clint = await db;
    var result = await db_clint!.query('todo');
    for (var i in result) {
      list.add(TodoModel(
          id: i["id"],
          description: i["description"],
          title: i["TTitle"],
          date: i["Date"],
          done: i["Done"]));
    }
    return list;
   }
}