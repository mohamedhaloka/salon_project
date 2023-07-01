import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/componants/assets_manager.dart';

Widget editSettingsCardItem({required String text,required Color color,required String imageName}) => InkWell(
  child:   Container(

      padding: EdgeInsets.only(left: 29.w, right: 14.w, top: 11.h, bottom: 10.h),

      height: 64.h,

      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(16),

          color:color ),

      child: Center(

          child: Row(

        children: [

          Container(

              height: 43.h,

              width: 43.w,

              decoration: const BoxDecoration(

                  image: DecorationImage(

                      image: AssetImage(ImageAssets.backgroundIcon))),

              child:

                  const Image(image: AssetImage(ImageAssets.changeLanguageIcon))),

          SizedBox(

            width: 17.w,

          ),

           Text(

           text,

          ),

          const Spacer(),

           Image(image: AssetImage(imageName))

        ],

      ))),
);
