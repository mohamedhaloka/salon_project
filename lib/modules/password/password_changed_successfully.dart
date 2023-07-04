import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/modules/auth/auth__screens/login_screen.dart';
import 'package:salon_app/shared/componants/componants.dart';

import '../../../shared/componants/assets_manager.dart';
import '../../shared/componants/app_strings.dart';
import '../../shared/componants/fonts_manager.dart';

class PasswordChangedSuccessfully extends StatefulWidget {
  const PasswordChangedSuccessfully({Key? key}) : super(key: key);

  @override
  State<PasswordChangedSuccessfully> createState() =>
      _PasswordChangedSuccessfullyState();
}

class _PasswordChangedSuccessfullyState
    extends State<PasswordChangedSuccessfully>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final controller = SplashController();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0.0, end: 0.12 * pi).animate(_controller);
    _controller.repeat(reverse: true);

    controller.timer(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.background), fit: BoxFit.cover)),
        child: Column(children: [
          SizedBox(
            height: 162.h,
          ),
          Container(
            height: 294,
            width: 294,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageAssets.backgroundLogoImage2),
                    fit: BoxFit.cover)),
            child: SizedBox(
                height: 165,
                width: 166,
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateZ(_animation.value),
                        child: const Image(
                          image: AssetImage(
                              ImageAssets.changePasswordSuccessfully),
                        ),
                      );
                    })),
          ),
          Text(
            AppStrings.passwordChanged.tr(),
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeightManager.medium,
                fontFamily: FontConstants.cairoFontFamily),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            AppStrings.bookYourAppointment.tr(),
            style: TextStyle(
                color: HexColor('#212121').withOpacity(0.5),
                fontSize: 14.0.sp,
                fontWeight: FontWeightManager.medium,
                fontFamily: FontConstants.cairoFontFamily),
          )
        ]),
      ),
    );
  }
}

class SplashController {
  void timer(context) {
    Timer(
      const Duration(seconds: 3),
      () {
        navigateAndFinish(context, const LoginScreen());
      },
    );
  }
}
