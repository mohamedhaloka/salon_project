import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/componants/fonts_manager.dart';

Widget rowItem({required String title, required String subtitle}) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeightManager.semiBold,
              fontFamily: FontConstants.cairoFontFamily,
              fontSize: 14),
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontWeight: FontWeightManager.semiBold,
              fontSize: 16,
              fontFamily: FontConstants.cairoFontFamily,
              color: HexColor('#8281F8')),
        )
      ],
    );
