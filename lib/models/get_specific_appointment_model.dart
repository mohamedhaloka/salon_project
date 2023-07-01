class SpecificAppointmentModel {
  bool? status;
  String? message;
  Data? data;


  SpecificAppointmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? id;
  String? appointStart;
  String? appointEnd;
  String? barberName;
  int? status;
  String? createdAt;
  String? updatedAt;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointStart = json['appoint_start'];
    appointEnd = json['appoint_end'];
    barberName = json['barber_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}