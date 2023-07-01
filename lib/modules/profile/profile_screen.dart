import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/app_strings.dart';

import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/componants.dart';
import '../../layout/cubut/home_layout_cubit.dart';
import '../../shared/componants/fonts_manager.dart';
import '../chose_place/choose_place.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var cubit = HomeLayoutCubit.instance.userModel;

  @override
  void initState() {
    if (cubit != null) {
      nameController.text = cubit!.name;
      emailController.text = cubit!.email;
      phoneController.text = cubit!.phone;
    }
    super.initState();
  }

  bool updateProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
        child: Padding(
          padding: EdgeInsets.only(top: 34.h, right: 35.w, left: 35.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    width: 62.w,
                  ),
                  Text(
                    AppStrings.personalInformation.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.cairoFontFamily,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 67.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage(ImageAssets.userImage)),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      HomeLayoutCubit.instance.userModel!.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 20),
                    ),
                    Text(
                      HomeLayoutCubit.instance.userModel!.email,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeightManager.semiBold,
                          fontFamily: FontConstants.cairoFontFamily,
                          color: HexColor('#212121').withOpacity(0.50)),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
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
                              fontFamily: FontConstants.cairoFontFamily,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customFormField(
                            valueKey: 'Name',
                            text: 'name',
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "name-required".tr();
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
                            AppStrings.emailAddress.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeightManager.medium,
                              fontFamily: FontConstants.cairoFontFamily,
                            ),
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
                            AppStrings.phoneText.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeightManager.medium,
                              fontFamily: FontConstants.cairoFontFamily,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customFormField(
                            valueKey: 'Phone',
                            text: "+05xxxxxxxx ",
                            hintStyle: const TextStyle(
                              fontFamily: FontConstants.cairoFontFamily,
                            ),
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
                          SizedBox(
                            height: 64.h,
                            width: 320.w,
                            child: ElevatedButton(
                              onPressed: () {
                                formKey.currentState!.save();
                                if (!formKey.currentState!.validate()) return;

                                updateProfile = true;
                                setState(() {});

                                HomeLayoutCubit.instance.updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  pone: phoneController.text,
                                  imagePath: 'test image',
                                  onSuccess: (value) {
                                    updateProfile = false;
                                    setState(() {});
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const ChosePlace(),
                                      ),
                                      (_) => false,
                                    );
                                  },
                                  onError: () {},
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor('#8281F8'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: updateProfile
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      AppStrings.editInformation.tr(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            FontConstants.cairoFontFamily,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
