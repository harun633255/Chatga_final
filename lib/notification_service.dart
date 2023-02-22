

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin
      = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
  AndroidInitializationSettings('ll');

  void initializeNotifications() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  sendNotification(String title,String body) async {

final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'channelId', 'channelName',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'test');


    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

   await _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        notificationDetails
    );
  }
}