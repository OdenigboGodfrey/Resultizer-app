import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/expandDropDown.widget.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/manage_chat_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/widget/profile_tips_widget/tip_item_widget.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_cubit.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';

class TipsterTipItemWidget extends StatefulWidget {
  final String uid;
  Function setState;

  TipsterTipItemWidget({
    super.key,
    required this.uid,
    required this.setState,
  });

  @override
  State<TipsterTipItemWidget> createState() => _TipsterTipItemWidgetState();
}

class _TipsterTipItemWidgetState extends State<TipsterTipItemWidget> {
  ColorNotifire notifire = ColorNotifire();
  late int chatCount = 0;
  late ManageChatCubit manageChatCubit;
  late ChatCubit chatCubit;
  List<dynamic> userTips = [];

  @override
  void initState() {
    super.initState();
    getChat();
  }

  List<Widget> result = [];

  getChat() async {
    manageChatCubit = context.read<ManageChatCubit>();
    chatCubit = context.read<ChatCubit>();
    var allTips = await chatCubit.getAllExistingTips();
    // print('userTips');
    // print(allTips.length);
    userTips = manageChatCubit.filterChatByUserId(allTips, widget.uid);
    setState(() {});
  }

  buildTips() {
    result = [];
    int maxLoopIteration = 5;
    int loopLength = (userTips.length > maxLoopIteration ? maxLoopIteration : userTips.length);
    userTips = userTips.reversed.toList();
    for (int i = 0; i < loopLength; i++) {
      var item = userTips[i];
      var hour = DateFormat('hh:mm')
      .format(DateTime.parse(item['dateTime'].toString()));
      var day = DateFormat('yyyy-MM-dd')
      .format(DateTime.parse(item['dateTime'].toString()));

      Size size = MediaQuery.of(context).size;
      double height = size.height;
      double width = size.width;
      result.add(
        // ExpandDropDown(
        //   title: SizedBox(
        //     child: Row(
        //       children: [
        //         Expanded(
        //           child: Image.asset(
        //             AppAssets.football,
        //             height: 30,
        //             width: 30,
        //             color: notifire.textcolore,
        //           ),
        //         ),
        //         Expanded(
        //           child: Container(
        //             alignment: Alignment.centerRight,
        //             child: Icon(Icons.arrow_downward, size: 20, color: notifire.textcolore),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   child: Column(
        //   children: [
        //     Container(
        //       // height: 80,
        //       width: width,
        //       child: ListTile(
        //         contentPadding: EdgeInsets.symmetric(horizontal: 2),
        //         leading: SizedBox(
        //           width: 0.05 * width,
        //           child: Image.asset(
        //             AppAssets.football,
        //             height: 30,
        //             width: 30,
        //             color: notifire.textcolore,
        //           ),
        //         ),
        //         title: Container(
        //           width: 0.8 * width,
        //           child:  Text(
        //               item['message'], // item['message'],
        //               style: TextStyle(
        //                 fontFamily: 'Urbanist_bold',
        //                 fontSize: 13,
        //                 fontWeight: FontWeight.w700,
        //                 color: notifire.textcolore,
        //               ),
        //               // maxLines: 2,
        //               softWrap: true,
        //             ),
        //         ),
        //         trailing: SizedBox(
        //           width: 0.15 * width,
        //           child: Column(
        //             children: [
        //               Text(
        //                   day,
        //                   style: TextStyle(
        //                     fontFamily: 'Urbanist_bold',
        //                     fontSize: 10,
        //                     color: notifire.textcolore,
        //                   ),
        //                   // maxLines: 2,
        //                   softWrap: true,
        //                 ),
        //                 const SizedBox(height: 5,),
        //                 Text(
        //                   hour,
        //                   style: TextStyle(
        //                     fontFamily: 'Urbanist_bold',
        //                     fontSize: 10,
        //                     color: notifire.textcolore,
        //                   ),
        //                   // maxLines: 2,
        //                   softWrap: true,
        //                 ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     Divider(
        //       color: notifire.textcolore,
        //       height: 2,
        //     ),
        //     const SizedBox(
        //       height: 10,
        //     ),
        //   ],
        //       ),
        // ));
    
      TipItemWidget(item: item, setState: widget.setState,)
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);

    return Column(
      children: buildTips(),
    );
  }
}

