import 'dart:io';
import 'package:jsonplaceholder_app/models/post_model.dart';
import 'package:jsonplaceholder_app/models/user_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "jsonplaceholder.db");

    // Create database
    return await openDatabase(
      path, 
      version: 2, 
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE user(
          id INTEGER PRIMARY KEY,
          name TEXT,
          email TEXT,
          phone TEXT
        );
      ''');
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < newVersion){
        await db.execute("""
          CREATE TABLE IF NOT EXISTS post (
            id INTEGER PRIMARY KEY,
            userId INTEGER,
            title TEXT,
            body TEXT,
            FOREIGN KEY (userId) REFERENCES user(id)
          )
          """);
        }
    });
  }

  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final res = await db.query("user");

    return res.isNotEmpty
        ? res.map((e) => UserModel.fromMap(e)).toList()
        : null;
  }

  Future<UserModel> getUserById(int userId) async {
    final db = await database;
    final res = await db.query("user", where: "id = ?", whereArgs: [userId]);

    return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
  }

  Future<int> newUser(UserModel newUser) async {
    int res;
    final db = await database;

    final UserModel userOnDb = await getUserById(newUser.id);

    if (userOnDb == null) {
      // Not found on the database
      newUser.id = null;

      res = await db.insert("user", newUser.toMap());
    } else {
      res = 0;
    }

    return res;
  }

  Future<void> newUsers(List<UserModel> newUsers) async {
    final db = await database;

    newUsers.forEach((e) async {
      try {
        final UserModel userOnDb = await getUserById(e.id);

        if (userOnDb == null) {
          // Not found on the database
          e.id = null;

          await db.insert("user", e.toMap());
        }
      } catch (e) {
        print("Exception found: ${e.toString()}");
      }
    });
  }

  Future<List<PostModel>> getPosts(int userId) async {
    final db = await database;
    final res = await db.query("post", where: "userId = ?", whereArgs: [userId]);

    return res.isNotEmpty
        ? res.map((e) => PostModel.fromMap(e)).toList()
        : null;
  }

  Future<PostModel> getPostById(int postId) async {
    final db = await database;
    final res = await db.query("post", where: "id = ?", whereArgs: [postId]);

    return res.isNotEmpty ? PostModel.fromMap(res.first) : null;
  }

  Future<void> newPosts(List<PostModel> newPosts) async {
    final db = await database;

    newPosts.forEach((e) async {
      try {
        final PostModel postOnDb = await getPostById(e.id);

        if (postOnDb == null) {
          // Not found on the database
          e.id = null;

          await db.insert("post", e.toMap());
        }
      } catch (e) {
        print("Exception found: ${e.toString()}");
      }
    });
  }

  Future<int> newPost(PostModel newPost) async {
    int res;
    final db = await database;

    final PostModel postOnDb = await getPostById(newPost.id);

    if (postOnDb == null) {
      // Not found on the database
      postOnDb.id = null;

      res = await db.insert("post", newPost.toMap());
    } else {
      res = 0;
    }

    return res;
  }
}
