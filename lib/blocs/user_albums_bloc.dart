import 'dart:async';

import 'package:jsonplaceholder_app/models/album_model.dart';
import 'package:jsonplaceholder_app/models/album_photo_model.dart';
import 'package:jsonplaceholder_app/providers/albums_provider.dart';

class UserAlbumsBloc {
  static final _instance = UserAlbumsBloc._internal();
  final _albumsProvider = AlbumsProvider();

  final _userAlbumsController = StreamController<List<AlbumModel>>.broadcast();
  Stream<List<AlbumModel>> get userAlbumsStream => _userAlbumsController.stream;

  final _albumPhotosController =
      StreamController<List<AlbumPhotoModel>>.broadcast();
  Stream<List<AlbumPhotoModel>> get albumPhotosStream =>
      _albumPhotosController.stream;

  UserAlbumsBloc._internal();
  factory UserAlbumsBloc() => _instance;

  Future getUserAlbums(int userId) async {
    final List<AlbumModel> albumsList =
        await _albumsProvider.getUserAlbums(userId);

    _userAlbumsController.sink.add(albumsList);
  }

  Future getAlbumPhotos(int albumId) async {
    final albumPhotosList = await _albumsProvider.getAlbumPhotos(albumId);

    _albumPhotosController.sink.add(albumPhotosList);
  }

  dispose() {
    _userAlbumsController?.close();
    _albumPhotosController?.close();
  }
}
