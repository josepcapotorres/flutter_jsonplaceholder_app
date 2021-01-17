import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/blocs/post_comments_bloc.dart';
import 'package:jsonplaceholder_app/models/comment_model.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

class PostCommentsView extends StatefulWidget {
  static const routeName = "post_comments_view";

  @override
  _PostCommentsViewState createState() => _PostCommentsViewState();
}

class _PostCommentsViewState extends State<PostCommentsView> {
  final _postCommentsBloc = PostCommentsBloc();
  bool _requestExecuted = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final userName = args.containsKey("user_name") ? args["user_name"] : "";
    final postId = args.containsKey("post_id") ? args["post_id"] : 0;

    if (!_requestExecuted) {
          _postCommentsBloc.getPostComments(postId);
      _requestExecuted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(title: "User $userName post comments"),
      body: StreamBuilder(
        stream: _postCommentsBloc.commentsStream,
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
