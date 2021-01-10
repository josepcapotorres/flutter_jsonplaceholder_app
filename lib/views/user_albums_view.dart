import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/bloc/user_albums_bloc.dart';
import 'package:jsonplaceholder_app/models/album_model.dart';
import 'package:jsonplaceholder_app/views/album_photos_view.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

class UserAlbumsView extends StatelessWidget {
  static const routeName = "user_albums_view";
  final _albumsBloc = UserAlbumsBloc();
  bool _requestExecuted = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final userName = args.containsKey("user_name") ? args["user_name"] : "";

    if (!_requestExecuted) {
      _albumsBloc.getUserAlbums(args["user_id"]);
      _requestExecuted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(title: "$userName albums"),
      body: StreamBuilder(
        stream: _albumsBloc.userAlbumsStream,
        builder: (context, AsyncSnapshot<List<AlbumModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (_, i) => Divider(),
                itemBuilder: (_, i) => ListTile(
                  title: Text(snapshot.data[i].title),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      AlbumPhotosView.routeName,
                      arguments: {
                        "album_id": snapshot.data[i].id
                      }
                    );
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
