import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/widgets/expandDropDown.widget.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/manage_chat_cubit.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';

class TipItemWidget extends StatefulWidget {
  TipItemWidget({super.key, required this.item, required this.setState});
  dynamic item;
  Function setState;

  @override
  State<TipItemWidget> createState() => _TipItemWidgetState();
}

class _TipItemWidgetState extends State<TipItemWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatMeta();
  }
  
  late ManageChatCubit manageChatCubit;
  ChatMetaDTO? chatMeta;
  bool isBuilding = false;
  
  getChatMeta() async {
    // get chat meta for this tip
    manageChatCubit = context.read<ManageChatCubit>();
    var result = await manageChatCubit.getChatMeta(widget.item['fixtureId']);
    setState(() {
      chatMeta = result;
      isBuilding = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      double height = size.height;
      double width = size.width;

      var item = widget.item;
      var hour = DateFormat('hh:mm')
      .format(DateTime.parse(item['dateTime'].toString()));
      var day = DateFormat('dd MMM')
      .format(DateTime.parse(item['dateTime'].toString()));
      var year = DateFormat('yyyy')
      .format(DateTime.parse(item['dateTime'].toString()));

      var tipTitle = item['message'].toString().substring(0, 25) + "...";
      // print('rebuilding chatMeta');
      // if (chatMeta != null) {
        
      //   print(chatMeta!.toMap());
      //   if (item['fixtureId'] == 0) {
      //     tipTitle = 'General Tips';
      //   } else {
      //     tipTitle = '${chatMeta!.homeTeam} - ${chatMeta!.awayTeam}';
      //   }  
      // }
      
    return Column(
      children: [
        ExpandDropDown(
              title: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    // Expanded(
                    //   child: Image.asset(
                    //     AppAssets.football,
                    //     height: 30,
                    //     width: 30,
                    //     color: notifire.textcolore,
                    //   ),
                    // ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          tipTitle,
                          style: TextStyle(
                            fontFamily: 'Urbanist_bold',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: notifire.textcolore,
                          ),
                          // maxLines: 2,
                          softWrap: true,
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_downward, size: 20, color: notifire.textcolore),
                      ),
                    ),
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                child: Row(
                  children: [
                    Container(
                            width: 0.55 * (width),
                            child:  Text(
                                item['message'], // item['message'],
                                style: TextStyle(
                                  fontFamily: 'Urbanist_bold',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: notifire.textcolore,
                                ),
                                // maxLines: 2,
                                softWrap: true,
                              ),
                          ),
                          Container(
                        width: 0.1 * width,
                        child: Column(
                          children: [
                            Text(
                                hour,
                                style: TextStyle(
                                  fontFamily: 'Urbanist_bold',
                                  fontSize: 10,
                                  color: notifire.textcolore,
                                ),
                                // maxLines: 2,
                                softWrap: true,
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                day,
                                style: TextStyle(
                                  fontFamily: 'Urbanist_bold',
                                  fontSize: 10,
                                  color: notifire.textcolore,
                                ),
                                // maxLines: 2,
                                softWrap: true,
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                year,
                                style: TextStyle(
                                  fontFamily: 'Urbanist_bold',
                                  fontSize: 10,
                                  color: notifire.textcolore,
                                ),
                                // maxLines: 2,
                                softWrap: true,
                              ),
                              
                          ],
                        ),
                      ),
                  ],
                ),
              )
              // Column(
              // children: [
              //   Container(
              //     // height: 80,
              //     width: width,
              //     child: ListTile(
              //       contentPadding: EdgeInsets.symmetric(horizontal: 2),
              //       // leading: SizedBox(
              //       //   width: 0.00 * width,
              //       //   child: Image.asset(
              //       //     AppAssets.football,
              //       //     height: 30,
              //       //     width: 30,
              //       //     color: notifire.textcolore,
              //       //   ),
              //       // ),
              //       leading: Container(
              //         width: 0.8 * width,
              //         child:  Text(
              //             item['message'], // item['message'],
              //             style: TextStyle(
              //               fontFamily: 'Urbanist_bold',
              //               fontSize: 13,
              //               fontWeight: FontWeight.w700,
              //               color: notifire.textcolore,
              //             ),
              //             // maxLines: 2,
              //             softWrap: true,
              //           ),
              //       ),
              //       title: 
              // SizedBox(
              //         width: 0.15 * width,
              //         child: Column(
              //           children: [
              //             Text(
              //                 day,
              //                 style: TextStyle(
              //                   fontFamily: 'Urbanist_bold',
              //                   fontSize: 10,
              //                   color: notifire.textcolore,
              //                 ),
              //                 // maxLines: 2,
              //                 softWrap: true,
              //               ),
              //               const SizedBox(height: 5,),
              //               Text(
              //                 hour,
              //                 style: TextStyle(
              //                   fontFamily: 'Urbanist_bold',
              //                   fontSize: 10,
              //                   color: notifire.textcolore,
              //                 ),
              //                 // maxLines: 2,
              //                 softWrap: true,
              //               ),
              //           ],
              //         ),
              //       ),
              //       trailing: SizedBox(width: width * 0.05, child: Text('text trailing')),
              //     ),
              //   ),
              //   Divider(
              //     color: notifire.textcolore,
              //     height: 2,
              //   ),
              //   const SizedBox(
              //     height: 10,
              //   ),
              // ],
              //     ),
            
            ),
        const SizedBox(height: 5,)
      ],
    );
    ;
  }
}