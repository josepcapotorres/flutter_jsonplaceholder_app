import 'dart:async';

import 'package:jsonplaceholder_app/models/post_model.dart';
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
    List<PostModel> postsList = await _postsProvider.getUserPosts(userId);
    
    _postsController.sink.add(postsList);
  }

  Future getUserPost(int userId, int postId) async {
    PostModel postData = await _postsProvider.getUserPostById(userId, postId);

    _postController.sink.add(postData);
  }

  dispose() {
    _postsController?.close();
    _postController?.close();
  }
}
