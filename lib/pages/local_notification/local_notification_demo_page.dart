import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationDemoPage extends StatefulWidget {
  const LocalNotificationDemoPage({super.key});

  @override
  State<LocalNotificationDemoPage> createState() =>
      _LocalNotificationDemoPageState();
}

class _LocalNotificationDemoPageState extends State<LocalNotificationDemoPage> {
  // initialise the plugin of flutterlocalnotifications.
  final flip = FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: notification,
              child: const Text('notification'),
            ),
            InkWell(
              onTap: cancel,
              child: const Text('cancel'),
            ),
          ],
        ),
      ),
    );
  }

  void cancel() {
    flip.cancel(0);
  }

  void notification() {
    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();

    // initialise settings for both Android and iOS device.
    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    flip.initialize(settings);
    _showNotificationWithDefaultSound();
  }

  _showNotificationWithDefaultSound() async {
    // Show a notification after every 15 minute with the first
    // appearance happening a minute after invoking the method
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      showProgress: true,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    // initialise channel platform for both Android and iOS device.
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flip.show(
      0,
      'GeeksforGeeks',
      'Your are one step away to connect with GeeksforGeeks',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}
