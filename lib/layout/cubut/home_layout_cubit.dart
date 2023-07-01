import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salon_app/models/choose_barbers_model.dart';
import 'package:salon_app/models/get_babers.dart';
import 'package:salon_app/models/get_booking_model.dart';
import 'package:salon_app/models/get_choose_services.dart';
import 'package:salon_app/models/get_service_model.dart';
import 'package:salon_app/models/get_specific_appointment_model.dart';
import 'package:salon_app/shared/end_points/end_points.dart';

import '../../models/appointment_model.dart';
import '../../models/change_password.dart';
import '../../models/choose_sevices_model.dart';
import '../../models/user_data_model.dart';
import '../../shared/componants/app_constane.dart';
import '../../shared/remote_data_source/remote_data_source.dart';
import '../../utils.dart';

class HomeLayoutCubit {
  HomeLayoutCubit._();
  static HomeLayoutCubit instance = HomeLayoutCubit._();

  int currentIndex = 0;

  void changeBottom(int index) {
    currentIndex = index;
  }

  UserDataModel? userModel;

  Future<void> getUserData() async {
    await DioHelper.getData(path: profile, token: token).then((value) {
      userModel = UserDataModel.fromJson(value.data);
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
  }

  int selectedBarber = 0;
  Future<List<BarberItemData>?> getBarberData() async {
    try {
      final result = await DioHelper.getData(path: getBarber, token: token);
      return List.from(result.data['data']
          .map(
            (e) => BarberItemData.fromJson(e),
          )
          .toList());
    } catch (e) {
      if (e is DioError) {
        showAlertToast(e.response!.data.toString());
      } else {
        showAlertToast(e.toString());
      }
      return null;
    }
  }

  ChooseBarberModel? chooseBarbersModel;

  Future<String?> getChooseBarberData(int id) async {
    await DioHelper.getData(
            path: 'https://www.salon.spider-te8.com/api/barbers/$id',
            token: token)
        .then((value) async {
      chooseBarbersModel = ChooseBarberModel.fromJson(value.data);
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
    return null;
  }

  GetServicesModel? getServicesModel;

  Future<void> getServices() async {
    await DioHelper.getData(path: getService, token: token).then((value) {
      getServicesModel = GetServicesModel.fromJson(value.data);
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
  }

  ChooseServices? chooseServicesDate;

  void chooseServices({
    required String serviceId,
    required int customerId,
    required String barberId,
    required String date,
  }) {
    DioHelper.postData(
      token: token,
      path: chooseServicesData,
      data: {
        'service_id': serviceId,
        'customer_id': customerId,
        'barber_id': barberId,
        'date': date,
      },
    ).then((value) {}).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
  }

  void storesBooking({
    required String requirements,
    required int customerId,
    required int appointmentId,
    required int barberId,
    required int serviceId,
    required int status,
    required String bookingDate,
    required void Function(dynamic) onSuccess,
    required void Function() onError,
  }) async {
    await DioHelper.postData(
      path: getBooking,
      token: token,
      data: {
        'customer_id': customerId,
        'barber_id': barberId,
        'appointment_id': appointmentId,
        'service_id': serviceId,
        'booking_date': bookingDate,
        'requirements': requirements,
        'status': status,
      },
    ).then((value) {
      print(value);
      if (value.data['data'] is bool) {
        log('service is already stored');
        onSuccess(value.data['data']);
        return;
      }
      final service = BookingItemData.fromJson(value.data['data']);

      onSuccess(service);
    }).catchError((error) {
      log(error.toString(), name: 'error');
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
      onError();
    });
  }

  List<AppointmentModel> appointmentList = <AppointmentModel>[];
  Future<void> getAppointments() async {
    await DioHelper.getData(path: getAppointment, token: token).then((value) {
      List<AppointmentModel> data = <AppointmentModel>[];
      for (var appointment in value.data['data']) {
        data.add(AppointmentModel.fromJson(appointment));
      }
      appointmentList = data;
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
  }

  BookingModel? bookingModel;

  Future<void> getBookingData({
    required void Function(dynamic) onSuccess,
    required void Function() onError,
  }) async {
    await DioHelper.getData(path: getBooking, token: token).then((value) {
      bookingModel = BookingModel.fromJson(value.data);
      onSuccess(value);
    });
  }

  SpecificAppointmentModel? specificAppointmentModel;

  Future<void> getSpecificData(int id) async {
    await DioHelper.getData(
            path: 'https://www.salon.spider-te8.com/api/appointments/$id',
            token: token)
        .then((value) {
      specificAppointmentModel = SpecificAppointmentModel.fromJson(value.data);
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
  }

  GetChooseServices? getChooseServices;
  Future<void> getChooseServicesData() async {
    await DioHelper.getData(path: getChooseService, token: token).then((value) {
      getChooseServices = GetChooseServices.fromJson(value.data);
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
  }

  Future<void> getNotifications({
    required void Function(Response<dynamic>) onSuccess,
    required void Function(dynamic e) onError,
  }) async {
    try {
      final response = await DioHelper.getData(path: notify, token: token);
      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        onError(response);
      }
    } catch (e) {
      if (e is DioError) {
        showAlertToast(e.response!.data.toString());
      } else {
        showAlertToast(e.toString());
      }
      onError(e);
    }
  }

  ChangePasswordModel? changePasswordModel;

  void changePassword({
    required String email,
    required int code,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    DioHelper.postData(
      token: token,
      path: changePass,
      data: {
        'email': email,
        'code': code,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
    ).then((value) {}).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String pone,
    required String imagePath,
    required void Function(dynamic) onSuccess,
    required void Function() onError,
  }) {
    final endPoint = '$updateProfileUrl${userModel!.id}';
    DioHelper.postData(
      token: token,
      path: endPoint,
      data: {
        'name': name,
        'email': email,
        'phone': pone,
        'image': imagePath,
      },
    ).then((value) {
      onSuccess(value);
    }).catchError(
      (error) {
        print(error);
        onError();
      },
    );
  }

  Future<void> createPaymentUrl({
    required int bookingId,
    required void Function(Response<dynamic>) onSuccess,
    required void Function() onError,
  }) async {
    await DioHelper.postData(
      token: token,
      path: createPayment,
      data: {
        'booking_id': bookingId,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        onSuccess(value);
      }
    }).catchError(
      (error) {
        onError();
        if (error is DioError) {
          showAlertToast(error.response!.data.toString());
        } else {
          showAlertToast(error.toString());
        }
      },
    );
  }

// UpdateStatus? updateStatus;
  //
  // void updateStatusData({required String bookingDate,
  //   required int status,
  //   required String requirements,
  //   required String createdAt,
  //   required String updatedAt}) {
  //   emit(UpdateLoadingStatusData());
  //
  //   DioHelper.postData(
  //     path: register,
  //     data: {
  //       'booking_date': bookingDate,
  //       'status': status,
  //       'requirements': requirements,
  //       'created_at': createdAt,
  //       'updated_at': updatedAt
  //     },
  //   ).then((value) {
  //     updateStatus = UpdateStatus.fromJson(value.data);
  //
  //     emit(UpdateSuccessStatusData());
  //   }).catchError((error) {
  //     emit(UpdateErrorStatusData());
  //   });
  // }
  //
}
