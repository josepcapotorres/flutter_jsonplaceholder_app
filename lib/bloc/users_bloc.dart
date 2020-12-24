import 'dart:async';

import 'package:jsonplaceholder_app/models/user_model.dart';
import 'package:jsonplaceholder_app/providers/db_provider.dart';
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
    List<UserModel> usersList = await DBProvider.db.getUsers();

    if (usersList == null || usersList.isEmpty) {
      // If no results found, fetch them from the API
      usersList = await _usersProvider.getUsers();
      DBProvider.db.newUsers(usersList);
    }

    _usersController.sink.add(usersList);
  }

  Future getUser(int userId) async {
    UserModel userData = await DBProvider.db.getUserById(userId);

    if (userData == null) {
      // If no result found, fetch it from the API
      userData = await _usersProvider.getUser(userId);
      DBProvider.db.newUser(userData);
    }

    _userController.sink.add(userData);
  }

  Future forceGetUsers() async {
    List<UserModel> usersList = await _usersProvider.getUsers();

    DBProvider.db.newUsers(usersList);

    _usersController.sink.add(usersList);
  }

  dispose() {
    _usersController?.close();
    _userController?.close();
  }
}
