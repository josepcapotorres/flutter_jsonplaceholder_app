import 'dart:async';

import 'package:jsonplaceholder_app/models/comment_model.dart';
import 'package:jsonplaceholder_app/providers/comments_provider.dart';

class PostCommentsBloc {
  static final _instance = PostCommentsBloc._internal();
  final _commentsProvider = CommentsProvider();

  final _postCommentsController =
      StreamController<List<CommentModel>>.broadcast();
  Stream<List<CommentModel>> get postCommentsSteam =>
      _postCommentsController.stream;

  PostCommentsBloc._internal();
  factory PostCommentsBloc() => _instance;

  Future getPostComments(int postId) async {
    final List<CommentModel> postCommentsList =
        await _commentsProvider.getPostComments(postId);

    _postCommentsController.sink.add(postCommentsList);
  }

  dispose() {
    _postCommentsController?.close();
  }
}
