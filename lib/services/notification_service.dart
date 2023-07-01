import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  NotificationsService._();

  static NotificationsService instance = NotificationsService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    // Flutter Local Notification Init
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse? notificationResponse) {
        if (notificationResponse == null) return;
        onSelectNotification(notificationResponse.payload);
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'high_importance_channel', // name
      description: 'General Notification', // description
      importance: Importance.max,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound("sound"),
    );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    //------

    log('Notification Intiated ...');

    //Subscribe to particular topics
    await _messaging.subscribeToTopic('all');

    //-------Set listeners....
    /*
    Terminated app notification ...
     */

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? initialMessage) async {
      if (initialMessage != null) {
        onSelectNotification(json.encode(initialMessage.data));
      }
    });
    /*
    Foreground notification ...
     */
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      showNotification(
          message.notification.hashCode,
          message.notification!.title!,
          message.notification!.body!,
          message.data);
      log("Local notification called...");
    });

    /*
    Background notification ...
     */
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Got a message whilst in the background!');
      onSelectNotification(json.encode(message.data));
    });

    //------
  }

  Future onSelectNotification(payload) async {
    log("Notification selected..");
    Map data;
    if (payload != null) {
      data = json.decode(payload);
      data = json.decode(data['extraData']);
      log(data.toString());

      String type = data["type"];
      log("Notification check page..");

      notificationSettings(data).forEach((element) {
        if (type == element['type']) {}
      });
    }
  }

  void showNotification(
      int id, String title, String body, Map<String, dynamic> message) {
    _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', // id
          'high_importance_channel', // name
          channelDescription: 'General Notification', // description
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          // sound: RawResourceAndroidNotificationSound('sound'),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: json.encode(message),
    );
  }

  //-----Useful method...
  void subscribeToTopic(topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  void unSubscribeToTopic(topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }

  Future<String?> getFCMToken() async => await _messaging.getToken();
}

List notificationSettings(Map data) => [];
