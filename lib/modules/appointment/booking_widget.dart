import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/get_booking_model.dart';
import '../../shared/componants/app_strings.dart';
import '../../shared/componants/assets_manager.dart';
import '../../shared/componants/fonts_manager.dart';
import '../../shared/componants/language_type.dart';

class BookingWidget extends StatefulWidget {
  BookingWidget(
    this.bookingItemData, {
    super.key,
    required this.index,
    required this.onPaySelect,
  });
  final int index;
  final BookingItemData bookingItemData;
  final void Function(BookingItemData) onPaySelect;

  @override
  BookingWidgetState createState() => BookingWidgetState();
}

class BookingWidgetState extends State<BookingWidget> {
  bool isShow = false;

  bool isRtl() {
    return context.locale == arabicLocal;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.bookingItemData.status);
        if (widget.bookingItemData.status == 2) {
          widget.onPaySelect(widget.bookingItemData);
          return;
        }
        isShow = !isShow;
        setState(() {});
      },
      child: Row(
        children: [
          SizedBox(
            height: isShow ? 160.h : 85.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: isShow
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HexColor('#8281F8'),
                          ))
                      : null,
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        color: isShow || widget.index == 0
                            ? HexColor('#8281F8')
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: HexColor('#8281F8'))),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: Container(
                    width: 1.w,
                    height: 54.h,
                    color: HexColor('#8281F8'),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 18.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0.h),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 3.h),
                    padding: EdgeInsets.only(
                        top: 13.h,
                        right: isRtl() ? 17.w : 18.w,
                        left: isRtl() ? 18.w : 17.w,
                        bottom: 17.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: isShow
                            ? HexColor("#8281F8")
                            : HexColor(
                                    widget.index.isOdd ? '#EC8E6C' : "#8281F8")
                                .withOpacity(.1)),
                    child: isShow
                        ? Container(
                            padding: EdgeInsets.only(
                                top: 13.h,
                                left: isRtl() ? 18.w : 0,
                                bottom: 8.h),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            isRtl()
                                                ? widget.bookingItemData
                                                    .service!.name!.ar
                                                    .toString()
                                                : widget.bookingItemData
                                                    .service!.name!.en
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 180.w,
                                          ),
                                          if (widget.bookingItemData
                                                  .bookingDate !=
                                              null)
                                            Text(
                                              '${widget.bookingItemData.appointment!.appointStart} : ${widget.bookingItemData.appointment!.appointEnd}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 11.h,
                                      ),
                                      Text(
                                        widget.bookingItemData.requirements ??
                                            '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              color: HexColor('#FFC57B'),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Image(
                                              image: AssetImage(
                                                  ImageAssets.barberName),
                                            ),
                                          ),
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              color: HexColor('#FFC57B'),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Image(
                                              image: AssetImage(
                                                  ImageAssets.barberName),
                                            ),
                                          ),
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                              color: HexColor('#FFC57B'),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: const Image(
                                              image: AssetImage(
                                                  ImageAssets.barberName),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 130.w,
                                          ),
                                          const Image(
                                            image: AssetImage(
                                                ImageAssets.clockIcon),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: FittedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isRtl()
                                            ? widget.bookingItemData.service!
                                                .name!.ar
                                                .toString()
                                            : widget.bookingItemData.service!
                                                .name!.en
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        widget.bookingItemData.requirements ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    '${widget.bookingItemData.appointment!.appointStart} : ${widget.bookingItemData.appointment!.appointEnd}',
                                    style: TextStyle(
                                        color: HexColor('#212121')
                                            .withOpacity(0.30)),
                                  ),
                                  status(),
                                ],
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget status() => Container(
        width: 87.w,
        height: 32.h,
        decoration: BoxDecoration(
            color: statusColor.withAlpha(80),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(statusTxt,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeightManager.semiBold,
                  fontFamily: FontConstants.cairoFontFamily,
                  fontSize: 13,
                ))),
      );

  String get statusTxt {
    switch (widget.bookingItemData.status) {
      case 0:
        return AppStrings.pending;
      case 1:
        return AppStrings.inProgress;
      case 2:
        return AppStrings.completed;
      case 3:
        return AppStrings.canceled;
      default:
        return '';
    }
  }

  Color get statusColor {
    switch (widget.bookingItemData.status) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
    }
    return Colors.transparent;
  }
}
