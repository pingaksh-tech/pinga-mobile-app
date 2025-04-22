import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../../exports.dart';

class NotificationsHelper {
  // prevent making instance
  NotificationsHelper._();

  // Notification lib
  static AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  static int _createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  ///  *********************************************
  ///     NOTIFICATIONS CHANNELS
  ///  *********************************************

  static NotificationChannel highImportanceChannel = NotificationChannel(
    channelKey: 'high_importance_channel',
    channelName: 'Basic notifications',
    channelDescription: 'Notification channel for basic tests',
    defaultColor: AppColors.primary,
    ledColor: Colors.white,
    playSound: true,
    onlyAlertOnce: true,
    groupAlertBehavior: GroupAlertBehavior.Children,
    importance: NotificationImportance.High,
    defaultPrivacy: NotificationPrivacy.Private,
  );

  ///  *********************************************
  ///     INIT
  ///  *********************************************

  static init() async {
    try {
      await awesomeNotifications.requestPermissionToSendNotifications();
      await _initNotification();
    } catch (e) {
      printErrors(type: "Notification Init", errText: e);
    }
  }

  ///  *********************************************
  ///     INITIALISE NOTIFICATIONS CHANNELS
  ///  *********************************************

  static _initNotification() async {
    await awesomeNotifications.initialize(
      "resource://drawable/ic_notification",
      [highImportanceChannel],
    );

    /// START NOTIFICATION ON-TAP LISTENERS
    startListeningNotificationEvents();
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************

  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS ==> ON-TAP
  ///  *********************************************

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    Map<String, String?>? payload = receivedAction.payload;
    printYellow("onActionReceivedMethod : $payload");
  }

  ///  *********************************************
  ///     CREATE NOTIFICATIONS
  ///  *********************************************

  static Future<void> createNewNotification({
    required final String title,
    required final String body,
    final Map<String, String>? payload,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final String? bigPicture,
    final String? largeIcon,
  }) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = true;
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: highImportanceChannel.channelKey ?? UniqueKey().hashCode.toString(),
        title: title,
        body: body,
        bigPicture: bigPicture,
        // largeIcon: largeIcon ?? "asset://${AppAssets.textLogoPNG}",
        notificationLayout: notificationLayout,
        payload: payload,
      ),
    );
  }
}
