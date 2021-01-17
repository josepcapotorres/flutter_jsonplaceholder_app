import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/shared_prefs/user_preferences.dart';
import 'package:jsonplaceholder_app/views/login_view.dart';

class CustomDrawer extends StatelessWidget {
  final _userPrefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/icon/app_icon.jpg",
              width: 200,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log out"),
            onTap: () {
              _userPrefs.userLogged = false;
              Navigator.pushReplacementNamed(context, LoginView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
