import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/app_strings.dart';
import 'package:salon_app/shared/componants/componants.dart';

import '../../layout/cubut/home_layout_cubit.dart';
import '../../shared/componants/assets_manager.dart';
import '../../shared/componants/fonts_manager.dart';
import '../../shared/componants/language_type.dart';
import '../appointment/add_appointment.dart';
import '../profile/notifications/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRtl() {
    return context.locale == arabicLocal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            EdgeInsets.only(top: 60.h, right: 34.w, left: 36.w, bottom: 40.h),
        child: Row(
          children: [
            SizedBox(
              height: 59.h,
              width: 58.w,
              child: const Image(
                image: AssetImage(ImageAssets.userImage),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Text(
              HomeLayoutCubit.instance.userModel!.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: FontConstants.cairoFontFamily,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            InkWell(
              child: Container(
                height: 19,
                width: 21,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(ImageAssets.notificationImage),
                )),
              ),
              onTap: () {
                navigateTo(
                  context,
                  const NotificationsScreen(),
                );
              },
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 34.w, left: 36.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.myAppointment.tr(),
                style: const TextStyle(
                  fontWeight: FontWeightManager.semiBold,
                  fontFamily: FontConstants.cairoFontFamily,
                  fontSize: 16,
                )),
            SizedBox(
              height: 24.h,
            ),
            HomeLayoutCubit.instance.chooseBarbersModel!.data != null
                ? Container(
                    height: 146.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: HexColor('#FFFFFF').withOpacity(0.32),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 16.h,
                        right: 16.w,
                        left: 16.w,
                        bottom: 19.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 43.h,
                                width: 43.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Image(
                                  image: NetworkImage(HomeLayoutCubit.instance
                                      .chooseBarbersModel!.data!.image!),
                                ),
                              ),
                              SizedBox(
                                width: 13.h,
                              ),
                              Text(
                                HomeLayoutCubit
                                    .instance.chooseBarbersModel!.data!.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontConstants.cairoFontFamily,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 21.h),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 28.h,
                                width: 71.w,
                                decoration: BoxDecoration(
                                    color: HexColor('#EC8E6C'),
                                    borderRadius: BorderRadius.circular(8)),
                                child: FittedBox(
                                  child: Text(
                                    AppStrings.makeup.tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeightManager.medium,
                                      fontFamily: FontConstants.cairoFontFamily,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 19.w),
                              Container(
                                alignment: Alignment.center,
                                height: 28.h,
                                width: 74.w,
                                decoration: BoxDecoration(
                                    color: HexColor('#8281F8'),
                                    borderRadius: BorderRadius.circular(8)),
                                child: FittedBox(
                                  child: Text(
                                    AppStrings.hairStyle.tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeightManager.medium,
                                      fontFamily: FontConstants.cairoFontFamily,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 19.w),
                              Container(
                                alignment: Alignment.center,
                                height: 28.h,
                                width: 74.w,
                                decoration: BoxDecoration(
                                    color: HexColor('#FFC57B'),
                                    borderRadius: BorderRadius.circular(8)),
                                child: FittedBox(
                                  child: Text(
                                    AppStrings.shaving.tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeightManager.medium,
                                      fontFamily: FontConstants.cairoFontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                : Center(
                    child: Text(
                      'لا يوجد مواعيد مع هذا الصالون',
                      style: TextStyle(color: HexColor('#8281F8')),
                    ),
                  ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              AppStrings.bookAService.tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.cairoFontFamily,
                  fontSize: 16),
            ),
            SizedBox(
              height: 16.h,
            ),
            ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) => InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          const AddAppointmentScreen(),
                        );
                      },
                      child: Container(
                          height: 132.h,
                          width: 320.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: index == 0 || index == 3 || index == 6
                                ? HexColor('#EC8E6C').withOpacity(0.06)
                                : index == 1 || index == 4 || index == 7
                                    ? HexColor('#8281F8').withOpacity(0.06)
                                    : HexColor('#FCC885').withOpacity(0.06),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 16.h,
                                right: 17.w,
                                left: 16.w,
                                bottom: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 51.h,
                                      width: 51.w,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: NetworkImage(HomeLayoutCubit
                                            .instance
                                            .getServicesModel!
                                            .data![index]
                                            .barber!
                                            .image!),
                                      )),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            HomeLayoutCubit
                                                .instance
                                                .getServicesModel!
                                                .data![index]
                                                .name!
                                                .ar!,
                                            style: const TextStyle(
                                              fontWeight:
                                                  FontWeightManager.semiBold,
                                              fontFamily:
                                                  FontConstants.cairoFontFamily,
                                              fontSize: 14,
                                            )),
                                        Text(
                                            HomeLayoutCubit
                                                .instance
                                                .getServicesModel!
                                                .data![index]
                                                .description!
                                                .ar!,
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeightManager.regular,
                                              fontFamily:
                                                  FontConstants.cairoFontFamily,
                                              color: HexColor('#212121')
                                                  .withOpacity(0.60),
                                              fontSize: 11,
                                            )),
                                      ],
                                    ),
                                    const Spacer(),
                                    FittedBox(
                                      child: Text(
                                        HomeLayoutCubit
                                            .instance
                                            .getServicesModel!
                                            .data![index]
                                            .price!,
                                        style: TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                          fontFamily:
                                              FontConstants.cairoFontFamily,
                                          color: HexColor('#EC8E6C'),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: isRtl()
                                      ? EdgeInsets.only(right: 64.w, top: 16.h)
                                      : EdgeInsets.only(left: 64.w, top: 16.h),
                                  child: Container(
                                    height: 32.h,
                                    width: 98.w,
                                    decoration: BoxDecoration(
                                        color: index == 0 ||
                                                index == 3 ||
                                                index == 6
                                            ? HexColor('#FCC885')
                                            : index == 1 ||
                                                    index == 4 ||
                                                    index == 7
                                                ? HexColor('#8281F8')
                                                : HexColor('#EC8E6C'),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(AppStrings.bookService.tr(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontFamily:
                                                FontConstants.cairoFontFamily,
                                            fontSize: 12,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                itemCount: HomeLayoutCubit.instance.getServicesModel!.data!
                    .length), //cubit.getServicesModel!.data!.length
          ],
        ),
      ),
    ]);
  }
}
