class GetServicesModel {
  bool? status;
  String? message;
  List<ServiceData>? data;

  GetServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(ServiceData.fromJson(v));
      });
    }
  }
}

class ServiceData {
  int? id;
  Name? name;
  Name? description;
  Name? longDescription;
  String? price;
  Barber? barber;
  String? createdAt;
  String? updatedAt;

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = (json['name'] != null ? Name.fromJson(json['name']) : null)!;
    description = (json['description'] != null
        ? Name.fromJson(json['description'])
        : null)!;
    longDescription = (json['long_description'] != null
        ? Name.fromJson(json['long_description'])
        : null)!;
    price = json['price'];
    barber = (json['barber'] != null ? Barber.fromJson(json['barber']) : null);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  bool operator ==(Object other) {
    return (other is ServiceData) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Name {
  String? ar;
  String? en;

  Name.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }
}

class Barber {
  int? id;
  String? name;
  String? type;
  String? phone;
  String? email;
  String? image;

  Barber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }
}
