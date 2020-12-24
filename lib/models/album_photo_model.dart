class AlbumPhotoModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  AlbumPhotoModel.fromMap(Map<String, dynamic> map){
    this.albumId = map["albumId"];
    this.id = map["id"];
    this.title = map["title"];
    this.url = map["url"];
    this.thumbnailUrl = map["thumbnailUrl"];
  }
}
