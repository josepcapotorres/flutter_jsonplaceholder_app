import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();
  SharedPreferences _preferences;

  initPreferences() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  bool get userLogged => _preferences.getBool('user_logged') ?? false;

  set userLogged(bool userLogged) => _preferences.setBool('user_logged', userLogged);
}
