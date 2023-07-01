class GetChooseServices {
  bool ?status;
  String? message;
  List<Data>? data;


  GetChooseServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data =  <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }


}

class Data {
  int ?id;
  Services? services;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    services = json['services'] != null
        ? Services.fromJson(json['services'])
        : null;
  }

}

class Services {
  int? id;
  Name? name;
  Name? description;
  Name? longDescription;
  String? price;
  String? createdAt;
  String? updatedAt;



  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? Name.fromJson(json['description'])
        : null;
    longDescription = json['long_description'] != null
        ? Name.fromJson(json['long_description'])
        : null;
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

class Name {
  String? ar;
  String ?en;


  Name.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }


}