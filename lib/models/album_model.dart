class AlbumModel {
  int userId;
  int id;
  int albumId;
  String title;

  AlbumModel.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("albumId")) {
      // It comes from the DB
      albumId = map["albumId"];
      id = map["id"];
    } else {
      // It comes from the API
      albumId = map["id"];
      id = null;
    }

    userId = map["userId"];
    title = map["title"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "albumId": albumId,
        "title": title,
      };
}
