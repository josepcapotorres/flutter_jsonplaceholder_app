import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/helpers/colors_helper.dart';
import 'package:jsonplaceholder_app/routes/routes.dart';
import 'package:jsonplaceholder_app/shared_prefs/user_preferences.dart';
import 'package:jsonplaceholder_app/views/users_view.dart';

import 'views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = new UserPreferences();
  await preferences.initPreferences();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _userPrefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JsonPlaceholderApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorsHelper.primaryColor,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: _userPrefs.userLogged ? UsersView.routeName : LoginView.routeName,
      routes: getApplicationRoutes(),
    );
  }
}
