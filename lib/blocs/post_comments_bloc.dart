import 'dart:async';

import 'package:jsonplaceholder_app/models/comment_model.dart';
import 'package:jsonplaceholder_app/providers/posts_comments_provider.dart';

class PostCommentsBloc {
  static final _instance = PostCommentsBloc._internal();
  final _commentsProvider = CommentsProvider();

  final _commentsController = StreamController<List<CommentModel>>.broadcast();
  Stream<List<CommentModel>> get commentsStream => _commentsController.stream;

  PostCommentsBloc._internal();

  factory PostCommentsBloc() => _instance;

  Future getPostComments(int postId) async {
    List<CommentModel> commentsList = await _commentsProvider.getPostComments(postId);

    _commentsController.sink.add(commentsList);
  }

  dispose() {
    _commentsController?.close();
  }
}
