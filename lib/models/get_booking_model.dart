import 'package:salon_app/models/choose_barbers_model.dart';
import 'package:salon_app/models/get_service_model.dart';

import 'appointment_model.dart';

class BookingModel {
  List<BookingItemData>? data;
  bool? status;
  String? message;

  BookingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookingItemData>[];
      json['data'].forEach((v) {
        data!.add(BookingItemData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }
}

class BookingItemData {
  int? id;
  int? customerId;
  BarberItemModel? barber;
  AppointmentModel? appointment;
  ServiceData? service;
  String? bookingDate;
  String? requirements;
  int? status;

  BookingItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    barber = json['barber'] == null
        ? null
        : BarberItemModel.fromJson(json['barber']);
    appointment = json['appointment'] == null
        ? null
        : AppointmentModel.fromJson(json['appointment']);
    service =
        json['service'] == null ? null : ServiceData.fromJson(json['service']);
    bookingDate = json['booking_date'];
    requirements = json['requirements'];
    status = json['status'];
  }
}
