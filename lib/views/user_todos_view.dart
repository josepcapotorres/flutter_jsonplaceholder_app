import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/bloc/user_todos_bloc.dart';
import 'package:jsonplaceholder_app/models/user_todos_model.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

class UserTodosView extends StatefulWidget {
  static const routeName = "user_todos_view";

  @override
  _UserTodosViewState createState() => _UserTodosViewState();
}

class _UserTodosViewState extends State<UserTodosView> {
  final _userTodosBloc = UserTodosBloc();
  bool _requestExecuted = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final userName = args.containsKey("user_name") ? args["user_name"] : "";

    if (!_requestExecuted) {
      _userTodosBloc.getUserTodos(args["user_id"]);
      _requestExecuted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(title: "$userName TODOs"),
      body: StreamBuilder(
        stream: _userTodosBloc.userTodosStream,
        builder: (_, AsyncSnapshot<List<UserTodosModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (_, i) => Divider(),
                itemBuilder: (_, i) => CheckboxListTile(
                  title: Text(snapshot.data[i].title),
                  value: snapshot.data[i].completed,
                  onChanged: (val) {
                    setState(() {
                      snapshot.data[i].completed = !snapshot.data[i].completed;
                    });
                  },
                ),
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
}
