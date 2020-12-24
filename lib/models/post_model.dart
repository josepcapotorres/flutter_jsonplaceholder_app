class PostModel {
  int userId;
  int id;
  String title;
  String body;

  PostModel.fromMap(Map<String, dynamic> map) {
    userId = map["userId"];
    id = map["id"];
    title = map["title"];
    body = map["body"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "title": title,
        "body": body,
      };
}
