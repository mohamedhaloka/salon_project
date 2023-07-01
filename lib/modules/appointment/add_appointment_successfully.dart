import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/format_date.dart';
import 'package:salon_app/modules/chose_place/choose_place.dart';
import 'package:salon_app/shared/componants/assets_manager.dart';
import 'package:salon_app/shared/componants/componants.dart';

import '../../layout/cubut/home_layout_cubit.dart';
import '../../shared/componants/fonts_manager.dart';

class AppointmentResultScreen extends StatefulWidget {
  const AppointmentResultScreen(
      {Key? key, required this.price, required this.requirement})
      : super(key: key);
  final String requirement, price;

  @override
  State<AppointmentResultScreen> createState() =>
      _AppointmentResultScreenState();
}

class _AppointmentResultScreenState extends State<AppointmentResultScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = HomeLayoutCubit.instance.userModel!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAssets.background),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 96,
                ),
                Center(
                  child: Container(
                    height: 152,
                    width: 152,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                ImageAssets.backgroundAppointmentImage))),
                    child: Container(
                      width: 93,
                      height: 97,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageAssets.appointmentImage))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                const Text(
                  'تم حجز موعدك بنجاح',
                  style: TextStyle(
                    fontWeight: FontWeightManager.medium,
                    fontFamily: FontConstants.cairoFontFamily,
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: HexColor('#8281F8').withOpacity(0.20),
                    ),
                    padding: const EdgeInsets.all(19),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userData.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeightManager.semiBold,
                                        fontFamily:
                                            FontConstants.cairoFontFamily,
                                      )),
                                  Text(
                                    DateTime.now().formatDate('dd MMM hh:mm a'),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ]),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: HexColor('#8281F8'),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, right: 18, left: 18),
                                child: Text(
                                  'قيد الانتظار',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeightManager.semiBold,
                                      fontFamily:
                                          FontConstants.cairoFontFamily),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          widget.requirement,
                          style: const TextStyle(
                              fontWeight: FontWeightManager.semiBold,
                              fontFamily: FontConstants.cairoFontFamily),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${widget.price} ر.س ',
                            style: TextStyle(
                                color: HexColor('#8281F8'),
                                fontWeight: FontWeight.bold,
                                fontFamily: FontConstants.cairoFontFamily),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 64.h,
                  width: 320.w,
                  child: ElevatedButton(
                    onPressed: () {
                      navigateAndFinish(context, const ChosePlace());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#8281F8'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'العودة للرئيسية',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
