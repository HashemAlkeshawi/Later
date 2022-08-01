import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../classes/post.dart';

class DbHelper {
  DbHelper._();
  static DbHelper db = DbHelper._();

  Database? _database;

  initDatabase() async {
    _database = await createConnectionWithDatabase();
    print("initiated");
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
  ${PostsTable.isEditedColumName} INTEGER,
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

  Future<List<Post>> selectAllPosts() async {
    List<Map<String, Object?>> rowsAsMaps = await _database!.query(
      PostsTable.postsTableName,
    );

    return rowsAsMaps.map((e) => Post.fromMap(e)).toList();
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

  deleteOnePost(int id) async {
    _database!.delete(PostsTable.postsTableName,
        where: '${PostsTable.idColumName}=?', whereArgs: [id]);
    await selectAllPosts();
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
  static const String isEditedColumName = 'isEdited';
  static const String feelingColumName = 'feeling';
  static const String typeColumName = 'type';
}
