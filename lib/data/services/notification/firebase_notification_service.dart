import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../exports.dart';
import 'notification_helper.dart';

class FirebaseNotificationService {
  static Future<void> initialise() async {
    await requestNotificationPermission();
    String? fcmToken = await getFCMToken();
    if (!isValEmpty(fcmToken)) {
      printOkStatus("FCM: $fcmToken");
    }
    firebaseMessagingForegroundHandler();
  }

  static Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.requestPermission().then(
      (_) {
        try {
          return FirebaseMessaging.instance.getToken().then(
            (token) {
              storeDeviceInformation(token);
              return token;
            },
          );
        } catch (e) {
          return null;
        }
      },
    );
  }

  static Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    printOkStatus('User granted permission: ${settings.authorizationStatus}');
  }

  /// ***********************************************************************************
  ///                          FOREGROUND NOTIFICATION LISTENER
  /// ***********************************************************************************

  static Future<void> firebaseMessagingForegroundHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printOkStatus('Got a message whilst in the foreground!');
      printOkStatus('Message data: ${message.data}');
      if (Platform.isAndroid) {
        handleNotifications(remoteMessage: message);
      }
    });
  }

  /// ***********************************************************************************
  ///                           BACKGROUND NOTIFICATION LISTENER
  /// ***********************************************************************************

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    printOkStatus("Handling a background message: ${message.messageId}");
  }

  /// ***********************************************************************************
  ///                                HANDLE NOTIFICATION CALL
  /// ***********************************************************************************

  static handleNotifications({
    required RemoteMessage remoteMessage,
  }) async {
    RemoteNotification? remoteNotification = remoteMessage.notification;
    String title = remoteNotification?.title ?? "";
    String body = remoteNotification?.body ?? "";
    final String? imageUrl = remoteMessage.notification?.android?.imageUrl ?? remoteMessage.notification?.apple?.imageUrl;
    var payload = convertStringMap(remoteMessage.data);

    printOkStatus("title: $title");
    printOkStatus("body: $body");
    printOkStatus("imageUrl: $imageUrl");
    printOkStatus("payload: $payload");

    await NotificationsHelper.createNewNotification(
      title: title,
      body: body,
      bigPicture: imageUrl,
      payload: payload,
      notificationLayout: (isValEmpty(imageUrl)) ? NotificationLayout.BigText : NotificationLayout.BigPicture,
    );
  }
}
