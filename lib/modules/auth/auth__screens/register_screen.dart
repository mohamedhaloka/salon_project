// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/componants/app_constane.dart';
import '../../../shared/componants/app_strings.dart';
import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/fonts_manager.dart';
import '../../../shared/local_data_source/locale_data_source.dart';
import '../../chose_place/choose_place.dart';
import '../auth_cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? confirmPassword;

  var formKey = GlobalKey<FormState>();

  bool loading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        child: Padding(
          padding: EdgeInsets.only(
            top: 68.h,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: HexColor('#EC8E6C').withOpacity(0.1),
                child: const Image(
                  width: 112,
                  height: 114,
                  image: AssetImage(ImageAssets.onBoardingLogo1),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32)),
                  border: Border.all(
                      color: HexColor('#FCC885').withOpacity(0.30), width: 1),
                  color: HexColor('#FFFFFF').withOpacity(0.40),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.h, vertical: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.name.tr(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            customFormField(
                              valueKey: 'name',
                              text: "Example",
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'name-required'.tr();
                                } else {
                                  return null;
                                }
                              },
                              controller: nameController,
                              type: TextInputType.name,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            Text(
                              AppStrings.phoneText.tr(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            customFormField(
                              valueKey: 'Phone',
                              text: "+966 545 254 ",
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
                            Text(
                              AppStrings.emailAddress.tr(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            customFormField(
                              valueKey: 'Email',
                              text: "Example@gmail.com",
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "email-required".tr();
                                } else {
                                  return null;
                                }
                              },
                              controller: emailController,
                              type: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            Text(
                              AppStrings.passwordText.tr(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            customFormField(
                              valueKey: 'Password',
                              controller: passwordController,
                              text: "********",
                              validate: (String? value) {
                                confirmPassword = value;
                                if (value!.isEmpty) {
                                  return "password-required".tr();
                                } else {
                                  return null;
                                }
                              },
                              suffix: AuthCubit.instance.suffix,
                              suffixPressed: () {
                                AuthCubit.instance.changePasswordVisibility();
                                setState(() {});
                              },
                              obSecureText: AuthCubit.instance.isPassword,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            Text(
                              AppStrings.confirmPassword.tr(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            customFormField(
                              controller: confirmPasswordController,
                              valueKey: 'Confirm',
                              text: "********",
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "confirm-password-required".tr();
                                } else if (value != confirmPassword) {
                                  return 'confirm-password-not-match'.tr();
                                }
                                return null;
                              },
                              suffix: AuthCubit.instance.suffix,
                              suffixPressed: () {
                                AuthCubit.instance.changePasswordVisibility();
                                setState(() {});
                              },
                              obSecureText: AuthCubit.instance.isPassword,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 39.h,
                      ),
                      SizedBox(
                        height: 64.h,
                        width: 320.w,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) return;
                            loading = true;
                            setState(() {});

                            final result =
                                await AuthCubit.instance.userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: passwordController.text,
                              phone: phoneController.text,
                              onSuccess: (value) {},
                              onError: (e) {
                                log(e.toString());
                              },
                            );
                            loading = false;
                            setState(() {});
                            if (result == null) return;
                            AppPreferences.saveData('token', result.token)
                                .then((value) {
                              token = result.token;
                              navigateAndFinish(context, const ChosePlace());
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: HexColor('#8281F8'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  AppStrings.registerText.tr(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeightManager.medium,
                                      fontFamily:
                                          FontConstants.cairoFontFamily),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
