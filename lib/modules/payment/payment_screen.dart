import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/modules/payment/add_card.dart';
import 'package:salon_app/modules/payment/payment_widget.dart';
import 'package:salon_app/shared/componants/app_strings.dart';

import '../../../shared/componants/assets_manager.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/fonts_manager.dart';
import '../../shared/componants/language_type.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

bool isButtonPressed = false;
void buttonPressed() {
  if (isButtonPressed == false) {
    isButtonPressed = true;
  } else if (isButtonPressed == true) {
    isButtonPressed = false;
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  var namedController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isRtl() {
      return context.locale == arabicLocal;
    }
    return Scaffold(
        body: background(
      child: Padding(
        padding: const EdgeInsets.only(top: 53, right: 36, left: 36),
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
                  width: 71.w,
                ),
                  Text(
                  AppStrings.paymentMethod.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontConstants.cairoFontFamily,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 44),
             Align(
                alignment:isRtl() ? Alignment.topRight:Alignment.topLeft,
                child: Text(
                  AppStrings.choosePayment.tr(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )),
            const SizedBox(height: 16),
            Container(
              height: 81.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: HexColor("#FFFFFF").withOpacity(0.24)),
              child: Center(
                child: ListTile(
                  leading: Container(
                    height: 46,
                    width: 73,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageAssets.cardImage))),
                  ),
                  title: Text('visa',
                      style: Theme.of(context).textTheme.bodyLarge),
                  subtitle: Text('**********565',
                      style: Theme.of(context).textTheme.bodyLarge),
                  trailing:  const Icon(Icons.keyboard_arrow_down_sharp),
                  onTap: () {},
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            InkWell(
              child: Row(
                children: [
                  Container(
                    height: 13,
                    width: 13,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(ImageAssets.vector),
                    )),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text( AppStrings.addAnotherCard.tr(),
                      style: TextStyle(
                        color: HexColor('#8281F8'),
                        fontWeight: FontWeightManager.semiBold,
                        fontFamily: FontConstants.cairoFontFamily,
                        fontSize: 14,
                      ))
                ],
              ),
              onTap: () {
                navigateTo(context, const AddCard());
              },
            ),
            SizedBox(
              height: 24.h,
            ),
             Align(
              alignment:isRtl()? Alignment.topRight: Alignment.topLeft,
              child: Text(
                AppStrings.bill.tr(),
                style: const TextStyle(
                    fontWeight: FontWeightManager.medium,
                    fontFamily: FontConstants.cairoFontFamily,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
                padding: EdgeInsets.only(
                    right: 25.w, left: 24.w, top: 21.h, bottom: 21.h),
                height: 186.h,
                width: 320.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: HexColor('#FFFFFF').withOpacity(0.24),
                ),
                child: Column(
                  children: [
                    rowItem(title: AppStrings.subtotal.tr(), subtitle: '125 ر.س'),
                    const SizedBox(
                      height: 16,
                    ),
                    rowItem(title:  AppStrings.tax.tr(), subtitle: '12 %'),
                    const SizedBox(
                      height: 16,
                    ),
                    rowItem(title:  AppStrings.total.tr(), subtitle:  AppStrings.total.tr()),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )),
            SizedBox(
              height: 32.h,
            ),
            SizedBox(
                height: 64.h,
                width: 320.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('#8281F8'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child:  Text(
                   AppStrings.payNow.tr(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontConstants.cairoFontFamily),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
