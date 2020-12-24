import 'dart:async';

import 'package:jsonplaceholder_app/models/user_todos_model.dart';
import 'package:jsonplaceholder_app/providers/user_todos_provider.dart';

class UserTodosBloc {
  static final _instance = UserTodosBloc._internal();
  final _userTodosProvider = UserTodosProvider();

  final _userTodosController =
      StreamController<List<UserTodosModel>>.broadcast();
  Stream<List<UserTodosModel>> get userTodosStream =>
      _userTodosController.stream;

  UserTodosBloc._internal();
  factory UserTodosBloc() => _instance;

  Future getUserTodos(int userId) async {
    final userTodosList = await _userTodosProvider.getUserTodos(userId);

    _userTodosController.sink.add(userTodosList);
  }

  dispose() {
    _userTodosController?.close();
  }
}
