import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/comment_model.dart';

import 'db_provider.dart';

class CommentsProvider {
  Future<List<CommentModel>> getPostComments(int postId) async {
    List<CommentModel> commentsList =
        await DBProvider.db.getPostComments(postId);

    if (commentsList == null || commentsList.isEmpty) {
      // If no results found, fetch them from the API
      commentsList = await getPostCommentsFromApi(postId);
      DBProvider.db.newPostComments(commentsList);
    }

    return commentsList;
  }

  Future<List<CommentModel>> getPostCommentsFromApi(int postId) async {
    final wsRes = await WebserviceHelper.get("/posts/$postId/comments");
    final List postsList = jsonDecode(wsRes);

    return postsList.map((e) => CommentModel.fromMap(e)).toList();
  }
}
