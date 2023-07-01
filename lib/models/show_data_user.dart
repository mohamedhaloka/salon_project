class ShowDataUser {
  int ?id;
  String? name;
  String? type;
  String? phone;
  String? email;
  String ?image;


  ShowDataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    phone = json['phone']??'';
    email = json['email'];
    image = json['image'];
  }

}