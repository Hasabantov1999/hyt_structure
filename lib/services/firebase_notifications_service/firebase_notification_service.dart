import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../core/util/developer_log.dart';
import '../notification_service/notification.dart';

class FirebaseNotificationService {
  static final FirebaseNotificationService _singleton =
      FirebaseNotificationService._internal();

  factory FirebaseNotificationService() {
    return _singleton;
  }

  FirebaseNotificationService._internal();
  late final FirebaseMessaging messaging;

  String? fcmToken;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> connectNotification() async {
    await FirebaseMessaging.instance.requestPermission();
    messaging = FirebaseMessaging.instance;

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        DeveloperLog.instance.logSuccess(message.notification!.toMap());
        if (Platform.isAndroid) {
          await LocaleNotification().initialize(
            flutterLocalNotificationsPlugin,
          );
          LocaleNotification.showBigTextNotification(
            title: message.notification?.title ?? '',
            body: message.notification?.body ?? '',
            fln: flutterLocalNotificationsPlugin,
            payload: message.data,
          );
        }
      }
    });

    fcmToken = await messaging.getToken() ?? '';

    log("Token: $fcmToken", name: "FCM Token");
  }
}
