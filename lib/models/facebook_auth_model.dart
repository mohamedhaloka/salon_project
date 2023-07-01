class FaceLoginModel {
  String? token;
  User? user;

  FaceLoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? type;
  String? phone;
  String? email;
  String? image;

  User.fromJson(Map<String, dynamic> json) {
    id = (json['id']);
    name = (json['name']);
    type = (json['type']);
    phone = (json['phone']);
    email = (json['email']);
    image = (json['image']);
  }
}
