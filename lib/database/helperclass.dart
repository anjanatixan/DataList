import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:user_profile/model/commentModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'comments.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE comments(id INTEGER PRIMARY KEY, name TEXT, email TEXT, body TEXT)',
    );
  }

  Future<int> insertComment(Comment comment) async {
    var dbClient = await db;
    int res = await dbClient.insert('comments', comment.toJson());
    return res;
  }

  Future<List<Comment>> getComments() async {
    var dbClient = await db;
    var res = await dbClient.query('comments');
    List<Comment> list =
        res.isNotEmpty ? res.map((c) => Comment.fromJson(c)).toList() : [];
    return list;
  }
  
  Future<void> clearDatabase() async {
    final dbs = await db;
    await dbs.delete('comments');
  }
}
