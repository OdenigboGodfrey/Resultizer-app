import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/chat_dto.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

abstract class ChatDataSource {
  final firebaseApp = Firebase.app();
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<bool> write(ChatDTO item);
  Future<bool> update(ChatDTO item);
  Future<bool> readListen(Function emitter);
  Future<bool> get(Function emitter);
  Future<bool> createChatMeta(ChatMetaDTO item);
  Future<Iterable<DataSnapshot>> getChatMeta(int fixtureId);
}

class FirebaseChatDataSource extends ChatDataSource {
  DatabaseReference fixtureChatRef = FirebaseDatabase.instance.ref();
  FirebaseDatabase chatRef = FirebaseDatabase.instance;
  int fixtureId;

  FirebaseChatDataSource({required this.fixtureId}) {
    fixtureChatRef = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                'https://flutterfirebase-41e68-default-rtdb.europe-west1.firebasedatabase.app')
        .ref("${AppString.chatCollectionKey}/$fixtureId");
    chatRef = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            'https://flutterfirebase-41e68-default-rtdb.europe-west1.firebasedatabase.app');
  }

  Future<bool> get(Function emitter) async {
    var getResult = await fixtureChatRef.get();
    emitter(getResult.children.toList());
    return true;
  }

  @override
  Future<bool> readListen(Function emitter) async {
    fixtureChatRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      emitter(data);
    });
    return true;
  }

  @override
  Future<bool> update(ChatDTO item) async {
    await fixtureChatRef.update(item.toJson());
    return true;
  }

  @override
  Future<bool> write(ChatDTO item) async {
    // add new key
    var tmpRef = fixtureChatRef.push();
    // write data to new key
    tmpRef.set(item.toJson());
    return true;
  }

  @override
  Future<bool> createChatMeta(ChatMetaDTO item) async {
    var key = "${AppString.chatMetaCollectionKey}/${item.fixtureId}";
    // extra check to see if Chat meta exists
    var checkResult = await getChatMeta(item.fixtureId);
    if (checkResult.isEmpty) {
      var tmpRef = chatRef.ref(key);
      tmpRef.set(item.toMap());
      return true;
    }
    return false;
  }

  @override
  Future<Iterable<DataSnapshot>> getChatMeta(int fixtureId) async {
    var key = "${AppString.chatMetaCollectionKey}/$fixtureId";
    var getResult = await chatRef.ref(key).get();
    return getResult.children;
  }
}
