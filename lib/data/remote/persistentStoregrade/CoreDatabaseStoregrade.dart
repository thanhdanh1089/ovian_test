import 'package:ovian_test/domain/entities/SOFUsersMain.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "BookmarkUsers.db"),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE BookmarkUsers (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER, display_name TEXT, profile_image TEXT, reputation INTEGER, location INTEGER, age INTEGER DEFAULT 0)");
      },
      version: 1,
    );
  }

  Future<int> insertUser(SOFUser sofUser) async {
    final Database db = await initializedDB();
    return await db.insert('BookmarkUsers', sofUser.toJson());
  }

  Future<List<SOFUser>> getAllUsers() async {
    final Database db = await initializedDB();
    List<Map<String, dynamic>> result = await db.query('BookmarkUsers', orderBy: 'reputation DESC');
    return result.map((e) => SOFUser.fromJson(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    final Database db = await initializedDB();
    db.delete('BookmarkUsers', where: 'user_id= ?', whereArgs: [id]);
  }

  Future<void> updateUsingHelper(SOFUser user) async {
    final Database db = await initializedDB();
    await db.update('BookmarkUsers', user.toJson(),
        where: 'user_id= ?', whereArgs: [user.userId]);
  }
}
