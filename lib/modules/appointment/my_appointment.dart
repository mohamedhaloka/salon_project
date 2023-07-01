import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/componants/app_strings.dart';
import '../../shared/componants/fonts_manager.dart';
import 'booking.dart';

class MyAppointments extends StatelessWidget {
  const MyAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 34.h,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 35.w, left: 35.w),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    width: 62.w,
                  ),
                  Text(
                    AppStrings.appointments.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.cairoFontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const BookingScreen(),
          ],
        ),
      ),
    );
  }
}
