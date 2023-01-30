import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

abstract class FirebaseNotification {
  Future<void> requestPermission();
}

class FirebaseNotificationImpl implements FirebaseNotification {
  final FirebaseMessaging messaging;

  FirebaseNotificationImpl({required this.messaging});

  @override
  Future<void> requestPermission() async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.iOS) {
      await messaging.requestPermission();
    }
    // String? token = await messaging.getToken(
    //   vapidKey:
    //       "BHq01RtIm4ePQJDEoxrAYAjv44F2buyWBdBMnOFUiIra_VdUIfHy03BPXgCeXYhhUatBys_V2jE5RSV79waF49Y",
    // );
  }
}
