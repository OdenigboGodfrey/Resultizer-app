import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/home/data/datasources/chat_datasource.dart';
import 'package:resultizer_merged/features/home/data/models/chat_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_state.dart';
import 'package:resultizer_merged/onesignal_config.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  late FirebaseChatDataSource firebaseChatDataSource;

  void init(ChatMetaDTO chatMeta) {
    firebaseChatDataSource =
        FirebaseChatDataSource(fixtureId: chatMeta.fixtureId);
  }

  bool isNewMessageGroup = false;

  Future sendChat(ChatMetaDTO chatMeta, ChatDTO item) async {
    item.userId = GlobalDataSource.userData.id;
    emit(ChatLoading());
    if (isNewMessageGroup) {
      firebaseChatDataSource
          .createChatMeta(chatMeta)
          .then((value) => isNewMessageGroup = false);
    }
    final result = await firebaseChatDataSource.write(item);
    if (!result) {
      emit(ChatSendFail('Something went wrong, please try again.'));
    } else {
      emit(ChatSent('Action successful.'));
      var teamName = "${item.name} posted";
      
      
      sendNotification(
          topic: item.userId,
          title: teamName,
          content: item.message,
          data: {
            'chatMeta': chatMeta.toMap(),
            'chatItem': item.toJson(),
          },
          fixtureId: item.fixtureId,
          userId: item.userId);
    }
  }

  Future fixtureTipsListener() async {
    await firebaseChatDataSource.readListen((data) {
      if (data != null) {
        Map<dynamic, dynamic> chats = data;
        List<dynamic> chatArray = chats.values.toList();
        chatArray = sortChat(chatArray);
        existingChat = chatArray;
        if (chatArray.isNotEmpty) {
          emit(ChatReceived(existingChat));
        }
      }
    });
  }

  List<dynamic> existingChat = [];
  Future getExistingChat() async {
    existingChat = [];
    await firebaseChatDataSource.get((data) {
      for (int i = 0; i < data.length; i++) {
        DataSnapshot dataSnapShot = data[i];
        existingChat.add(dataSnapShot.value);
      }
      existingChat = sortChat(existingChat);
      emit(ChatReceived(existingChat));
      if (existingChat.isEmpty) {
        isNewMessageGroup = true;
      } else {
        isNewMessageGroup = false;
      }
    });
  }

  List<dynamic> sortChat(List<dynamic> data) {
    data.sort((a, b) {
      // Parse the date strings into DateTime objects
      DateTime dateA = DateTime.parse(a['dateTime']);
      DateTime dateB = DateTime.parse(b['dateTime']);

      // Compare DateTime objects to arrange the list in ascending order
      // return dateB.compareTo(dateA);
      return dateA.compareTo(dateB);
    });
    return data;
  }

  bool isInLast24Hrs(DateTime anotherDateTime) {
    DateTime last24HoursDateTime = DateTime.now().subtract(Duration(hours: 24));

    // Check if anotherDateTime falls within the last 24 hours
    bool isInLast24Hours = anotherDateTime.isAfter(last24HoursDateTime) &&
        anotherDateTime.isBefore(DateTime.now());

    if (isInLast24Hours) {
      return true;
    } else {
      return false;
    }
  }

  List<dynamic> filterTipsByDate(List<dynamic> data, String year) {
    data = data.where((element) {
      DateTime date = DateTime.parse(element['dateTime']);
      return isInLast24Hrs(date); // currentDate == tipDate;
    }).toList();
    return data;
  }

  Future allTipsListener() async {
    await firebaseChatDataSource.listenAll((data) {
      List chats = [];
      if (data != null) {
        Map<dynamic, dynamic> allChats = data;
        for (Map<dynamic, dynamic> item in allChats.values.toList()) {
          chats.addAll(filterTipsByDate(
              item.values.toList(), DateTime.now().year.toString()));
        }

        existingChat = sortChat(chats);
        emit(ChatReceived(existingChat));
        if (existingChat.isEmpty) {
          isNewMessageGroup = true;
        } else {
          isNewMessageGroup = false;
        }
      }
    });
  }

  Future getAllExistingTips() async {
    await firebaseChatDataSource.getAll((data) {
      List chats = [];
      if (data != null) {
        Map<dynamic, dynamic> allChats = data;
        for (Map<dynamic, dynamic> item in allChats.values.toList()) {
          chats.addAll(filterTipsByDate(
              item.values.toList(), DateTime.now().year.toString()));
        }

        existingChat = sortChat(chats);
        emit(ChatReceived(existingChat));
        if (existingChat.isEmpty) {
          isNewMessageGroup = true;
        } else {
          isNewMessageGroup = false;
        }
      }
    });
  }

  Future<bool> cancelAllTipsListener() async {
    return firebaseChatDataSource.cancelAllTipsListener();
  }

  Future<bool> cancelFixtureListener() async {
    return firebaseChatDataSource.cancelFixtureListener();
  }

  Future<bool> deleteChat(int fixtureId, String userId, String dateTime) {
    return firebaseChatDataSource.deleteChat(fixtureId, userId, dateTime);
  }

  Future<Map<dynamic, dynamic>> getChatMetaByFixtureId(int fixtureId) async {
    existingChat = [];
    Map<dynamic, dynamic> chatMeta =
        await firebaseChatDataSource.getChatMeta(fixtureId);
    return chatMeta;
  }
}
