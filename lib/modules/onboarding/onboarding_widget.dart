import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/fonts_manager.dart';

import '../../shared/componants/app_strings.dart';
import '../../shared/componants/assets_manager.dart';
import 'onboarding_screen.dart';

List<BoardingModel> boarding = [
  BoardingModel(
      container: Container(
        height: 240.h,
        width: 210.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageAssets.backgroundLogoImage1),
        )),
        child: Image.asset(
          ImageAssets.onBoardingLogo1,
          scale: 1.2,
        ),
      ),
      title: AppStrings.onBoardingTitle1,
      subTitle: AppStrings.onBoardingSubTitle1),
  BoardingModel(
      container: Container(
        height: 240.h,
        width: 210.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageAssets.backgroundLogoImage2),
        )),
        child: const Image(
          image: AssetImage(ImageAssets.onBoardingLogo2),
        ),
      ),
      title: AppStrings.onBoardingTitle2,
      subTitle: AppStrings.onBoardingSubTitle2),
  BoardingModel(
      container: Container(
        height: 240.h,
        width: 210.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageAssets.backgroundLogoImage3),
        )),
        child: const Image(
          image: AssetImage(ImageAssets.onBoardingLogo3),
        ),
      ),
      title: AppStrings.onBoardingTitle3,
      subTitle: AppStrings.onBoardingSubTitle3),
  // BoardingModel(
  //     container: Container(
  //       height: 240.h,
  //       width: 210.w,
  //       decoration: const BoxDecoration(
  //           image: DecorationImage(
  //               image: AssetImage(ImageAssets.backgroundLogoImage3),
  //              )),
  //       child:  const Image(
  //         image: AssetImage(ImageAssets.onBoardingLogo1),
  //       ),
  //     ),
  //     title: AppStrings.onBoardingTitle3,
  //     subTitle: AppStrings.onBoardingSubTitle4)
];

Widget buildBoardingImage(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        model.container,
        SizedBox(height: 50.h),
        Text(
          model.title.tr(),
          style: TextStyle(
              color: HexColor('#212121'),
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.cairoFontFamily,
              fontSize: 25.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.0.w),
          child: Text(
            model.subTitle.tr(),
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeightManager.semiBold,
                fontFamily: FontConstants.cairoFontFamily),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
