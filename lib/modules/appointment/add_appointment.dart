import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/format_date.dart';
import 'package:salon_app/models/get_service_model.dart';
import 'package:salon_app/models/user_data_model.dart';
import 'package:salon_app/shared/componants/color_manager.dart';
import 'package:salon_app/utils.dart';

import '../../../shared/componants/componants.dart';
import '../../layout/cubut/home_layout_cubit.dart';
import '../../models/get_booking_model.dart';
import '../../shared/componants/app_strings.dart';
import '../../shared/componants/fonts_manager.dart';
import '../../shared/componants/language_type.dart';
import '../payment/payment_widget.dart';
import 'add_appointment_successfully.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({Key? key}) : super(key: key);
  @override
  State<AddAppointmentScreen> createState() => AddAppointmentScreenState();
}

class AddAppointmentScreenState extends State<AddAppointmentScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  bool loading = true;
  bool sendAppointment = false;
  UserDataModel? userData;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    userData = HomeLayoutCubit.instance.userModel;
    nameController.text = userData!.name;
    emailController.text = userData!.email;
    phoneController.text = userData!.phone;
    await HomeLayoutCubit.instance.getAppointments();
    loading = false;
    setState(() {});
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    notesController.dispose();
    super.dispose();
  }

  bool isRtl() {
    return context.locale == arabicLocal;
  }

  List<ServiceData> selectedServices = <ServiceData>[];
  int selectedAppointmentId = 0;
  double totalPrice = 0.0;

  DateTime selectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // final homeCubit = HomeLayoutCubit.get(context);
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : background(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 62.h,
                  right: 30.w,
                  left: 30.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back)),
                        SizedBox(
                          width: 96.w,
                        ),
                        Text(
                          AppStrings.addAppointment.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 44.h),
                    Text(
                      AppStrings.chooseDay.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeightManager.semiBold,
                        fontFamily: FontConstants.cairoFontFamily,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: HexColor('#FFFFFF').withOpacity(0.40)),
                        width: 319.w,
                        height: 306.h,
                        child: Theme(
                          data: ThemeData(
                              colorScheme: ColorScheme(
                                  brightness: Brightness.light,
                                  primary: ColorManager.buttonColor,
                                  onPrimary: Colors.white,
                                  secondary: Colors.transparent,
                                  onSecondary: Colors.transparent,
                                  error: Colors.transparent,
                                  onError: Colors.transparent,
                                  background: Colors.transparent,
                                  onBackground: Colors.blue,
                                  surface: Colors.blue,
                                  onSurface: Colors.black)),
                          child: CalendarDatePicker(
                            initialDate: selectedData,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025),
                            // firstDate: DateTime.now()
                            //     .subtract(const Duration(days: 3)),
                            // lastDate:
                            //     DateTime.now().add(const Duration(days: 5)),
                            onDateChanged: (date) {
                              selectedData = date;
                              selectedAppointmentId = 0;
                              setState(() {});
                            },
                          ),
                        )),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(AppStrings.name.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeightManager.medium,
                          fontFamily: FontConstants.cairoFontFamily,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customFormField(
                              valueKey: 'name',
                              text: AppStrings.name.tr(),
                              hintStyle: const TextStyle(color: Colors.black87),
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "name-required".tr();
                                } else {
                                  return null;
                                }
                              },
                              controller: nameController,
                              type: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            Text(AppStrings.emailAddress.tr(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily,
                                )),
                            SizedBox(
                              height: 24.h,
                            ),
                            customFormField(
                              valueKey: 'Email',
                              text: AppStrings.emilHintText.tr(),
                              hintStyle: const TextStyle(color: Colors.black),
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "email-required".tr();
                                } else {
                                  return null;
                                }
                              },
                              controller: emailController,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            Text(
                              AppStrings.phoneText.tr(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            customFormField(
                              valueKey: 'Phone',
                              text: "+05xxxxxxxx ",
                              hintStyle: const TextStyle(
                                fontFamily: FontConstants.cairoFontFamily,
                              ),
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "phone-required".tr();
                                } else {
                                  return null;
                                }
                              },
                              controller: phoneController,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            Text(AppStrings.notes.tr(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily,
                                )),
                            SizedBox(
                              height: 24.h,
                            ),
                            customFormField(
                              valueKey: 'Notes',
                              text: AppStrings.notesHintText.tr(),
                              hintStyle: const TextStyle(color: Colors.black),
                              controller: notesController,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "notes-required".tr();
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.chooseService.tr(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: FontConstants.cairoFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: HomeLayoutCubit
                                      .instance.getServicesModel!.data!
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {
                                            if (selectedServices.contains(e)) {
                                              selectedServices.remove(e);
                                              totalPrice -= double.tryParse(
                                                      e.price ?? '0') ??
                                                  0.0;
                                            } else {
                                              selectedServices.add(e);
                                              totalPrice += double.tryParse(
                                                      e.price ?? '0') ??
                                                  0.0;
                                            }

                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40.h,
                                            width: 110.w,
                                            decoration: BoxDecoration(
                                                color:
                                                    selectedServices.contains(e)
                                                        ? HexColor("#8281F8")
                                                            .withOpacity(0.10)
                                                        : HexColor("#FCC8851A")
                                                            .withOpacity(0.10),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Text(
                                              e.name!.ar!,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                                fontFamily: FontConstants
                                                    .cairoFontFamily,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.reservationDate.tr(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily:
                                            FontConstants.cairoFontFamily,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: HomeLayoutCubit
                                      .instance.appointmentList
                                      .where((element) =>
                                          element.appointmentDate
                                              .compareTo(selectedData) ==
                                          0)
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {
                                            selectedAppointmentId = e.id;
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40.h,
                                            width: 110.w,
                                            decoration: BoxDecoration(
                                                color: selectedAppointmentId ==
                                                        e.id
                                                    ? HexColor("#8281F8")
                                                        .withOpacity(0.10)
                                                    : HexColor("#FCC8851A")
                                                        .withOpacity(0.10),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Text(
                                              '${e.appointStart} : ${e.appointEnd}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                                fontFamily: FontConstants
                                                    .cairoFontFamily,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Align(
                              alignment: isRtl()
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: Text(
                                AppStrings.bill.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeightManager.medium,
                                    fontFamily: FontConstants.cairoFontFamily,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    right: 25.w,
                                    left: 24.w,
                                    top: 21.h,
                                    bottom: 21.h),
                                height: 186.h,
                                width: 320.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: HexColor('#FFFFFF').withOpacity(0.24),
                                ),
                                child: Column(
                                  children: [
                                    rowItem(
                                        title: AppStrings.subtotal.tr(),
                                        subtitle: '$totalPrice ر.س'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    rowItem(
                                        title: AppStrings.tax.tr(),
                                        subtitle: '12 %'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    rowItem(
                                        title: AppStrings.total.tr(),
                                        subtitle:
                                            '${totalPrice + (totalPrice * .12)}'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 32.h,
                            ),
                            SizedBox(
                              height: 64.h,
                              width: 320.w,
                              child: ElevatedButton(
                                onPressed: sendAppointment
                                    ? null
                                    : () {
                                        if (selectedServices.isEmpty) {
                                          return;
                                        }
                                        if (selectedAppointmentId == 0) {
                                          return;
                                        }
                                        if (formKey.currentState!.validate()) {
                                          sendAppointment = true;
                                          setState(() {});

                                          int barberId = HomeLayoutCubit
                                              .instance.selectedBarber;

                                          List<BookingItemData> bookingItems =
                                              <BookingItemData>[];

                                          for (var service
                                              in selectedServices) {
                                            HomeLayoutCubit.instance
                                                .storesBooking(
                                              requirements:
                                                  notesController.text,
                                              customerId: userData!.id,
                                              appointmentId:
                                                  selectedAppointmentId,
                                              barberId: barberId,
                                              serviceId: service.id!,
                                              status: 0,
                                              bookingDate: selectedData
                                                  .formatDate(bookingDate),
                                              onSuccess: (value) {
                                                if (value is bool) {
                                                  log('reservation done');
                                                  return;
                                                }
                                                showAlertToast(
                                                    '${'reservation-done'.tr()} ${isRtl() ? service.name!.ar : service.name!.en}');
                                                bookingItems.add(value);
                                              },
                                              onError: () {},
                                            );
                                          }

                                          sendAppointment = false;
                                          setState(() {});

                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AppointmentResultScreen(
                                                requirement:
                                                    notesController.text,
                                                price: totalPrice.toString(),
                                              ),
                                            ),
                                            (_) => false,
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor('#8281F8'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: sendAppointment
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        AppStrings.bookAppointment.tr(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              FontConstants.cairoFontFamily,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
