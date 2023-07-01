
class ChooseServices {
  bool? status;
  String? message;
  Data ?data;


  ChooseServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =  Data.fromJson(json['data']) ;
  }

}
class Data {
  String? serviceId;
  int ?customerId;
  String? barberId;
  String ?date;


  Data.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    customerId = json['customer_id'];
    barberId = json['barber_id'];
    date = json['date'];
    // updatedAt = json['updated_at'];
    // createdAt = json['created_at'];
    // id = json['id'];
  }
}