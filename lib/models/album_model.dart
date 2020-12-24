class AlbumModel {
  int userId;
  int id;
  String title;

  AlbumModel.fromMap(Map<String, dynamic> map){
    userId = map["userId"];
    id = map["id"];
    title = map["title"];
  }
}
