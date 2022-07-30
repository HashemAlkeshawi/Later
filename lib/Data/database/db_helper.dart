import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../classes/post.dart';

class DbHelper extends ChangeNotifier {
  List<Post>? posts = [];
  List<Post>? posts_due_soon = [];
  Database? _database;

  DbHelper() {
    print('constructor called');
    initDatabase();
  }
  initDatabase() async {
    print("initiated");
    _database = await createConnectionWithDatabase();
    selectAllPosts();

    notifyListeners();
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
      print('onOpen!');
    });
    return database;
  }

  // POSTS CRUID ---------------------------------------

  insertNewPost(Post post) async {
    int rowIndex =
        await _database!.insert(PostsTable.postsTableName, await post.toMap());
    print(rowIndex.toString());
    selectAllPosts();
  }

  selectAllPosts() async {
    List<Map<String, Object?>> rowsAsMaps = await _database!.query(
      PostsTable.postsTableName,
    );

    posts = rowsAsMaps.map((e) => Post.fromMap(e)).toList();
    dueSoonPosts();
    notifyListeners();
  }

  selectOnePost(int id) {
    _database!.query(PostsTable.postsTableName,
        where: '${PostsTable.idColumName}=?', whereArgs: [id]);
  }

  updateOnePost(Post post) async {
    int count = await _database!.update(PostsTable.idColumName, post.toMap(),
        where: '${PostsTable.idColumName}=?', whereArgs: [post.id]);
    print(count.toString());
  }

  deleteOnePost(int id) {
    _database!.delete(PostsTable.postsTableName,
        where: '${PostsTable.idColumName}=?', whereArgs: [id]);
    selectAllPosts();
  }
  //--------------------------------------------------
  // POSTS CRUID ---------------------------------------

  dueSoonPosts() {
    List<Post> listOfPosts_ = posts!.where((element) {
      return element.isTimed;
    }).toList();

    listOfPosts_.sort(((a, b) {
      return a.dueOn!.compareTo(b.dueOn!);
    }));

    listOfPosts_.length > 4
        ? listOfPosts_ = listOfPosts_.sublist(0, 4)
        : listOfPosts_ = listOfPosts_;

    posts_due_soon = listOfPosts_;
  }
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
