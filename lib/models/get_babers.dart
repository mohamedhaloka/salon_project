class BarberItemData {
  int? id;
  String? name;
  String? phone;
  String? image;
  String? email;

  BarberItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
  }
}
