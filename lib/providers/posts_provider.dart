import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/post_model.dart';

class PostsProvider {
  Future<List<PostModel>> getUserPosts(int userId) async {
    final String wsRes = await WebserviceHelper.get("/users/$userId/posts");
    final List postsList = jsonDecode(wsRes);

    return postsList.map((e) => PostModel.fromMap(e)).toList();
  }

  Future<PostModel> getUserPostById(int userId, int postId) async {
    final String wsRes = await WebserviceHelper.get("/users/$userId/posts/$postId");
    final Map<String, dynamic> postMap = jsonDecode(wsRes);

    return PostModel.fromMap(postMap);
  }
}
