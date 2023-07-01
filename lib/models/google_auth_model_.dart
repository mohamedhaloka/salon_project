class GoogleDataModel {
  String? token;
  User? user;

  GoogleDataModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? phone;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
  }
}
