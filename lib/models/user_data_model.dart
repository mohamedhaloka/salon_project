class UserDataModel {
  late int id;
  late String name;
  late String email;
  late String phone ;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'] ?? '  ';
  }
}

