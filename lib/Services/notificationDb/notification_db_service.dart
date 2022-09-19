import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotificationDbService {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'notification_db');
    var database = await openDatabase(path, version: 1, onCreate: _dbOnCreate);
    return database;
  }

  _dbOnCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE notification_table(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,desc TEXT)");
  }

  static Database? _database;
  Future<Database> get getdatabase async {
    if (_database != null) {
      //if the database already exists
      return _database!;
    } else {
      //else create the database and return it
      _database = await setDatabase();
      return _database!;
    }
  }

  insertData(title, desc) async {
    var connection = await getdatabase;
    await connection.rawInsert(
        'INSERT INTO notification_table(title, desc) VALUES($title,$desc)');
  }

  readData() async {
    var connection = await getdatabase;
    return await connection.query('notification_table');
  }

  // deleteData(id, orderId) async {
  //   var connection = await getdatabase;
  //   await connection.rawDelete(
  //       "DELETE FROM order_table WHERE id=? and orderId =?", [id, orderId]);
  // }
}
