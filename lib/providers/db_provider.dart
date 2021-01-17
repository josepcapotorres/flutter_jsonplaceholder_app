import 'dart:io';
import 'package:jsonplaceholder_app/models/album_model.dart';
import 'package:jsonplaceholder_app/models/comment_model.dart';
import 'package:jsonplaceholder_app/models/post_model.dart';
import 'package:jsonplaceholder_app/models/user_model.dart';
import 'package:jsonplaceholder_app/models/user_todos_model.dart';
import 'package:jsonplaceholder_app/widgets/custom_toast.dart';
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
    return await openDatabase(path, version: 3, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS user (
          id INTEGER PRIMARY KEY,
          idUser INTEGER,
          name TEXT,
          email TEXT,
          phone TEXT
        );
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS post (
          id INTEGER PRIMARY KEY,
          postId INTEGER,
          userId INTEGER,
          title TEXT,
          body TEXT,
          FOREIGN KEY (userId) REFERENCES user(idUser)
        );
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS comment (
          id INTEGER PRIMARY KEY,
          commentId INTEGER,
          postId INTEGER,
          name TEXT,
          email TEXT,
          body TEXT,
          FOREIGN KEY (postId) REFERENCES post(postId)
        );
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS todo (
          id INTEGER PRIMARY KEY,
          todoId INTEGER,
          userId INTEGER,
          title TEXT,
          completed INTEGER,
          FOREIGN KEY (userId) REFERENCES user(userId)
        );
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS album (
          id INTEGER PRIMARY KEY,
          albumId INTEGER,
          userId INTEGER,
          title TEXT,
          FOREIGN KEY (userId) REFERENCES user(userId)
        );
      ''');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < newVersion) {
        await db.execute("""
          ALTER TABLE user ADD COLUMN idUser INTEGER PRIMARY KEY;
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
    final res =
        await db.query("user", where: "idUser = ?", whereArgs: [userId]);

    return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
  }

  Future<int> newUser(UserModel newUser) async {
    int res;
    final db = await database;

    final UserModel userOnDb = await getUserById(newUser.idUser);

    if (userOnDb == null) {
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
        final UserModel userOnDb = await getUserById(e.idUser);

        if (userOnDb == null) {
          await db.insert("user", e.toMap());
        }
      } catch (e) {
        CustomToast("Exception found: ${e.toString()}");
        return;
      }
    });
  }

  Future<List<PostModel>> getPosts(int userId) async {
    final db = await database;
    final res =
        await db.query("post", where: "userId = ?", whereArgs: [userId]);

    return res.isNotEmpty
        ? res.map((e) => PostModel.fromMap(e)).toList()
        : null;
  }

  Future<PostModel> getPostById(int postId) async {
    final db = await database;
    final res =
        await db.query("post", where: "postId = ?", whereArgs: [postId]);

    return res.isNotEmpty ? PostModel.fromMap(res.first) : null;
  }

  Future<void> newPosts(List<PostModel> newPosts) async {
    final db = await database;

    newPosts.forEach((e) async {
      try {
        final PostModel postOnDb = await getPostById(e.postId);

        if (postOnDb == null) {
          // Not found on the database
          await db.insert("post", e.toMap());
        }
      } catch (e) {
        CustomToast("Exception found: ${e.toString()}");
        return;
      }
    });
  }

  Future<int> newPost(PostModel newPost) async {
    int res;
    final db = await database;

    final PostModel postOnDb = await getPostById(newPost.postId);

    if (postOnDb == null) {
      // Not found on the database
      res = await db.insert("post", newPost.toMap());
    } else {
      res = 0;
    }

    return res;
  }

  Future<List<CommentModel>> getPostComments(int postId) async {
    final db = await database;
    final res =
        await db.query("comment", where: "postId = ?", whereArgs: [postId]);

    return res.isNotEmpty
        ? res.map((e) => CommentModel.fromMap(e)).toList()
        : null;
  }

  Future<void> newPostComments(List<CommentModel> newPostComments) async {
    final db = await database;

    newPostComments.forEach((e) async {
      try {
        final CommentModel commentOnDb = await getCommentById(e.commentId);

        if (commentOnDb == null) {
          // Not found on the database
          await db.insert("comment", e.toMap());
        }
      } catch (e) {
        CustomToast("Exception found: ${e.toString()}");
        return;
      }
    });
  }

  Future<CommentModel> getCommentById(int commentId) async {
    final db = await database;

    final res = await db.query(
      "comment",
      where: "commentId = ?",
      whereArgs: [commentId],
    );

    return res.isNotEmpty ? CommentModel.fromMap(res.first) : null;
  }

  Future<List<UserTodosModel>> getUserTodos(int userId) async {
    final db = await database;
    final res =
        await db.query("todo", where: "userId = ?", whereArgs: [userId]);

    return res.isNotEmpty
        ? res.map((e) => UserTodosModel.fromMap(e)).toList()
        : null;
  }

  Future<UserTodosModel> getUserTodosById(int todoId) async {
    final db = await database;
    final res =
        await db.query("todo", where: "todoId = ?", whereArgs: [todoId]);

    return res.isNotEmpty ? UserTodosModel.fromMap(res.first) : null;
  }

  Future<void> newUserTodos(List<UserTodosModel> newUserTodos) async {
    final db = await database;

    newUserTodos.forEach((e) async {
      try {
        final UserTodosModel todoOnDb = await getUserTodosById(e.todoId);

        if (todoOnDb == null) {
          // Not found on the database. It needs to be inserted
          await db.insert("todo", e.toMap());
        }
      } catch (e) {
        CustomToast("Exception found: ${e.toString()}");
        return;
      }
    });
  }

  Future<List<AlbumModel>> getUserAlbums(int userId) async {
    final db = await database;
    final res =
        await db.query("album", where: "userId = ?", whereArgs: [userId]);

    return res.isNotEmpty
        ? res.map((e) => AlbumModel.fromMap(e)).toList()
        : null;
  }

  Future<void> newUserAlbums(List<AlbumModel> newUserAlbums) async {
    final db = await database;

    newUserAlbums.forEach((e) async {
      try {
        final AlbumModel albumOnDb = await getUserAlbumsById(e.albumId);

        if (albumOnDb == null) {
          // Not found on the database. It needs to be inserted
          await db.insert("album", e.toMap());
        }
      } catch (e) {
        CustomToast("Exception found: ${e.toString()}");
        return;
      }
    });
  }

  Future<AlbumModel> getUserAlbumsById(int albumId) async {
    final db = await database;
    final res =
        await db.query("album", where: "albumId = ?", whereArgs: [albumId]);

    return res.isNotEmpty ? AlbumModel.fromMap(res.first) : null;
  }
}
