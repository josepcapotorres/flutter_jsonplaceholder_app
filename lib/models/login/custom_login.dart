import 'package:jsonplaceholder_app/interfaces/ILogeable.dart';

class CustomLogin implements ILoggeable {
  @override
  Future<bool> login() async {
    print("Custom Login done!");

    return true;
  }
}
