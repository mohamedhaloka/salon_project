import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/models/notifications_model.dart';
import 'package:salon_app/shared/componants/componants.dart';

import '../../../layout/cubut/home_layout_cubit.dart';
import '../../../shared/componants/app_strings.dart';
import '../../../shared/componants/fonts_manager.dart';
import 'accept_notifications.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationItemData> notifications = <NotificationItemData>[];

  bool loading = true;

  @override
  void initState() {
    _getNotifications();
    super.initState();
  }

  Future<void> _getNotifications() async {
    await HomeLayoutCubit.instance.getNotifications(
      onSuccess: (response) {
        for (var item in response.data['data']) {
          notifications.add(NotificationItemData.fromJson(item));
        }
        print(response.data);
      },
      onError: (e) {},
    );
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: background(
          child: Padding(
        padding: EdgeInsets.only(top: 40.0.h, right: 20.w, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: (const Icon(Icons.arrow_back))),
                SizedBox(
                  width: 84.w,
                ),
                Text(
                  AppStrings.notifications.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontConstants.cairoFontFamily,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) => AcceptNotifications(
                        notificationItem: notifications[index],
                      ),
                      separatorBuilder: (_, __) => SizedBox(height: 2.h),
                      itemCount: notifications.length,
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
