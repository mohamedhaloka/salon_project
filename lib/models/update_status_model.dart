class UpdateStatus {
  bool? status;
  String? message;
  Data? data;


  UpdateStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int ?id;
  int? customerId;
  String? barberId;
  String? appointmentId;
  String? serviceId;
  String? bookingDate;
  int ?status;
  String ?requirements;
  String ?createdAt;
  String? updatedAt;



  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    barberId = json['barber_id'];
    appointmentId = json['appointment_id'];
    serviceId = json['service_id'];
    bookingDate = json['booking_date'];
    status = json['status'];
    requirements = json['requirements'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}