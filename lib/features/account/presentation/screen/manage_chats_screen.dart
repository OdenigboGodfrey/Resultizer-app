// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_textfild.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/manage_chat_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/widget/chat_item_widget.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class ManageChatsScreen extends StatefulWidget {
  const ManageChatsScreen({super.key});

  @override
  State<ManageChatsScreen> createState() => _ManageChatsScreenState();
}

class _ManageChatsScreenState extends State<ManageChatsScreen> {
  ColorNotifire notifire = ColorNotifire();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailSearchController = TextEditingController();
  List<String> selectedRoles = [];

  bool hasResult = false;
  bool isSearching = false;
  bool isAdmin = false;
  bool isTipster = false;

  List<ChatMetaDTO> chatMetas = [];

  @override
  void initState() {
    super.initState();
    getChatMeta();
  }

  getChatMeta() async {
    manageChatCubit = context.read<ManageChatCubit>();
    chatMetas = await manageChatCubit.getAllChatMeta();
    setState(() {});
  }

  late ManageChatCubit manageChatCubit;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    // manageChatCubit = context.read<ManageChatCubit>();
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      appBar: AppBar(
        backgroundColor: notifire.bgcolore,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_sharp,
              color: notifire.textcolore,
            )),
        title: const Text("Manage chats"),
        titleTextStyle: TextStyle(
          fontFamily: "Urbanist_bold",
          color: notifire.textcolore,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          for (var item in chatMetas)
            ChatItemWidget(
              item: item,
              parentHandleDelete: (status) {
                if (status) {
                  chatMetas.removeAt(chatMetas.indexOf(item));
                  setState(() {});
                }

              },
            ),
        ],
      ),
    );
  }
}
