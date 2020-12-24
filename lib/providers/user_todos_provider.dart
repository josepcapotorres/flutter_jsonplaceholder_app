import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/user_todos_model.dart';

class UserTodosProvider {
  Future<List<UserTodosModel>> getUserTodos(int userId) async {
    final wsRes = await WebserviceHelper.get("/users/$userId/todos");
    final List todosList = jsonDecode(wsRes);

    return todosList.map((e) => UserTodosModel.fromMap(e)).toList();
  }
}
