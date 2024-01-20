import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/chat_dto.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

abstract class NotificationDataSource {
  final firebaseApp = Firebase.app();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  Future<void> foregroundListener(Function listenerHandler);
  Future<void> backgroundListener(Function listenerHandler);
  Future<void> destroyListener();
  Future<NotificationSettings> requestNotificationPermissions();
  dynamic pushNotification(String topic, dynamic data);

  // Future<bool> write(ChatDTO item);
}

class FirebaseNotificationDataSource extends NotificationDataSource {
  @override
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  List<String> topics = ['topic1', 'topic2', 'topic3'];

  FirebaseNotificationDataSource(); // {}

  StreamSubscription<RemoteMessage>? foregroundStream;

  @override
  Future<NotificationSettings> requestNotificationPermissions() {
    return _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  dynamic pushNotification(String topic, dynamic data) async {
    await subscribeToTopic(topic);
    // FirebaseMessaging.instance.sendMessage()
    // _firebaseMessaging.sendMessage(data: {'key': 'value'});
    // return _firebaseMessaging.
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @override
  Future<void> foregroundListener(Function listenerHandler) async {
    foregroundStream =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('reixceved');
      // Handle foreground messages
      listenerHandler(message);
    });
  }

  @override
  Future<void> backgroundListener(Function listenerHandler) async {
    print('creating background listener');
    try {
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        // Handle foreground messages
        print('background reixceved');
        listenerHandler(message);
        // return;
      });
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }

  @override
  Future<void> destroyListener() async {
    if (foregroundStream != null) {
      foregroundStream!.cancel();
    }
  }
}
