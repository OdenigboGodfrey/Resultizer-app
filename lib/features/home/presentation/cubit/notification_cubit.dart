import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/notification_state.dart';
import 'package:resultizer_merged/features/notification/data/datasource/notification_datasource.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('background notification');
  print(message);
}

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(NotificationInitial());

  late FirebaseNotificationDataSource firebaseNotificationDataSource;

  void init() async {
    firebaseNotificationDataSource = FirebaseNotificationDataSource();
    await doSth();
  }

  Future<void> doSth() async {
    var settings = await firebaseNotificationDataSource.requestNotificationPermissions();
    print('User granted permission: ${settings.authorizationStatus}');
  }

  void listen() {
    foregroundNotificationListener();
    // backgroundNotificationListener();
  }

  void destroy() {
    destroyListener();
  }

  Future foregroundNotificationListener() async {
    print('foreground notification listening');
    await firebaseNotificationDataSource.foregroundListener((data) {
      print('foreground notification');
      print(data);
    });
  }

  Future backgroundNotificationListener() async {
    print('background notification listening');
    await firebaseNotificationDataSource
        .backgroundListener(_firebaseMessagingBackgroundHandler);
    // await firebaseNotificationDataSource.backgroundListener((data) {
    //   print('background notification');
    //   print(data);
    // });
  }

  Future<void> subscribeToTopic(String topic) async {
    return firebaseNotificationDataSource.subscribeToTopic(topic);
  }

  // Future<bool> cancelAllTipsListener() async {
  //   return firebaseNotificationDataSource.cancelAllTipsListener();
  // }

  Future<void> unsubscribeFromTopic(String topic) async {
    return firebaseNotificationDataSource.unsubscribeFromTopic(topic);
  }

  Future<void> destroyListener() async {
    return firebaseNotificationDataSource.destroyListener();
  }
}
