
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/componants.dart';
import 'package:salon_app/shared/componants/fonts_manager.dart';
import 'package:salon_app/shared/local_data_source/locale_data_source.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/componants/app_strings.dart';
import '../../shared/componants/assets_manager.dart';
import '../auth/auth__screens/login_screen.dart';
import 'onboarding_widget.dart';

class BoardingModel {
  final Container container;
  final String title;
  final String subTitle;

  BoardingModel({
    required this.container,
    required this.title,
    required this.subTitle,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    void submit(){
      AppPreferences.saveData('onBoarding', true).then((value){
        if(value = true)
        {
          navigateAndFinish(context, const LoginScreen());
        }
      });
    }
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageAssets.background),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding:
                           EdgeInsets.only(top: 50.0.h, right: 35.w, left: 35.w),
                      child: SizedBox(
                        height: 35.h,
                        width: 67.w,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: HexColor('#8281F8'), width: 1),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)))),
                            onPressed: () {
                              submit();
                            },
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  AppStrings.skip.tr(),
                                  style: TextStyle(
                                      color: HexColor('#8281F8'),
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: 16),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 40.h),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        itemBuilder: (context, index) =>
                            buildBoardingImage(boarding[index]),
                        itemCount: boarding.length,
                        controller: boardController,
                        onPageChanged: (int index) {
                          if (index == boarding.length - 1) {
                            setState(() {
                              isLast = true;

                            });
                          } else {
                            setState(() {
                              isLast = false;
                            });
                          }
                        },
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 75.0.h),
                        child: SmoothPageIndicator(
                            controller: boardController,
                            effect: ExpandingDotsEffect(
                                dotColor: HexColor('#D9D9D9'),
                                activeDotColor: HexColor('#FCC885'),
                                dotHeight: 8,
                                expansionFactor: 4,
                                dotWidth: 8,
                                spacing: 5.0),
                            count: boarding.length),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: FloatingActionButton(
                    backgroundColor: HexColor('#FCC885'),
                    elevation: 0.0,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 900,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
        ),
    );
  }
}
