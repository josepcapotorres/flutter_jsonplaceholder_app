import 'dart:convert';

import 'package:jsonplaceholder_app/helpers/webservice_helper.dart';
import 'package:jsonplaceholder_app/models/album_model.dart';
import 'package:jsonplaceholder_app/models/album_photo_model.dart';

class AlbumsProvider {
  Future<List<AlbumModel>> getUserAlbums(int userId) async {
    final String wsRes = await WebserviceHelper.get("/users/$userId/albums");
    final List albumsList = jsonDecode(wsRes);

    return albumsList.map((e) => AlbumModel.fromMap(e)).toList();
  }

  Future<List<AlbumPhotoModel>> getAlbumPhotos(int albumId) async {
    final wsRes = await WebserviceHelper.get("/albums/$albumId/photos");
    final List photosList = jsonDecode(wsRes);

    return photosList.map((e) => AlbumPhotoModel.fromMap(e)).toList();
  }
}
