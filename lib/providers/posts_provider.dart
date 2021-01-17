import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/post_model.dart';
import 'package:jsonplaceholder_app/providers/db_provider.dart';

class PostsProvider {
  Future<List<PostModel>> getUserPosts(int userId) async {
    List<PostModel> postsList = await DBProvider.db.getPosts(userId);

    if (postsList == null || postsList.isEmpty) {
      // If no results found, fetch them from the API
      postsList = await getUserPostsFromApi(userId);
      DBProvider.db.newPosts(postsList);
    }

    return postsList;
  }

  Future<List<PostModel>> getUserPostsFromApi(int userId) async {
    final String wsRes = await WebserviceHelper.get("/users/$userId/posts");
    final List postsList = jsonDecode(wsRes);

    return postsList.map((e) => PostModel.fromMap(e)).toList();
  }

  Future<PostModel> getUserPostById(int userId, int postId) async {
    PostModel postData = await DBProvider.db.getPostById(postId);

    if (postData == null) {
      postData = await getUserPostByIdFromApi(userId, postId);
      DBProvider.db.newPost(postData);
    }

    return postData;
  }

  Future<PostModel> getUserPostByIdFromApi(int userId, int postId) async {
    final String wsRes =
        await WebserviceHelper.get("/users/$userId/posts/$postId");
    final Map<String, dynamic> postMap = jsonDecode(wsRes);

    return PostModel.fromMap(postMap);
  }
}
