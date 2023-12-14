import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

const String realTimeDatabaseURL = 'https://flutterfirebase-41e68-default-rtdb.europe-west1.firebasedatabase.app';

abstract class ManageChatDataSource {
  // Future<bool> readListen(Function emitter);
  Future<int> countChat(int fixtureId);
  Future<bool> deleteChat(int fixtureId);
  Future<Iterable<DataSnapshot>> getChatsMeta();
  Future<bool> deleteChatMeta(int fixtureId);
}

class FirebaseManageChatDataSource extends ManageChatDataSource {
  FirebaseDatabase fixtureChatRef = FirebaseDatabase.instance;
  FirebaseDatabase chatMetaRef = FirebaseDatabase.instance;
  late int fixtureId;

  FirebaseManageChatDataSource() {
    fixtureChatRef = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL: realTimeDatabaseURL);
    chatMetaRef = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: realTimeDatabaseURL);
  }

  @override
  Future<int> countChat(int fixtureId) async {
    var key = "${AppString.chatCollectionKey}/$fixtureId";
    var tmpRef = fixtureChatRef.ref(key);
    var getResult = await tmpRef.get();
    return getResult.children.length;
  }

  @override
  Future<bool> deleteChat(int fixtureId) async {
    var key = "${AppString.chatCollectionKey}/$fixtureId";
    var tmpRef = fixtureChatRef.ref(key);
    if ((await tmpRef.get()).exists) {
      await tmpRef.remove();
      return true;
    }
    return false;
  }

  @override
  Future<Iterable<DataSnapshot>> getChatsMeta() async {
    var key = AppString.chatMetaCollectionKey;
    var getResult = await chatMetaRef.ref(key).get();
    return getResult.children;
  }

  @override
  Future<bool> deleteChatMeta(int fixtureId) async {
    var key = '${AppString.chatMetaCollectionKey}/$fixtureId';
    var tmpRef = chatMetaRef.ref(key);
    if ((await tmpRef.get()).exists) {
      await tmpRef.remove();
      return true;
    }
    return false;
  }
}
