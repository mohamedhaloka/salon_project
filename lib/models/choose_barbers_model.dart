class ChooseBarberModel {
  BarberItemModel? data;
  int? status;
  String? message;

  ChooseBarberModel.fromJson(Map<String, dynamic> json) {
    data =
        (json['data'] != null ? BarberItemModel.fromJson(json['data']) : null)!;
    status = json['status'];
    message = json['message'];
  }
}

class BarberItemModel {
  int? id;
  int? type;
  String? name;
  String? phone;
  String? email;
  String? image;

  BarberItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }
}
