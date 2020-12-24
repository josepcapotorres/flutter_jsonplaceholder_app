import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/bloc/users_bloc.dart';
import 'package:jsonplaceholder_app/helpers/colors_helper.dart';
import 'package:jsonplaceholder_app/helpers/format_helper.dart';
import 'package:jsonplaceholder_app/models/user_model.dart';
import 'package:jsonplaceholder_app/views/user_details_view.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

class UsersView extends StatefulWidget {
  static const routeName = "users_view";

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final _userBloc = UsersBloc();
  final _userSearchController = TextEditingController();
  List<UserModel> _userList, _filteredUserList;

  @override
  void initState() {
    super.initState();

    _userBloc.getUsers();
    _userList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Users list",
      ),
      body: RefreshIndicator(
        onRefresh: () => _userBloc.forceGetUsers(), // It forces to download the last news
        child: StreamBuilder(
          stream: _userBloc.usersStream,
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                _userList = snapshot.data;

                if (_userSearchController.text.isEmpty) {
                  _filteredUserList = _userList;
                } else {
                  List<String> searchWords =
                      _userSearchController.text.split(" ");
                  Iterable<UserModel> it = Iterable.castFrom(_userList);

                  // Be able to filter all the users by
                  // many words on the filter search bar
                  for (String currWord in searchWords) {
                    it = it.where((e) => FormatHelper.replaceCommonChars(e.name)
                        .trim()
                        .toLowerCase()
                        .contains(
                          FormatHelper.replaceCommonChars(
                              currWord.trim().toLowerCase()),
                        ));
                  }

                  _filteredUserList = it.toList();
                }

                if (_filteredUserList.isNotEmpty) {
                  // Sort users alphabetically
                  _filteredUserList.sort((a, b) => a.name.compareTo(b.name));
                }

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search user",
                        ),
                        controller: _userSearchController,
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                      Expanded(
                        child: _filteredUserList.isEmpty
                            ? _NoUsersFound()
                            : _UsersListView(_filteredUserList),
                      ),
                    ],
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
      ),
    );
  }
}

class _UsersListItem extends StatelessWidget {
  final String title;
  final Function onTap;

  _UsersListItem({
    @required this.title,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: ColorsHelper.buttonBackgroundColor,
        child: Icon(Icons.person),
      ),
      //Icon(Icons.person),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }
}

class _NoUsersFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("No users found"),
      ),
    );
  }
}

class _UsersListView extends StatelessWidget {
  final List<UserModel> _filteredUserList;

  _UsersListView(this._filteredUserList);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _filteredUserList.length,
      separatorBuilder: (_, i) => Divider(),
      itemBuilder: (_, i) => _UsersListItem(
        title: _filteredUserList[i].name,
        onTap: () {
          Navigator.pushNamed(
            context,
            UserDetailsView.routeName,
            arguments: {
              "user_id": _filteredUserList[i].id,
              "user_name": _filteredUserList[i].name,
            },
          );
        },
      ),
    );
  }
}
