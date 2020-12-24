class CommentModel {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentModel.fromMap(Map<String, dynamic> map){
    postId = map["postId"];
    id = map["id"];
    name = map["name"];
    email = map["email"];
    body = map["body"];
  }
}
