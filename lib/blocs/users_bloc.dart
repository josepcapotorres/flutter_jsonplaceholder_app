import 'dart:async';

import 'package:jsonplaceholder_app/models/user_model.dart';
import 'package:jsonplaceholder_app/providers/users_provider.dart';

class UsersBloc {
  static final _instance = UsersBloc._internal();
  final _usersProvider = UserProvider();

  final _usersController = StreamController<List<UserModel>>.broadcast();
  Stream<List<UserModel>> get usersStream => _usersController.stream;

  final _userController = StreamController<UserModel>.broadcast();
  Stream<UserModel> get userStream => _userController.stream;

  UsersBloc._internal();

  factory UsersBloc() => _instance;

  Future getUsers() async {
    List<UserModel> usersList = await _usersProvider.getUsers();

    _usersController.sink.add(usersList);
  }

  Future getUserById(int userId) async {
    UserModel userData = await _usersProvider.getUserById(userId);

    _userController.sink.add(userData);
  }

  Future forceGetUsers() async {
    List<UserModel> usersList = await _usersProvider.forceDownloadUsers();

    _usersController.sink.add(usersList);
  }

  dispose() {
    _usersController?.close();
    _userController?.close();
  }
}
