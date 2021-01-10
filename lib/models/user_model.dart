class UserModel {
  //int id;
  int idUser; // id field at JsonPlaceholder
  String name;
  String userName;
  String email;
  //_Address address;
  String phone;
  String website;
  //_Company company;

  UserModel.fromMap(Map<String, dynamic> map) {
    idUser = map["id"];
    name = map["name"];
    userName = map["username"];
    email = map["email"];
    //address = _Address.fromMap(map["address"]);
    phone = map["phone"];
    website = map["website"];
    //company = _Company.fromMap(map["company"]);
  }

  Map<String, dynamic> toMap() => {
        "idUser": idUser,
        "name": name,
        "email": email,
        "phone": phone,
      };
}

class _Address {
  String street;
  String suite;
  String city;
  String zipcode;
  _Geo geo;

  _Address.fromMap(Map<String, dynamic> map) {
    street = map["street"];
    suite = map["suite"];
    city = map["city"];
    zipcode = map["zipcode"];
    geo = _Geo.fromMap(map["geo"]);
  }
}

class _Geo {
  String lat;
  String lon;

  _Geo.fromMap(Map<String, dynamic> map) {
    lat = map["lat"];
    lon = map["lon"];
  }
}

class _Company {
  String name;
  String catchPhrase;
  String bs;

  _Company.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    catchPhrase = map["catchPhrase"];
    bs = map["bs"];
  }
}
