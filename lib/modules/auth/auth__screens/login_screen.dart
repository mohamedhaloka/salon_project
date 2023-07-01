import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/app_strings.dart';

import '../../../services/notification_service.dart';
import '../../../shared/componants/app_constane.dart';
import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/fonts_manager.dart';
import '../../../shared/componants/language_type.dart';
import '../../../shared/local_data_source/locale_data_source.dart';
import '../../chose_place/choose_place.dart';
import '../../password/forget_password.dart';
import '../auth_cubit/auth_cubit.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isRtl() {
    return context.locale == arabicLocal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        child: Padding(
          padding: EdgeInsets.only(top: 68.h),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: HexColor('#EC8E6C').withOpacity(0.1),
                child: const Image(
                  width: 152,
                  height: 152,
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
                      Text(
                        AppStrings.emailAddress.tr(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeightManager.regular,
                            fontFamily: FontConstants.cairoFontFamily),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customFormField(
                                valueKey: 'Email',
                                text: "Example@gmail.com",
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeightManager.medium,
                                    fontFamily:
                                        FontConstants.poppinsFontFamily),
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'email-required'.tr();
                                  } else if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return 'fill-valid-email'.tr();
                                  }
                                  return null;
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
                                    fontWeight: FontWeightManager.regular,
                                    fontFamily:
                                        FontConstants.poppinsFontFamily),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              StatefulBuilder(
                                builder: (BuildContext context, setState) =>
                                    customFormField(
                                  valueKey: 'Password',
                                  text: "*********",
                                  hintStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeightManager.medium,
                                      fontFamily:
                                          FontConstants.poppinsFontFamily),
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "password-required".tr();
                                    } else {
                                      return null;
                                    }
                                  },
                                  suffix: AuthCubit.instance.suffix,
                                  suffixPressed: () {
                                    AuthCubit.instance
                                        .changePasswordVisibility();
                                    setState(() {});
                                  },
                                  obSecureText: AuthCubit.instance.isPassword,
                                  controller: passwordController,
                                  type: TextInputType.number,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 11.h,
                      ),
                      Transform(
                          transform: Matrix4.rotationY(isRtl() ? 0 : 0),
                          child: Align(
                              alignment: isRtl()
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    navigateTo(
                                      context,
                                      const ForgetPasswordScreen(),
                                    );
                                  },
                                  child: Text(
                                    AppStrings.forgetPasswordText.tr(),
                                    style: TextStyle(
                                        color: HexColor('#8281F8'),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeightManager.semiBold,
                                        fontFamily:
                                            FontConstants.cairoFontFamily),
                                  )))),
                      SizedBox(
                        height: 39.h,
                      ),
                      SizedBox(
                        height: 64.h,
                        width: 320.w,
                        child: StatefulBuilder(
                          builder: (BuildContext context, setState) =>
                              ElevatedButton(
                            onPressed: loading
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      loading = true;
                                      setState(() {});
                                      final fcmToken =
                                          await NotificationsService.instance
                                              .getFCMToken();

                                      final result =
                                          await AuthCubit.instance.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        fcmToken: fcmToken ?? '',
                                      );
                                      loading = false;
                                      setState(() {});

                                      if (result != null) {
                                        AppPreferences.saveData(
                                          'token',
                                          result.token,
                                        ).then(
                                          (value) {
                                            token = result.token;
                                            navigateAndFinish(
                                              context,
                                              const ChosePlace(),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: HexColor('#8281F8'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14))),
                            child: loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    AppStrings.loginText.tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            FontConstants.cairoFontFamily),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Center(
                      //     child: Text(
                      //   AppStrings.orSignInWith.tr(),
                      //   style: const TextStyle(
                      //       fontSize: 13,
                      //       fontWeight: FontWeightManager.medium,
                      //       fontFamily: FontConstants.cairoFontFamily),
                      // )),
                      // SizedBox(height: 24.h),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         padding: const EdgeInsets.all(10),
                      //         decoration: BoxDecoration(
                      //             borderRadius: const BorderRadius.all(
                      //                 Radius.circular(10)),
                      //             color: HexColor('#EC8E6C').withOpacity(0.1)),
                      //         child: IconButton(
                      //           icon: Image.asset(
                      //               'assets/images/facebook_icon.png'),
                      //           onPressed: () async {
                      //             loading = true;
                      //             setState(() {});
                      //
                      //             await AuthCubit.instance.facebookSignIn(
                      //               onSuccess: (value) {
                      //                 final String userToken =
                      //                     value.data['token'];
                      //                 AppPreferences.saveData(
                      //                   'token',
                      //                   userToken,
                      //                 ).then(
                      //                   (value) {
                      //                     token = userToken;
                      //                     navigateAndFinish(
                      //                       context,
                      //                       const ChosePlace(),
                      //                     );
                      //                   },
                      //                 );
                      //               },
                      //               onError: (value) {},
                      //             );
                      //             loading = false;
                      //             setState(() {});
                      //           },
                      //         ),
                      //       ),
                      //       if (Platform.isIOS)
                      //         Container(
                      //           padding: const EdgeInsets.all(10),
                      //           decoration: BoxDecoration(
                      //               borderRadius: const BorderRadius.all(
                      //                   Radius.circular(10)),
                      //               color:
                      //                   HexColor('#EC8E6C').withOpacity(0.1)),
                      //           child: IconButton(
                      //             icon: Image.asset('assets/images/apple.png'),
                      //             onPressed: () {
                      //               // AuthCubit.get(context).appleSignIn();
                      //             },
                      //           ),
                      //         ),
                      //       Container(
                      //         padding: const EdgeInsets.all(10),
                      //         decoration: BoxDecoration(
                      //             borderRadius: const BorderRadius.all(
                      //                 Radius.circular(10)),
                      //             color: HexColor('#EC8E6C').withOpacity(0.1)),
                      //         child: IconButton(
                      //           icon: Image.asset('assets/images/google.png'),
                      //           onPressed: () async {
                      //             loading = true;
                      //             setState(() {});
                      //             await AuthCubit.instance.googleSignIn(
                      //               onSuccess: (value) {
                      //                 final String userToken =
                      //                     value.data['token'];
                      //                 AppPreferences.saveData(
                      //                   'token',
                      //                   userToken,
                      //                 ).then(
                      //                   (value) {
                      //                     token = userToken;
                      //                     navigateAndFinish(
                      //                       context,
                      //                       const ChosePlace(),
                      //                     );
                      //                   },
                      //                 );
                      //               },
                      //               onError: (value) {},
                      //             );
                      //             loading = false;
                      //             setState(() {});
                      //           },
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 52.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.doNotHaveAccount.tr(),
                            style: const TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontFamily: FontConstants.cairoFontFamily,
                                fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
                            },
                            child: Text(
                              AppStrings.createAccount.tr(),
                              style: TextStyle(
                                  color: HexColor('#8281F8'),
                                  fontSize: 16.sp,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeightManager.medium,
                                  fontFamily: FontConstants.cairoFontFamily),
                            ),
                          ),
                        ],
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
