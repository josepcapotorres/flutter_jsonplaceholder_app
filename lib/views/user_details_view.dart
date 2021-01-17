import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/blocs/users_bloc.dart';
import 'package:jsonplaceholder_app/models/user_model.dart';
import 'package:jsonplaceholder_app/views/user_posts_view.dart';
import 'package:jsonplaceholder_app/views/user_todos_view.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

import 'user_albums_view.dart';

class UserDetailsView extends StatefulWidget {
  static const routeName = "user_details_view";

  @override
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final _userBloc = UsersBloc();
  bool _requestExecuted = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final userName = args.containsKey("user_name") ? args["user_name"] : "";
    final userId = args.containsKey("user_id") ? args["user_id"] : 0;

    if (!_requestExecuted) {
      _userBloc.getUserById(userId);
      _requestExecuted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Details about ${args['user_name']}",
        actions: [
          PopupMenuButton<int>(
            onSelected: (val) => _manageMenuOptionClick(
              context, val, args["user_id"], userName,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Posts"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Albums"),
                value: 2,
              ),
              PopupMenuItem(
                child: Text("Todos"),
                value: 3,
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _userBloc.userStream,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView(
                children: [
                  ListTile(
                    title: Text(snapshot.data.name),
                    leading: Icon(Icons.person),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(snapshot.data.email),
                    subtitle: Text("Personal"),
                    leading: Icon(Icons.mail),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(snapshot.data.phone),
                    leading: Icon(Icons.phone),
                  ),
                ],
              );
            } else {
              return CustomNoResults();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _manageMenuOptionClick(BuildContext context, int val, 
    int userId, String userName) {
    switch (val) {
      case 1:
        Navigator.pushNamed(
          context, 
          UserPostsView.routeName,
          arguments: {
            "user_id": userId,
            "user_name": userName,
          }
        );
        break;
      case 2:
        Navigator.pushNamed(
          context, 
          UserAlbumsView.routeName,
          arguments: {
            "user_id": userId,
            "user_name": userName,
          }
        );
        break;
      case 3:
      Navigator.pushNamed(
          context, 
          UserTodosView.routeName,
          arguments: {
            "user_id": userId,
            "user_name": userName,
          }
        );
        
        break;
      default:
        Navigator.pushNamed(
          context, 
          UserPostsView.routeName,
          arguments: {
            "user_id": userId,
            "user_name": userName,
          }
        );
        break;
    }
  }
}
