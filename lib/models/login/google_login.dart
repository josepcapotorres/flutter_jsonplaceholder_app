import 'package:jsonplaceholder_app/interfaces/ILogeable.dart';

class GoogleLogin implements ILoggeable {
  @override
  Future<bool> login() async {
    print("Google login done!");

    return true;
  }
}
