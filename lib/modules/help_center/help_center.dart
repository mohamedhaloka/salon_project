import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/app_strings.dart';

import '../../shared/componants/componants.dart';
import '../../shared/componants/fonts_manager.dart';
import '../../shared/componants/language_type.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRtl() {
      return context.locale == arabicLocal;
    }
    return Scaffold(
        body: background(
            child: Padding(
              padding:  EdgeInsets.only(top: 53.h, right: 30.w, left: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back)),
                      SizedBox(
                        width:isRtl()? 70.w:98.w,
                      ),
                       Text(
                        AppStrings.helpCenter.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 44.h),
                   Align(
                      alignment:isRtl()? Alignment.topRight:Alignment.topLeft,
                      child: Text(
                        AppStrings.howHelp.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 16,
                        ),
                      )),
                  const SizedBox(height: 16),
                  Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: HexColor("#8281F8").withOpacity(0.20)),
                      child:  Text(
                        AppStrings.helpText1.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeightManager.medium,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 16,
                        ),
                      )),
                   SizedBox(height: 24.h),
                   Align(
                      alignment:isRtl()? Alignment.topRight:Alignment.topLeft,
                      child: Text(
                        AppStrings.paymentMethods.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 16,
                        ),
                      )),
                   SizedBox(height: 16.h),

                  Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: HexColor("#8281F8").withOpacity(0.20)),
                      child:  Text(
                        AppStrings.helpText2.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeightManager.medium,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 16,
                        ),
                      )),
                  const SizedBox(height: 24),
                ],
              ),
            )));
  }
}
