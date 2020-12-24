import 'dart:async';

import 'package:jsonplaceholder_app/models/post_model.dart';
import 'package:jsonplaceholder_app/providers/db_provider.dart';
import 'package:jsonplaceholder_app/providers/posts_provider.dart';

class PostsBloc {
  static final _instance = PostsBloc._internal();
  final _postsProvider = PostsProvider();

  final _postsController = StreamController<List<PostModel>>.broadcast();
  Stream<List<PostModel>> get postsStream => _postsController.stream;

  final _postController = StreamController<PostModel>.broadcast();
  Stream<PostModel> get postStream => _postController.stream;

  PostsBloc._internal();

  factory PostsBloc() => _instance;

  Future getUserPosts(int userId) async {
    List<PostModel> postsList = await DBProvider.db.getPosts(userId);

    if (postsList == null || postsList.isEmpty) {
      // If no results found, fetch them from the API
      postsList = await _postsProvider.getUserPosts(userId);
      DBProvider.db.newPosts(postsList);
    }

    _postsController.sink.add(postsList);
  }

  Future getUserPost(int userId, int postId) async {
    PostModel postData = await DBProvider.db.getPostById(postId);

    if (postData == null) {
      // If no result found, fetch it from the API
      postData = await _postsProvider.getUserPostById(userId, postId);
      DBProvider.db.newPost(postData);
    }

    _postController.sink.add(postData);
  }

  dispose() {
    _postsController?.close();
    _postController?.close();
  }
}
