import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import '../components/posterr_general.dart';

class posterrPosts {

  static final String tablePosts = 'CREATE TABLE IF NOT EXISTS posterr_posts ('
      'codPost INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'
      'username TEXT(11),'
      'post TEXT(777),'
      'repostCode INTEGER,'
      'quoteRepostCode INTEGER,'
      'postedDatetime  DATE'
    ')';

  static final String tablePostsInitialData = "INSERT INTO posterr_posts (codPost,username,post,repostCode,quoteRepostCode,postedDatetime) VALUES "
      "(1,'@lukesky','May the force be with you',NULL,NULL,'2022-05-31 10:35:00'),"
      "(2,'@lukesky',' I have a very bad feeling about this.',NULL,NULL,'2022-05-02 15:00:00'),"
      "(3,'@lukesky','If there''s a bright center to the universe, you''re on the planet that it''s farthest from.',NULL,NULL,'2022-05-03 08:00:00'),"
      "(4,'@lukesky','Look, I can''t get involved',NULL,NULL,'2022-05-04 09:22:00'),"
      "(5,'@generaleia','Help me Obi-Wan Kenobi, you''re my only hope.',NULL,NULL,'2022-05-02 09:45:00'),"
      "(6,'@generaleia','Would it help if I got out and pushed?',NULL,NULL,'2022-05-03 12:45:00'),"
      "(7,'@generaleia','Han Solo: Look, your Worshipfulness, let''s get one thing straight.',NULL,NULL,'2022-05-03 15:20:00'),"
      "(8,'@generaleia','Han: I Love you.',NULL,NULL,'2022-05-04 11:20:00'),"
      "(9,'@solo','Never tell me the odds.',NULL,NULL,'2022-05-01 11:25:00'),"
      "(10,'@solo','I shoot First',NULL,NULL,'2022-05-04 11:40:00'),"
      "(11,'@solo','I Know.',NULL,8,'2022-05-04 15:47:00'),"
      "(12,'@fernandoferracini','Star Wars!!!!',NULL,NULL,'2022-05-01 12:35:00'),"
      "(13,'@fernandoferracini','Me neither',NULL,4,'2022-06-02 16:20:00'),"
      "(14,'@fernandoferracini',NULL,1,NULL,'2022-05-31 12:35:00'),"
      "(15,'@generaleia',NULL,11,NULL,'2022-05-04 15:47:00')";

  static const String _nameTablePosts = 'SELECT codPost, username, post, repostCode, quoteRepostCode, postedDatetime FROM posterr_posts order by postedDatetime desc';

  Future<Database> getDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'posterr.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(posterrPosts.tablePosts);
      },
      version: 1,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  Future<int> createTablePosts() async {
    final Database db = await getDatabase();
    await db.execute(posterrPosts.tablePosts);
    //Control registry to know if the initial load was already done
    var _query = "SELECT * from posterr_posts where codPost = '15' and username = '@generaleia'";
    final List<Map<String, dynamic>> result = await db.rawQuery(_query);
    if (result.length <= 0) {
      await db.execute(posterrPosts.tablePostsInitialData);
    }
    return 1;
  }

  Future<List<Map<String, dynamic>>> getAllPosts() async {
    final Database db = await (getDatabase());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    String _listAllPosts = "SELECT "
        "a.codPost, "
        "a.username, "
        "c.name, "
        "a.post, "
        "a.repostCode, "
        "a.quoteRepostCode, "
        "a.postedDatetime, "
        "Cast ((JulianDay('$formatted') - JulianDay(a.postedDatetime)) As Integer) as postedDaysFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(a.postedDatetime)) * 24 As Integer) as postedHoursFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(a.postedDatetime)) * 24 * 60 As Integer) as postedMinutesFrom, "
        "case when repostCode <> '' then (select b.username from posterr_posts b where b.codPost = a.repostCode) else null end as repostUsername, "
        "case when repostCode <> '' then (select name from posterr_users where username = (select b.username from posterr_posts b where b.codPost = a.repostCode)) else null end as repostname, "
        "case when repostCode <> '' then (select b.post from posterr_posts b where b.codPost = a.repostCode) else null  end as repostPost,	"
        "case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end as repostpostedDatetime, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) As Integer) as repostDaysFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) * 24 As Integer) as repostHoursFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) * 24 * 60 As Integer) as repostMinutesFrom, "
        "case when quoteRepostCode <> '' then (select b.username from posterr_posts b where b.codPost = a.quoteRepostCode) else null end as quoteRepostCodeUsername, "
        "case when quoteRepostCode <> '' then (select name from posterr_users where username = (select b.username from posterr_posts b where b.codPost = a.quoteRepostCode)) else null end as quoteRepostname, "
        "case when quoteRepostCode <> '' then (select b.post from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end as quoteRepostPost, "
        "case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end as quoteRepostCodepostedDatetime, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) As Integer) as quoteRepostDaysFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) * 24 As Integer) as quoteRepostHoursFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) * 24 * 60 As Integer) as quoteRepostMinutesFrom, "
        "(select count(*) from posterr_posts where username = a.username and postedDatetime BETWEEN (DATE() || ' 00:00:00') and (DATE() || ' 23:59:00')) as postsToday "
        "FROM  posterr_posts a inner join posterr_users c on a.username = c.username "
        "order by postedDatetime desc";
    final List<Map<String, dynamic>> result = await db.rawQuery(_listAllPosts);
    return result;
  }

  Future<int> post(String username, String post) async {
    final Database db = await (getDatabase());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    print(formatted); // something like 2013-04-20
    String _sql = "INSERT INTO posterr_posts "
        "(username,post,repostCode,quoteRepostCode,postedDatetime) VALUES "
        "('$username','$post',NULL,NULL,'$formatted')";
    final List<Map<String, dynamic>> result = await db.rawQuery(_sql);
    return 1;
  }

  Future<int> repost(String username, int codPost) async {
    final Database db = await (getDatabase());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    String _sql = "INSERT INTO posterr_posts "
        "(username,post,repostCode,quoteRepostCode,postedDatetime) VALUES "
        "('$username',NULL,$codPost,NULL,'$formatted')";
    final List<Map<String, dynamic>> result = await db.rawQuery(_sql);
    return 1;
  }

  Future<int> quoteRepost(String username, int codPost,String post) async {
    final Database db = await (getDatabase());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    String _sql = "INSERT INTO posterr_posts "
        "(username,post,repostCode,quoteRepostCode,postedDatetime) VALUES "
        "('$username','$post',NULL,$codPost,'$formatted')";
    final List<Map<String, dynamic>> result = await db.rawQuery(_sql);
    return 1;
  }

  Future<List<Map<String, dynamic>>> getPost(codPost) async {
    final Database db = await (getDatabase());
    String _sql = "SELECT "
        "a.codPost, "
        "a.username, "
        "c.name, "
        "a.post, "
        "a.repostCode, "
        "a.quoteRepostCode, "
        "a.postedDatetime, "
        "Cast ((JulianDay('now') - JulianDay(a.postedDatetime)) As Integer) as postedDaysFrom, "
        "Cast ((JulianDay('now') - JulianDay(a.postedDatetime)) * 24 As Integer) as postedHoursFrom, "
        "Cast ((JulianDay('now') - JulianDay(a.postedDatetime)) * 24 * 60 As Integer) as postedMinutesFrom, "
        "case when repostCode <> '' then (select b.username from posterr_posts b where b.codPost = a.repostCode) else null end as repostUsername, "
        "case when repostCode <> '' then (select name from posterr_users where username = (select b.username from posterr_posts b where b.codPost = a.repostCode)) else null end as repostname, "
        "case when repostCode <> '' then (select b.post from posterr_posts b where b.codPost = a.repostCode) else null  end as repostPost,	"
        "case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end as repostpostedDatetime, "
        "Cast ((JulianDay('now') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) As Integer) as repostDaysFrom, "
        "Cast ((JulianDay('now') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) * 24 As Integer) as repostHoursFrom, "
        "Cast ((JulianDay('now') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) * 24 * 60 As Integer) as repostMinutesFrom, "
        "case when quoteRepostCode <> '' then (select b.username from posterr_posts b where b.codPost = a.quoteRepostCode) else null end as quoteRepostCodeUsername, "
        "case when quoteRepostCode <> '' then (select name from posterr_users where username = (select b.username from posterr_posts b where b.codPost = a.quoteRepostCode)) else null end as quoteRepostname, "
        "case when quoteRepostCode <> '' then (select b.post from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end as quoteRepostPost, "
        "case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end as quoteRepostCodepostedDatetime, "
        "Cast ((JulianDay('now') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) As Integer) as quoteRepostDaysFrom, "
        "Cast ((JulianDay('now') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) * 24 As Integer) as quoteRepostHoursFrom, "
        "Cast ((JulianDay('now') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) * 24 * 60 As Integer) as quoteRepostMinutesFrom, "
        "(select count(*) from posterr_posts where username = a.username and postedDatetime BETWEEN (DATE() || ' 00:00:00') and (DATE() || ' 23:59:00')) as postsToday "
        "FROM  posterr_posts a inner join posterr_users c on a.username = c.username "
        "where a.codPost = $codPost "
        "order by postedDatetime desc";
    final List<Map<String, dynamic>> result = await db.rawQuery(_sql);
    return result;
  }

  Future<List<Map<String, dynamic>>> getPostsUsername(username) async {
    final Database db = await (getDatabase());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    String _listAllPosts = "SELECT "
        "a.codPost, "
        "a.username, "
        "c.name, "
        "c.joinedDate, "
        "a.post, "
        "a.repostCode, "
        "a.quoteRepostCode, "
        "a.postedDatetime, "
        "Cast ((JulianDay('$formatted') - JulianDay(a.postedDatetime)) As Integer) as postedDaysFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(a.postedDatetime)) * 24 As Integer) as postedHoursFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(a.postedDatetime)) * 24 * 60 As Integer) as postedMinutesFrom, "
        "case when repostCode <> '' then (select b.username from posterr_posts b where b.codPost = a.repostCode) else null end as repostUsername, "
        "case when repostCode <> '' then (select name from posterr_users where username = (select b.username from posterr_posts b where b.codPost = a.repostCode)) else null end as repostname, "
        "case when repostCode <> '' then (select b.post from posterr_posts b where b.codPost = a.repostCode) else null  end as repostPost,	"
        "case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end as repostpostedDatetime, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) As Integer) as repostDaysFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) * 24 As Integer) as repostHoursFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when repostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.repostCode) else null  end)) * 24 * 60 As Integer) as repostMinutesFrom, "
        "case when quoteRepostCode <> '' then (select b.username from posterr_posts b where b.codPost = a.quoteRepostCode) else null end as quoteRepostCodeUsername, "
        "case when quoteRepostCode <> '' then (select name from posterr_users where username = (select b.username from posterr_posts b where b.codPost = a.quoteRepostCode)) else null end as quoteRepostname, "
        "case when quoteRepostCode <> '' then (select b.post from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end as quoteRepostPost, "
        "case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end as quoteRepostCodepostedDatetime, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) As Integer) as quoteRepostDaysFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) * 24 As Integer) as quoteRepostHoursFrom, "
        "Cast ((JulianDay('$formatted') - JulianDay(case when quoteRepostCode <> '' then (select b.postedDatetime from posterr_posts b where b.codPost = a.quoteRepostCode) else null  end)) * 24 * 60 As Integer) as quoteRepostMinutesFrom,  "
        "(select count(*) from posterr_posts where repostCode is null and quoteRepostCode is null and username = '$username') as countPost, "
        "(select count(*) from posterr_posts where repostCode is not null and username = '$username') as countRepost, "
        "(select count(*) from posterr_posts where quoteRepostCode is not null and username = '$username') as countQuoteRepost,  "
        "(select count(*) from posterr_posts where username = a.username and postedDatetime BETWEEN (DATE() || ' 00:00:00') and (DATE() || ' 23:59:00')) as postsToday "
        "FROM  posterr_posts a inner join posterr_users c on a.username = c.username "
        "where a.username = '$username'"
        "order by postedDatetime desc";
    // PosterrGeneral.printLongText(_listAllPosts);
    final List<Map<String, dynamic>> result = await db.rawQuery(_listAllPosts);
    return result;
  }

  Future<List<Map<String, dynamic>>> getPostsData(username) async {
    final Database db = await (getDatabase());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(now);
    String _listAllPosts = "SELECT "
        "a.codPost, "
        "a.username, "
        "c.name, "
        "a.post, "
        "a.repostCode, "
        "a.quoteRepostCode, "
        "a.postedDatetime, "
        "(select count(*) from posterr_posts where repostCode is null and quoteRepostCode is null and username = '$username') as countPost, "
        "(select count(*) from posterr_posts where repostCode is not null and username = '$username') as countRepost, "
        "(select count(*) from posterr_posts where quoteRepostCode is not null and username = '$username') as countQuoteRepost "
        "FROM  posterr_posts a inner join posterr_users c on a.username = c.username "
        "where a.username = '$username'"
        "order by postedDatetime desc";
    final List<Map<String, dynamic>> result = await db.rawQuery(_listAllPosts);
    return result;
  }

}