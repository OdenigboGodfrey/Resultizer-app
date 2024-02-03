import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/show_confirmation_dialog.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/core/widgets/trensations_widgets.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/chat_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_state.dart';
import 'package:resultizer_merged/features/home/presentation/screen/fixture_screen.dart';
import 'package:resultizer_merged/features/home/presentation/widget/chat/widgets_chats.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class ChatView extends StatefulWidget {
  ChatView({
    ChatMetaDTO? chatMeta,
    super.key,
  }) {
    this.chatMeta = chatMeta ??
        ChatMetaDTO(
            homeTeam: '',
            awayTeam: '',
            homeTeamLogo: '',
            awayTeamLogo: '',
            leagueName: 'General',
            matchTime: DateTime.now(),
            fixtureId: 0,
            leagueLogo: '',
            leagueSubtitle: '',
            awayTeamId: 0,
            homeTeamId: 0,
            leagueId: 0,
        );
  }
  ChatMetaDTO? chatMeta;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  _ChatViewState() {}
  late ChatCubit chatCubit;
  bool isLoaded = false;
  var _message = TextEditingController();
  ColorNotifire notifire = ColorNotifire();

  @override
  void initState() {
    super.initState();
    initListener();
  }

  @override
  void dispose() {
    // Remove the listener when the page is disposed
    if (widget.chatMeta!.fixtureId != 0) {
      disposeFixtureListener();
    } else {
      disposeAllTipsListener();
    }
    super.dispose();
  }

  initListener() async {
    //chatCubit = BlocProvider.of<ChatCubit>(context);
    if (widget.chatMeta!.fixtureId != 0) {
      await initFixtureListener();
    } else {
      await initAllTipsListener();
    }
  }

  initFixtureListener() async {
    chatCubit = context.read<ChatCubit>();
    chatCubit.init(widget.chatMeta!);
    await chatCubit.getExistingChat();
    chatCubit.fixtureTipsListener();
  }

  initAllTipsListener() async {
    chatCubit = context.read<ChatCubit>();
    chatCubit.init(widget.chatMeta!);
    // await chatCubit.getAllExistingTipsAndFilterByDate();
    chatCubit.allTipsListener();
  }

  disposeFixtureListener() async {
    chatCubit.cancelFixtureListener();
  }

  disposeAllTipsListener() async {
    chatCubit = context.read<ChatCubit>();
    chatCubit.cancelAllTipsListener();
  }

  void deleteChat(int fixtureId, String userId, String dateTime) {
    // return [];
    chatCubit = context.read<ChatCubit>();
    chatCubit.deleteChat(fixtureId, userId, dateTime);
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    var chatMeta = widget.chatMeta;

    return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var existingChat = chatCubit.existingChat.reversed.toList();
          List<String> userRoles = GlobalDataSource.userData.roles ?? [];
          return Container(
            height: height * 0.62,
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                    children: [
                      SizedBox(height: 15.0),
                      if (existingChat.isEmpty)
                        Center(child: Text('No recent tips to show', style: TextStyle(color: notifire.textcolore),)),
                      for (int i = 0; i < existingChat.length; i++)
                        ShakeListTransition(
                          duration: Duration(milliseconds: (i + 2) * 300),
                          axis: Axis.horizontal,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: CardChat(
                                  fixtureId:
                                      existingChat.elementAt(i)['fixtureId'],
                                  name: existingChat.elementAt(i)['name'],
                                  message: existingChat.elementAt(i)['message'],
                                  dateTime: DateTime.parse(
                                      existingChat.elementAt(i)['dateTime']),
                                      uid: existingChat.elementAt(i)['userId'] ?? '',
                                ),
                              ),
                              Expanded(
                                flex: (GlobalDataSource.userData.roles
                                        .contains(AppString.admin))
                                    ? 2
                                    : 1,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    if (GlobalDataSource.userData.roles
                                        .contains(AppString.admin))
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: notifire.textcolore,
                                        ),
                                        onTap: () {
                                          showConfirmationDialog(
                                              context,
                                              () => deleteChat(
                                                  existingChat.elementAt(
                                                      i)['fixtureId'],
                                                  existingChat
                                                      .elementAt(i)['userId'],
                                                  existingChat.elementAt(
                                                      i)['dateTime']));
                                        },
                                      ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    if (existingChat
                                            .elementAt(i)['fixtureId'] !=
                                        0)
                                      GestureDetector(
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: notifire.textcolore,
                                        ),
                                        onTap: () {
                                          // get chat meta
                                          showSnack(context, 'Location fixture...', Colors.blueAccent);
                                          chatCubit
                                              .getChatMetaByFixtureId(
                                                  existingChat.elementAt(
                                                      i)['fixtureId'])
                                              .then((item) {
                                            // navigate to fixture screen
                                            var gameTime = DateFormat('hh:mm')
                                                .format(DateTime.parse(item['matchTime']));
                                            Get.to(FixtureScreen(
                                                leagueName: item['leagueName'],
                                                leagueLogo: item['leagueLogo'],
                                                leagueSubtitle:
                                                    item['leagueSubtitle'],
                                                leagueId: item['leagueId'],   
                                                game: PremierGameDTO(
                                                    gameTime: gameTime,
                                                    homeLogo:
                                                        item['awayTeamLogo'],
                                                    homeTeam: item['awayTeam'],
                                                    awayLogo:
                                                        item['awayTeamLogo'],
                                                    awayTeam: item['awayTeam'],
                                                    matchStatus: '',
                                                    matchTime: DateTime.parse(item['matchTime']),
                                                    fixtureId:
                                                        item['fixtureId'],
                                                    awayTeamId: item['awayTeamId'],
                                                    homeTeamId: item['homeTeamId'],
                                                        )));
                                          }).catchError((onError, stackTrace) {
                                            print('error');
                                            print(onError);
                                            print(stackTrace);
                                          });
                                        },
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
                if (userRoles.contains(AppString.admin) ||
                    userRoles.contains(AppString.tipster))
                  Expanded(
                    flex: 2,
                    child: ShakeTransition(
                      duration: Duration(milliseconds: 1800),
                      axis: Axis.vertical,
                      child: InputCommentUser(
                        control: _message,
                        onTap: () {
                          if (_message.text.isNotEmpty) {
                            chatCubit
                                .sendChat(
                                    chatMeta!,
                                    ChatDTO(
                                        name:
                                            GlobalDataSource.userData.username,
                                        message: _message.text,
                                        fixtureId: widget.chatMeta!.fixtureId,
                                      userId: GlobalDataSource.userData.id,
                                      ))
                                .then((value) {
                              _message.clear();
                            });
                          }
                        },
                        // userImage: GlobalDataSource.userData.profileImageURL
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
