import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/models/notifications_model.dart';
import 'package:salon_app/modules/profile/notifications/widgets.dart';

import '../../../shared/componants/assets_manager.dart';
import '../../../shared/componants/fonts_manager.dart';
import '../../../shared/componants/language_type.dart';

class AcceptNotifications extends StatefulWidget {
  const AcceptNotifications({Key? key, required this.notificationItem})
      : super(key: key);
  final NotificationItemData notificationItem;

  @override
  _State createState() => _State();
}

class _State extends State<AcceptNotifications> {
  bool isPressed = false;

  bool isRtl() {
    return context.locale == arabicLocal;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isPressed = !isPressed);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: isRtl() ? 26 : 0, bottom: 16.h, right: isRtl() ? 0 : 26),
            child: buildUserDataItem(
                image: ImageAssets.notIcon,
                container: FittedBox(
                  child: Container(
                    height: 26.h,
                    width: 27.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: HexColor('#8281F8').withOpacity(0.2),
                    ),
                    child: SvgPicture.asset(
                      ImageAssets.notIcon,
                      fit: BoxFit.scaleDown,
                      width: 14.w,
                      height: 13.h,
                    ),
                  ),
                ),
                nColor: HexColor('#8281F8').withOpacity(0.2),
                title: widget.notificationItem.title ?? '',
                trailing: '7:00 PM',
                color: HexColor('#EC8E6C').withOpacity(0.06),
                sColor: HexColor('#EC8E6C'),
                subtitle: widget.notificationItem.message ?? ''),
          ),
          if (isPressed)
            buildNotificationsItem(
              context: context,
              leftWidth: isRtl() ? 20 : 0,
              rightWidth: isRtl() ? 0 : 20,
              container: Container(
                width: 87.w,
                height: 32.h,
                decoration: BoxDecoration(
                    color: statusColor.withAlpha(80),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(widget.notificationItem.message ?? '',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeightManager.semiBold,
                          fontFamily: FontConstants.cairoFontFamily,
                          fontSize: 13,
                        ))),
              ),
              iconColor: HexColor('#8281F8').withOpacity(0.20),
              color: HexColor('#EC8E6C').withOpacity(0.02),
              sColor: HexColor('#EC8E6C').withOpacity(0.02),
              title: widget.notificationItem.title ?? '',
              subtitle: '',
            )
        ],
      ),
    );
  }

  Color get statusColor {
    switch (widget.notificationItem.message) {
      case 'In Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.yellow;
      case 'Completed':
        return Colors.green;
      case 'Canceled':
        return Colors.red;
    }
    return Colors.black;
  }
}
