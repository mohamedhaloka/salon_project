import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/format_date.dart';
import 'package:salon_app/modules/payment/payment_web_view_screen.dart';
import 'package:salon_app/shared/componants/app_strings.dart';
import 'package:salon_app/shared/componants/color_manager.dart';

import '../../layout/cubut/home_layout_cubit.dart';
import '../../shared/componants/componants.dart';
import 'booking_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int currentStep = 0;
  List<DateTime> dates = <DateTime>[];
  DateTime selectedDateTime = DateTime.now();
  bool loading = true, createPayment = false;

  @override
  void initState() {
    DateTime now = DateTime.now();
    for (var i = 20; i > 0; i--) {
      dates.add(now.subtract(Duration(days: i)));
    }
    dates.add(now);
    for (var i = 1; i < 14; i++) {
      dates.add(now.add(Duration(days: i)));
    }
    getBookingData();
    super.initState();
  }

  Future<void> getBookingData() async {
    loading = true;
    setState(() {});
    await HomeLayoutCubit.instance.getBookingData(
      onSuccess: (_) {},
      onError: () {},
    );

    loading = false;
    setState(() {});
  }

  Future<void> createPaymentUrl(int bookingId) async {
    createPayment = true;
    setState(() {});
    await HomeLayoutCubit.instance.createPaymentUrl(
      bookingId: bookingId,
      onSuccess: (response) async {
        await navigateTo(
          context,
          PaymentWebViewScreen(paymentUrl: response.data['data']['url']),
        );

        getBookingData();
      },
      onError: () {},
    );

    createPayment = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cubit = HomeLayoutCubit.instance.bookingModel?.data?.where(
      (element) {
        final bookingDate =
            DateTime.parse(element.bookingDate!).formatDate('yyyy-MM-dd');
        final currentDate = selectedDateTime.formatDate('yyyy-MM-dd');

        return bookingDate.compareTo(currentDate) == 0;
      },
    ).toList();
    Locale myLocale = Localizations.localeOf(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 60.h, right: 35.w, left: 35.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.today.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      DateTime.now().formatDate('EEE dd, yyyy'),
                      style: TextStyle(
                        color: HexColor('#212121').withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 70.h,
                  child: ListView.separated(
                    itemBuilder: (_, int index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: InkWell(
                        onTap: () {
                          selectedDateTime = dates[index];
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            Center(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat.E(myLocale.languageCode)
                                      .format(dates[index]),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        dates[index].day == selectedDateTime.day
                                            ? ColorManager.buttonColor
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              dates[index].day.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: dates[index].day == selectedDateTime.day
                                    ? ColorManager.buttonColor
                                    : Colors.grey,
                              ),
                            ),
                            if (dates[index].day == selectedDateTime.day) ...[
                              CircleAvatar(
                                backgroundColor: ColorManager.buttonColor,
                                radius: 2,
                              )
                            ]
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: dates.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(height: 10.h),
                ConditionalBuilder(
                  condition: !loading,
                  builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) => BookingWidget(
                            cubit[index],
                            index: index,
                            onPaySelect: (bookingItem) =>
                                createPaymentUrl(bookingItem.id!),
                          ),
                      separatorBuilder: (_, __) => SizedBox(width: 0.w),
                      itemCount: cubit!.length),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            )),
        if (createPayment)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.transparent,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
      ],
    );
  }
}
