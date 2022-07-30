import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/post.dart';

class DbHelper extends ChangeNotifier {
  DbHelper() {
    initDatabase();
  }
  Database? database;
  initDatabase() async {
    print("initiated");
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'later.db';
    String fullPath = join(databasePath, databaseName);
    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) {
      print('hello, the database has been created');

      db.execute('''
 CREATE TABLE ${PostsTable.postsTableName} (
  ${PostsTable.idColumName} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${PostsTable.contentColumName} TEXT,
  ${PostsTable.creationTimeColumName} TEXT,
  ${PostsTable.dueOnColumName} TEXT,
  ${PostsTable.imagePathColumName} TEXT,
  ${PostsTable.isTimedColumName} INTEGER,
  ${PostsTable.feelingColumName} TEXT,
  ${PostsTable.typeColumName} INTEGER
  )
''');
    }, onOpen: (db) async {
      final tables =
          await db.rawQuery('SELECT name FROM sqlite_master ORDER BY name;');
      print(tables.toString());
    });
    return database;
  }

  // POSTS CRUID ---------------------------------------

  insertNewPost(Post post) async {
    int rowIndex =
        await database!.insert(PostsTable.postsTableName, post.toMap());
    print(rowIndex.toString());
  }

  Future<List<Post>> selectAllPosts() async {
    List<Map<String, Object?>> rowsAsMaps = await database!.query(
        PostsTable.postsTableName,
        where: '${PostsTable.typeColumName}=?',
        whereArgs: [1]);
    List<Post> posts = rowsAsMaps.map((e) => Post.fromMap(e)).toList();
    return posts;
  }

  selectOnePost(int id) {
    database!.query(PostsTable.postsTableName,
        where: '${PostsTable.idColumName}=?', whereArgs: [id]);
  }

  updateOnePost(Post post) async {
    int count = await database!.update(PostsTable.idColumName, post.toMap(),
        where: '${PostsTable.idColumName}=?', whereArgs: [post.id]);
    print(count.toString());
  }

  deleteOnePost(int id) {
    database!.delete(PostsTable.postsTableName,
        where: '${PostsTable.idColumName}=?', whereArgs: [id]);
  }
  //--------------------------------------------------
  // POSTS CRUID ---------------------------------------

}

class PostsTable {
  static const String postsTableName = 'posts';
  static const String idColumName = 'id';
  static const String contentColumName = 'content';
  static const String creationTimeColumName = 'creationTime';
  static const String dueOnColumName = 'dueOn';
  static const String imagePathColumName = 'imagePath';
  static const String isTimedColumName = 'isTimed';
  static const String feelingColumName = 'feeling';
  static const String typeColumName = 'type';
}
