import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../exports.dart';
import 'notification_helper.dart';

class NotificationService {
  static Future<void> initialise() async {
    await requestNotificationPermission();
    String? fcmToken = await getFCMToken();
    if (!isValEmpty(fcmToken)) {
      printOkStatus("FCM: $fcmToken");
    }
    notificationListeners();
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

  static Future<void> notificationListeners() async {
    /// ***********************************************************************************
    ///                                   FOREGROUND
    /// ***********************************************************************************

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printOkStatus('Got a message whilst in the foreground!');
      printOkStatus('Message data: ${message.data}');

      handleNotifications(remoteMessage: message);
    });
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
