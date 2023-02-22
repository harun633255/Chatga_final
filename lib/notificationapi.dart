

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi{

  static final _notifications = FlutterLocalNotificationsPlugin();
  //static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async{
    return NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId', 'channelName',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'test'
        ),
    );
  }

  static Future init({bool initScheduled = false}) async{
    await _notifications.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('ll'),
      ),
        onDidReceiveNotificationResponse: (payload) async{
       // onNotification.add(payload);
        }
    );
  }

  static Future showNotification(
      {required int id,
        required String title,
        required String body,
        required String payload}) async => await _notifications.show(
    id,
    title,
    body,
    await NotificationDetails(),
    payload: payload,
  );
}