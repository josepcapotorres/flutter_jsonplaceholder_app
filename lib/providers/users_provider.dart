import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/user_model.dart';

class UserProvider {
  Future<List<UserModel>> getUsers() async {
    final String wsRes = await WebserviceHelper.get("/users");
    final List usersList = jsonDecode(wsRes);

    return usersList.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<UserModel> getUser(int userId) async {
    final String wsRes = await WebserviceHelper.get("/users/$userId");
    final Map<String, dynamic> userMap = jsonDecode(wsRes);

    return UserModel.fromMap(userMap);
  }
}
