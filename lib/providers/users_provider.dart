import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/user_model.dart';

import 'db_provider.dart';

class UserProvider {
  Future<List<UserModel>> getUsers() async {
    List<UserModel> usersList = await DBProvider.db.getUsers();

    if (usersList == null || usersList.isEmpty) {
      // If no results found, fetch them from the API
      usersList = await getUsersFromApi();
      DBProvider.db.newUsers(usersList);
    }

    return usersList;
  }

  Future<List<UserModel>> getUsersFromApi() async {
    final String wsRes = await WebserviceHelper.get("/users");
    final List usersList = jsonDecode(wsRes);

    return usersList.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<List<UserModel>> forceDownloadUsers() async {
    final List<UserModel> usersList = await getUsersFromApi();

    DBProvider.db.newUsers(usersList);

    return usersList;
  }

  Future<UserModel> getUserById(int userId) async {
    UserModel userData = await DBProvider.db.getUserById(userId);

    if (userData == null) {
      // If no result found, fetch it from the API
      userData = await getUserFromApi(userId);
      DBProvider.db.newUser(userData);
    }

    return userData;
  }

  Future<UserModel> getUserFromApi(int userId) async {
    final String wsRes = await WebserviceHelper.get("/users/$userId");
    final Map<String, dynamic> userMap = jsonDecode(wsRes);

    return UserModel.fromMap(userMap);
  }
}
