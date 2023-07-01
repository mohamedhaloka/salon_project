import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/app_strings.dart';
import 'package:salon_app/shared/componants/language_type.dart';

import '../../../shared/componants/assets_manager.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/di.dart';
import '../../shared/componants/fonts_manager.dart';
import '../../shared/local_data_source/locale_data_source.dart';
import '../password/create_new_password.dart';
import '../password/forget_password.dart';

class EditSettings extends StatefulWidget {
  const EditSettings({Key? key}) : super(key: key);

  @override
  State<EditSettings> createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  bool notify1 = false;
  bool notify2 = false;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    bool isRtl() {
      return context.locale == arabicLocal;
    }
    return Scaffold(
      body: background(
        child: Padding(
          padding: EdgeInsets.only(top: 53.h, right: 30.w, left: 30.w),
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
                    width:isRtl()? 89.w:120.w,
                  ),
                   Text(
                    AppStrings.setting.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.cairoFontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 44),
               Text(
                AppStrings.mangePasswords.tr(),
                style: const TextStyle(
                  fontWeight: FontWeightManager.semiBold,
                  fontFamily: FontConstants.cairoFontFamily,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  navigateTo(context,  const ForgetPasswordScreen());
                },
                child: Container(
                    padding: EdgeInsets.only(
                        left:isRtl() ? 27 :10 ,
                        right:isRtl() ? 10 :27  , top: 11.h, bottom: 10),
                    height: 64.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: HexColor("#8281F8").withOpacity(0.04)),
                    child: Center(
                        child: Row(
                      children: [
                        Container(
                            height: 43.h,
                            width: 43.w,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        ImageAssets.backgroundIcon))),
                            child: const Image(
                                image: AssetImage(ImageAssets.lockIcon))),
                        SizedBox(
                          width: 17.w,
                        ),
                         Text(
                          AppStrings.changePassword.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeightManager.medium,
                              fontFamily: FontConstants.cairoFontFamily,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        const Image(image: AssetImage(ImageAssets.typeIcon))
                      ],
                    ))),
              ),
              const SizedBox(height: 32),
               Text(
                AppStrings.language.tr(),
                style: const TextStyle(
                  fontWeight: FontWeightManager.medium,
                  fontFamily: FontConstants.cairoFontFamily,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                    _changeLanguage();
                },
                child: Container(
                    padding: EdgeInsets.only(
                        left:isRtl() ? 27 :10 ,
                        right:isRtl() ? 10 :27  , top: 11.h, bottom: 10),
                    height: 64.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: HexColor("#8281F8").withOpacity(0.04)),
                    child: Center(
                        child: Row(
                      children: [
                        Container(
                            height: 43.h,
                            width: 43.w,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        ImageAssets.backgroundIcon))),
                            child: const Image(
                                image: AssetImage(
                                    ImageAssets.changeLanguageIcon))),
                        SizedBox(
                          width: 17.w,
                        ),
                         Text(
                         AppStrings.english.tr() ,
                          style: const TextStyle(
                              fontWeight: FontWeightManager.medium,
                              fontFamily: FontConstants.cairoFontFamily,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        const Image(image: AssetImage(ImageAssets.typeIcon))
                      ],
                    ))),
              ),
              const SizedBox(height: 32),
               Text(
                AppStrings.notificationCenter.tr(),
                style: const TextStyle(
                  fontWeight: FontWeightManager.medium,
                  fontFamily: FontConstants.cairoFontFamily,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 64.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: HexColor("#8281F8").withOpacity(0.04)),
                child: Center(
                  child: ListTile(
                    leading: Container(
                        height: 43,
                        width: 43,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageAssets.backgroundIcon))),
                        child: const Image(
                            image: AssetImage(ImageAssets.notificationImage))),
                    title: Text(AppStrings.general.tr(),
                        style: Theme.of(context).textTheme.bodyLarge),
                    trailing: Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          trackColor: HexColor('#C5C5C5'),
                          activeColor: HexColor('#8281F8'),
                          value: notify1,
                          onChanged: (bool newValue) {
                            setState(() {
                              notify1 = newValue;
                            });
                          },
                        )),
                    onTap: () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 64.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: HexColor("#8281F8").withOpacity(0.04)),
                child: Center(
                  child: ListTile(
                      leading: Container(
                          height: 43,
                          width: 43,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(ImageAssets.backgroundIcon))),
                          child: const Image(
                              image:
                                  AssetImage(ImageAssets.notificationImage))),
                      title: Text(AppStrings.reminder.tr(),
                          style: Theme.of(context).textTheme.bodyLarge),
                      trailing: Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            trackColor: HexColor('#C5C5C5'),
                            activeColor: HexColor('#8281F8'),
                            value: notify2,
                            onChanged: (bool newValue) {
                              setState(() {
                                notify2 = newValue;
                              });
                            },
                          ))),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
        ),
      ),
    );
  }




  _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }
}
