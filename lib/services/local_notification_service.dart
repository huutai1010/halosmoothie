import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifiacations = FlutterLocalNotificationsPlugin();
  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          icon: '@mipmap/ic_launcher', importance: Importance.max),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifiacations.show(id, title, body, await _notificationDetails());
  }
}
