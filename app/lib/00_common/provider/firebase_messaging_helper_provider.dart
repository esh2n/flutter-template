// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseMessagingHelperProvider = Provider<FirebaseMessagingHelper>(
    (ref) => FirebaseMessagingHelper(FCMConfig.instance));

class FirebaseMessagingHelper {
  FirebaseMessagingHelper(this.fcm) {
    fcm.init(
      defaultAndroidChannel: const AndroidNotificationChannel(
        'high_importance_channel',
        'Fcm config',
        importance: Importance.high,
        ledColor: Colors.green,
        enableLights: true,
        sound: RawResourceAndroidNotificationSound('notification'),
      ),
      onBackgroundMessage: _fcmBackgroundHandler,
    );

    FCMConfig.messaging.subscribeToTopic('test');
    FCMConfig.messaging.getToken().then((token) {
      print(token);
    });
  }

  Future<void> onNotification(
      RemoteMessage notification, void Function() setState) async {
    print("Handling a foreground message: ${notification.messageId}");
  }

  final FCMConfig fcm;
}

Future<void> _fcmBackgroundHandler(RemoteMessage notification) async {
  print("Handling a background message: ${notification.messageId}");
}
