class CommentModel {
  int postId;
  int id;
  int commentId;
  String name;
  String email;
  String body;

  CommentModel.fromMap(Map<String, dynamic> map) {
    postId = map["postId"];
    commentId = map["id"] == null ? map["commentId"] : map["id"];
    name = map["name"];
    email = map["email"];
    body = map["body"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "commentId": commentId,
        "postId": postId,
        "name": name,
        "email": email,
        "body": body,
      };
}
