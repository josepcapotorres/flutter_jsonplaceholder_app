import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/bloc/post_comments_bloc.dart';
import 'package:jsonplaceholder_app/models/comment_model.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

class PostsCommentsView extends StatelessWidget {
  static const routeName = "posts_comments_view";
  final _postCommentsBloc = PostCommentsBloc();
  bool _requestExecuted = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    if (!_requestExecuted) {
          _postCommentsBloc.getPostComments(args["post_id"]);
      _requestExecuted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(title: "User xxx post comments"),
      body: StreamBuilder(
        stream: _postCommentsBloc.postCommentsSteam,
        builder: (context, AsyncSnapshot<List<CommentModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, i) => Card(
                  child: ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data[i].body),
                        Text(snapshot.data[i].email)
                      ],
                    ),
                  ),
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
