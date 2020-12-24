import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/bloc/posts_bloc.dart';
import 'package:jsonplaceholder_app/models/post_model.dart';
import 'package:jsonplaceholder_app/views/posts_comments_view.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

class UserPostsView extends StatelessWidget {
  static const routeName = "user_posts_view";
  final _postsBloc = PostsBloc();
  bool _requestExecuted = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    if (!_requestExecuted) {
      _postsBloc.getUserPosts(args["user_id"]);
      _requestExecuted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(title: "User xxx posts"),
      body: StreamBuilder(
        stream: _postsBloc.postsStream,
        builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data[i].title),
                      subtitle: Text(snapshot.data[i].body),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          PostsCommentsView.routeName,
                          arguments: {
                            "post_id": snapshot.data[i].id
                          }
                        );
                      },
                    ),
                  );
                },
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
