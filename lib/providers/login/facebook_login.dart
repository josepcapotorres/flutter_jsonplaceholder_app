import 'package:jsonplaceholder_app/interfaces/ILogeable.dart';

class FacebookLogin implements ILoggeable {
  @override
  Future<bool> login(String email, String password) async {
    print("Facebook login done!");

    return true;
  }
}
