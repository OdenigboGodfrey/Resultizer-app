import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/api/endpoints.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/app_session.dart';
import 'package:resultizer_merged/features/account/data/datasource/user_detail_datasource.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';
import 'package:resultizer_merged/features/bottom_navigation_bar/bottonnavigation.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/presentation/screen/fixture_screen.dart';

const String oneSignalKey = 'db1bd7a7-9029-465b-b8cf-a15311196e3a';
DioHelper? dioHelper;
// // // // v5.0.4

void initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(oneSignalKey);
  print('==== init one signal key ====');
  try {
    if (!OneSignal.Notifications.permission) {
      print('OneSignal.Notifications requesting permission');
      var result = await OneSignal.Notifications.requestPermission(true)
          .catchError((onError) {});
      print('OneSignal.Notifications.permission result');
      print(result);
      // if (!result) {
      //   return;
      // }
    }
  } catch (e, stackTrace) {
    print('OneSignal.Notifications requesting permission error');
    print(e);
    print(stackTrace);
  }

  print('==== one signal permission granted ====');

  await OneSignal.consentGiven(true);
  print('==== one signal consent given ====');

  print('==== creating ClickListener ====');

  OneSignal.Notifications.addClickListener((event) {
    if (event.result.actionId!.startsWith("unfollow")) {
      event.preventDefault();
    }
    print('==== handle notification button clicked ====');
    handleNotificationButtonClick(event);
  });
  print('==== creating ForegroundWillDisplayListener ====');
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    event.preventDefault();
    event.notification.display();
    print('====== foreground notification received ====');
    handleNotificationButtonClick(event);
  });
}

Future<void> subscribeToTag(String topic) async {
  OneSignal.User.addTagWithKey(topic, "tag")
      .then((value) {})
      .catchError((onError) {
    print(onError);
  });

  // OneSignal.User.addTagWithKey(key, value)
}

Future<void> unsubscribeFromTag(String topic) async {
  // OneSignal.User.removeAlias(topic)
  OneSignal.User.removeTag(topic).then((value) {}).catchError((onError) {
    print(onError);
  });
}

Future<bool> sendNotification({
  required String topic,
  required String title,
  required String content,
  required Map<String, dynamic> data,
  required int fixtureId,
  required String userId,
}) async {
  dioHelper ??= DioHelper(dio: Dio());
  var payload = {
    "filters": [
      {"field": "tag", "key": topic, "relation": "=", "value": "tag"}
    ],
    "headings": {"en": title},
    "contents": {"en": content},
    "data": data,
    "buttons": [
      {"id": "view-$fixtureId", "text": "View"},
      {"id": "unfollow-$userId", "text": "Unfollow"}
    ],
    "android_group": topic,
    "adm_group": topic,
    "thread_id": topic,
    "app_id": oneSignalAppId,
  };
  var result = await dioHelper!.dio
      .post(Endpoints.oneSignalBaseUrl + Endpoints.oneSignalNotification,
          data: payload,
          options: Options(
            headers: {
              'Authorization': 'Basic $oneSignalRestApiToken',
              'accept': 'application/json',
              'content-type': 'application/json',
            },
          ));
  if (result.statusCode != 200 || result.statusCode != 201) return false;
  if (result.data['id'].toString().isEmpty) {
    return false;
  } else {
    return true;
  }
}

void handleNotificationButtonClick(event) {
  print('handle notification button clicked');
  if (event.result.actionId == "") {
    // no button clicked
    // print('Body click');
    navigateToTipScreen();
  } else if (event.result.actionId!.startsWith("view")) {
    var viewId = event.result.actionId!.split("-")[1];
    print('viewId clicked');
    print(viewId);
    if (viewId == '0') {
      navigateToTipScreen();
    } else {
      print(event.notification.additionalData);
      // locate fixture
      navigateToFixtureScreen(event.notification.additionalData);
    }
    // print('View button click ${viewId}');
  } else if (event.result.actionId!.startsWith("unfollow")) {
    // event.
    var unfollowId = event.result.actionId!.split("-")[1];
    if (unfollowId != '0') {
      unFollowUser(unfollowId);
    }

    // print('Un-follow button click ${unfollowId}');
  }
}

void navigateToTipScreen() {
  Get.offAll(Bottom(
    selectedIndex: 2,
  ));
}

void navigateToFixtureScreen(Map item) {
  Map chatItem = item['chatItem'];
  Map chatMeta = item['chatMeta'];
  print('...navigating to fixture ${chatMeta['fixtureId']}');
  var gameTime = DateFormat('hh:mm')
      .format(DateTime.parse(chatMeta['matchTime'].toString()));
  print('gametime ${gameTime}');
  try {
    Get.offAll(FixtureScreen(
        leagueName: chatMeta['leagueName'].toString(),
        leagueLogo: chatMeta['leagueLogo'].toString(),
        leagueSubtitle: chatMeta['leagueSubtitle'].toString(),
        leagueId: int.parse((chatMeta['leagueId'] ?? 0).toString()),
        initialTab: 'tips',
        game: PremierGameDTO(
          gameTime: gameTime,
          homeLogo: chatMeta['awayTeamLogo'].toString(),
          homeTeam: chatMeta['awayTeam'].toString(),
          awayLogo: chatMeta['awayTeamLogo'].toString(),
          awayTeam: chatMeta['awayTeam'].toString(),
          matchStatus: '',
          matchTime: DateTime.parse(chatMeta['matchTime'].toString()),
          fixtureId: int.parse((chatMeta['fixtureId'] ?? 0).toString()),
          awayTeamId: int.parse((chatMeta['awayTeamId'] ?? 0).toString()),
          homeTeamId: int.parse((chatMeta['homeTeamId'] ?? 0).toString()),
        )));
  } catch (e, stackTrace) {
    print(stackTrace);
  }
  // Get.offAll(Bottom(
  //   selectedIndex: 2,
  // ));
}

void unFollowUser(String uid) async {
  FirebaseUserDetailDataSource firebaseUserDetailDataSource =
      FirebaseUserDetailDataSource();
  // unfollow on db
  firebaseUserDetailDataSource.toggleFollowUser(uid: uid);
  // unsubscribe from notification
  unsubscribeFromTag(uid);
  // remove from local and in app data store
  User? user;
  if (GlobalDataSource.userData != null) {
    user = GlobalDataSource.userData;
  } else {
    var userData = await AppSession.getItem("userData");

    if (userData != null) {
      GlobalDataSource.userData = User.fromMap(userData);
      user = GlobalDataSource.userData;
    }
  }

  if (user != null) {
    user.following!.remove(uid);
    GlobalDataSource.userData = user;
    AppSession.writeGlobalUserDataToLocal();
  }
}
