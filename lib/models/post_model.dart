class PostModel {
  int userId;
  int postId;
  int id;
  String title;
  String body;

  PostModel.fromMap(Map<String, dynamic> map) {
    userId = map["userId"];
    postId = map["id"] == null ? map["postId"] : map["id"];
    title = map["title"];
    body = map["body"];
  }

  Map<String, dynamic> toMap() => {
        "postId": postId,
        "userId": userId,
        "title": title,
        "body": body,
      };
}
