import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class posterrUsers {

  static final String tableUsers = 'CREATE TABLE IF NOT EXISTS posterr_users ('
      'username TEXT(11) NOT NULL,'
      ' name TEXT(25),'
      'joinedDate DATE, '
      'PRIMARY KEY (username)'
      ')';

  static final String tableUsersInitialData = "INSERT INTO posterr_users (username,name,joinedDate) VALUES "
      "('@fernandoferracini','Fernando Ferracini','2022-05-02'),"
      "('@generaleia','Leia Organa','2022-05-02'),"
      "('@lukesky','Luke Skywalker','2022-05-02'),"
      "('@solo','Han Solo','2022-05-02')";

  Future<Database> getDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'posterr.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(posterrUsers.tableUsers);
      },
      version: 1,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  Future<int> createTableUsers() async {
    final Database db = await getDatabase();
    //Control registry to know if the initial load was already done
    var _query = "select * from posterr_users where username = '@solo'";
    final List<Map<String, dynamic>> result = await db.rawQuery(_query);
    if (result.length <= 0) {
      await db.execute(posterrUsers.tableUsersInitialData);
    }
    return 1;
  }

}