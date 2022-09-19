import 'package:dawnsapp/Views/notification/notification_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initialize(BuildContext context) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      if (route != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationPage(
                      title: Provider.of<LocalNotificationValues>(context,
                              listen: false)
                          .mainTitle,
                      desc: Provider.of<LocalNotificationValues>(context,
                              listen: false)
                          .description,
                      imageLink: Provider.of<LocalNotificationValues>(context,
                              listen: false)
                          .imageLink,
                    )));
      }
    });
  }

  void display(RemoteMessage message, BuildContext context) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "default_notification_channel_id",
        "default_notification_channel_id",
        channelDescription: "channel description",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notificationsPlugin.show(
        id,
        message.notification?.title ?? "",
        message.notification?.body ?? "",
        notificationDetails,
        payload: "dummyData",
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

class LocalNotificationValues with ChangeNotifier {
  var mainTitle;
  var description;
  var imageLink;

  setValues(title, desc, image) {
    mainTitle = title;
    description = desc;
    imageLink = image;
    notifyListeners();
  }
}
