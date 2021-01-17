class UserTodosModel {
  int id;
  int userId;
  int todoId;
  String title;
  bool completed;

  UserTodosModel.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("todoId")) {
      // It comes from the DB
      todoId = map["todoId"];
      id = map["id"];
    } else {
      // It comes from the API
      todoId = map["id"];
      id = null;
    }

    title = map["title"];
    userId = map["userId"];

    if (map["completed"] is bool) {
      completed = map["completed"];
    } else if (map["completed"] is int) {
      completed = map["completed"] == 1;
    } else {
      completed = false;
    }
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "todoId": todoId,
        "title": title,
        "completed": completed ? 1 : 0,
      };
}
