import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/comment_model.dart';

class CommentsProvider {
  Future<List<CommentModel>> getPostComments(int postId) async {
    final wsRes = await WebserviceHelper.get("/posts/$postId/comments");
    final List postsList = jsonDecode(wsRes);

    return postsList.map((e) => CommentModel.fromMap(e)).toList();
  }
}
