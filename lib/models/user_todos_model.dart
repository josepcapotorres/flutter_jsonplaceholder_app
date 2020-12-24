class UserTodosModel {
  int userId;
  int id;
  String title;
  bool completed;

  UserTodosModel.fromMap(Map<String, dynamic> map){
    userId = map["userId"];
    id = map["id"];
    title = map["title"];
    completed = map["completed"];
  }
}
