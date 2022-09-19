import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OrderDbService {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'order_db');
    var database = await openDatabase(path, version: 1, onCreate: _dbOnCreate);
    return database;
  }

  _dbOnCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE order_table(id INTEGER PRIMARY KEY AUTOINCREMENT, orderId INTEGER)");
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

  insertData(orderId) async {
    var connection = await getdatabase;
    await connection
        .rawInsert('INSERT INTO order_table(orderId) VALUES($orderId)');
  }

  readData() async {
    var connection = await getdatabase;
    return await connection.query('order_table');
  }

  deleteData(id, orderId) async {
    var connection = await getdatabase;
    await connection.rawDelete(
        "DELETE FROM order_table WHERE id=? and orderId =?", [id, orderId]);
  }
}
