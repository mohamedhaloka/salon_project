class AppointmentModel {
  int id;
  String appointStart;
  String appointEnd;
  String barberName;
  DateTime appointmentDate;

  AppointmentModel({
    required this.id,
    required this.appointStart,
    required this.appointEnd,
    required this.barberName,
    required this.appointmentDate,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json["id"],
        appointStart: json["appoint_start"],
        appointEnd: json["appoint_end"],
        barberName: json["barber_name"],
        appointmentDate: DateTime.parse(json["appointment_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appoint_start": appointStart,
        "appoint_end": appointEnd,
        "barber_name": barberName,
        "appointment_date":
            "${appointmentDate.year.toString().padLeft(4, '0')}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}",
      };
}
