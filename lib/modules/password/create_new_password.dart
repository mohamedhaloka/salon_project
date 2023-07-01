import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:salon_app/modules/password/password_changed_successfully.dart';
import 'package:salon_app/shared/componants/app_strings.dart';
import 'package:salon_app/shared/componants/language_type.dart';

import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/componants.dart';
import '../../shared/componants/fonts_manager.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword(
      {Key? key, required this.emailController, required this.codeController})
      : super(key: key);

  final String? emailController;
  final String? codeController;
  @override
  State<CreateNewPassword> createState() =>
      _LoginScreenState(emailController, codeController);
}

class _LoginScreenState extends State<CreateNewPassword> {
  _LoginScreenState(this.emailController, this.codeController);
  String? emailController;
  String? codeController;
  var newPasswordController = TextEditingController();
  var verifyNewPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    newPasswordController.dispose();
    verifyNewPasswordController.dispose();
    super.dispose();
  }

  bool loading = false;
  bool isRtl() {
    return context.locale == arabicLocal;
  }

  @override
  Widget build(BuildContext context) {
//  if (state is ChangePasswordSuccessState) {
//                 navigateTo(context, const PasswordChangedSuccessfully());
//               }
    return Scaffold(
      body: background(
        child: Column(
          crossAxisAlignment:
              isRtl() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Transform(
                    alignment:
                        isRtl() ? Alignment.bottomLeft : Alignment.bottomRight,
                    transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
                    child: Padding(
                      padding: EdgeInsets.only(right: 30.0.w),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 35.w, left: 30.w, bottom: 154.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 151,
                        height: 151,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/Ellipse 2.png"),
                                fit: BoxFit.cover)),
                        child: const Image(
                          image: AssetImage(ImageAssets.newPasswordLogo),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Center(
                        child: Text(
                      AppStrings.createNewPassword.tr(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 20),
                    )),
                    const SizedBox(
                      height: 11,
                    ),
                    Center(
                        child: Text(
                      AppStrings.changeYourPassword.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 12,
                          color: HexColor('#212121').withOpacity(0.30)),
                    )),
                    const SizedBox(
                      height: 48,
                    ),
                    Text(
                      AppStrings.newPassword.tr(),
                      style: const TextStyle(
                          fontWeight: FontWeightManager.medium,
                          fontFamily: FontConstants.cairoFontFamily),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    customFormField(
                      valueKey: 'Password',
                      text: "*******",
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          //
                        } else {
                          return null;
                        }
                        return null;
                      },
                      suffix: AuthCubit.instance.suffix,
                      suffixPressed: () {
                        AuthCubit.instance.changePasswordVisibility();
                      },
                      obSecureText: AuthCubit.instance.isPassword,
                      controller: newPasswordController,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(AppStrings.confirmPassword.tr(),
                        style: const TextStyle(
                            fontWeight: FontWeightManager.medium,
                            fontFamily: FontConstants.cairoFontFamily)),
                    SizedBox(
                      height: 11.h,
                    ),
                    customFormField(
                      valueKey: 'Confirm Password',
                      text: "*******",
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          //
                        } else {
                          return null;
                        }
                        return null;
                      },
                      suffix: AuthCubit.instance.suffix,
                      suffixPressed: () {
                        AuthCubit.instance.changePasswordVisibility();
                      },
                      obSecureText: AuthCubit.instance.isPassword,
                      controller: verifyNewPasswordController,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    SizedBox(
                      height: 64,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  loading = true;
                                  setState(() {});
                                  await AuthCubit.instance.changePassword(
                                    email: emailController,
                                    code: codeController,
                                    newPassword: newPasswordController.text,
                                    newPasswordConfirmation:
                                        verifyNewPasswordController.text,
                                    onSuccess: (value) {
                                      if (context.mounted) {
                                        navigateTo(context,
                                            const PasswordChangedSuccessfully());
                                      }
                                    },
                                    onError: (_) => _,
                                  );
                                  loading = false;
                                  setState(() {});
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: HexColor('#8281F8'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38))),
                        child: loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                AppStrings.changePassword.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeightManager.semiBold,
                                    fontFamily: FontConstants.cairoFontFamily,
                                    fontSize: 20),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
