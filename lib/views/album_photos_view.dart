import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/blocs/user_albums_bloc.dart';
import 'package:jsonplaceholder_app/models/album_photo_model.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_no_results.dart';

class AlbumPhotosView extends StatefulWidget {
  static const String routeName = "album_photos_view";

  @override
  _AlbumPhotosViewState createState() => _AlbumPhotosViewState();
}

class _AlbumPhotosViewState extends State<AlbumPhotosView> {
  final _albumsBloc = UserAlbumsBloc();
  bool _requestExecuted = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    if (!_requestExecuted) {
      _albumsBloc.getAlbumPhotos(args["album_id"]);
      _requestExecuted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Album photos"),
      body: StreamBuilder(
        stream: _albumsBloc.albumPhotosStream,
        builder: (_, AsyncSnapshot<List<AlbumPhotoModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return GridView.count(
                crossAxisCount: 2,
                children:
                    snapshot.data.map((e) => _AlbumPhotoView(e.title)).toList(),
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

class _AlbumPhotoView extends StatelessWidget {
  final String title;

  _AlbumPhotoView(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                "https://image.shutterstock.com/image-vector/beautiful-village-farmlands-trees-meadows-260nw-718204132.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              this.title,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
