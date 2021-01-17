import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/user_todos_model.dart';

import 'db_provider.dart';

class UserTodosProvider {
  Future<List<UserTodosModel>> getUserTodos(int userId) async {
    List<UserTodosModel> userTodosList = await getUserTodosFromDb(userId);

    if (userTodosList == null || userTodosList.isEmpty) {
      userTodosList = await getUserTodosFromApi(userId);

      await DBProvider.db.newUserTodos(userTodosList);
    }

    return userTodosList;
  }

  Future<List<UserTodosModel>> getUserTodosFromDb(int userId) async {
    List<UserTodosModel> userTodosList =
        await DBProvider.db.getUserTodos(userId);

    return userTodosList;
  }

  Future<List<UserTodosModel>> getUserTodosFromApi(int userId) async {
    final wsRes = await WebserviceHelper.get("/users/$userId/todos");
    final List todosList = jsonDecode(wsRes);

    return todosList.map((e) => UserTodosModel.fromMap(e)).toList();
  }
}
