import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/widgets/trensations_widgets.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/chat_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_state.dart';
import 'package:resultizer_merged/features/home/presentation/widget/chat/widgets_chats.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.chatMeta});
  final ChatMetaDTO chatMeta;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  _ChatViewState() {}
  late ChatCubit chatCubit;
  bool isLoaded = false;
  var _message = TextEditingController();

  @override
  void initState() {
    super.initState();
    initListener();
  }

  initListener() async {
    //chatCubit = BlocProvider.of<ChatCubit>(context);
    chatCubit = context.read<ChatCubit>();
    chatCubit.init(widget.chatMeta);
    await chatCubit.getExistingChat();
    chatCubit.chatListener();
  }

  @override
  Widget build(BuildContext context) {
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
                      for (int i = 0; i < existingChat.length; i++)
                        ShakeListTransition(
                          duration: Duration(milliseconds: (i + 2) * 300),
                          axis: Axis.horizontal,
                          child: CardChat(
                            name: existingChat.elementAt(i)['name'],
                            message: existingChat.elementAt(i)['message'],
                            dateTime: DateTime.parse(existingChat.elementAt(i)['dateTime']),
                          ),
                        ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
                if (userRoles.contains(AppString.admin) || userRoles.contains(AppString.tipster))
                  Expanded(
                    flex: 2,
                    child: ShakeTransition(
                      duration: Duration(milliseconds: 1800),
                      axis: Axis.vertical,
                      child: InputCommentUser(
                        control: _message,
                        onTap: () {
                          if (_message.text.isNotEmpty) {
                            chatCubit.sendChat(
                                chatMeta,
                                ChatDTO(
                                    name: GlobalDataSource.userData.fullname,
                                    message: _message.text)).then((value) {
                                      _message.clear();
                                    });
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
