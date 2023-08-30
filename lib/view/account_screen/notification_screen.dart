import 'package:flutter/material.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:provider/provider.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/app_string.dart';
import '../../utils/model/set_notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ColorNotifire notifire = ColorNotifire();
  bool light = true;
  List text = [
    'Match Alerts',
    'Featured News',
    'Featured Video',
    'Streaming',
    'Promotions',
    'App Updates',
  ];
  List<SetNotificationModel> setNotificationList = [
    SetNotificationModel(
      image: AppAssets.follow1,
      title: "Burnley",
      subTitle: "Burnley",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow2,
      title: "Manchester City",
      subTitle: "Manchester City",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow3,
      title: "Brighton",
      subTitle: "Brighton",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow4,
      title: "Manchester City",
      subTitle: "Manchester City",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow2,
      title: "fulham",
      subTitle: "fulham",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow4,
      title: "fulham",
      subTitle: "fulham",
      isFirstDone: false,
      isSecondDone: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      appBar: AppBar(
        backgroundColor: notifire.bgcolore,
         leading: GestureDetector(
             onTap: () => Navigator.pop(context),
             child: Icon(Icons.arrow_back_sharp, color: notifire.textcolore,)),
         title: const Text("Notification"),
         titleTextStyle: TextStyle(fontFamily: "Urbanist_bold", color: notifire.textcolore, fontSize: 20,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: text.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(text[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Urbanist_semibold', color: notifire.textcolore),),
                  trailing: GFToggle(
                    onChanged: (value) {},
                    value: false,
                    enabledThumbColor: Colors.white,
                    enabledTrackColor: AppColor.pinkColor,
                    type: GFToggleType.ios,
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15,),
                decoration: BoxDecoration(
                  color: notifire.insidecolor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: notifire.borercolour, width: 1)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Teams',style: TextStyle(fontFamily: "Urbanist_bold", fontSize: 18, fontWeight: FontWeight.w700, color: notifire.textcolore), overflow: TextOverflow.ellipsis,),
                        const Spacer(),
                        Text(AppString.match, style: TextStyle(fontFamily: "Urbanist_bold", fontSize: 18, fontWeight: FontWeight.w700, color: notifire.textcolore), overflow: TextOverflow.ellipsis,),
                        const SizedBox(width: 10,),
                        Text(AppString.news, style: TextStyle(fontFamily: "Urbanist_bold", fontSize: 18, fontWeight: FontWeight.w700, color: notifire.textcolore), overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    ListView.separated(
                      itemCount: setNotificationList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = setNotificationList[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(data.image.toString(), height: 30, width: 30,),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.title.toString(), style: TextStyle(fontSize: 14, fontFamily: "Urbanist_bold", fontWeight: FontWeight.w700, color: notifire.textcolore), overflow: TextOverflow.ellipsis,),
                                    Text(data.title.toString(), style: TextStyle(fontSize: 12, fontFamily: "Urbanist_medium", fontWeight: FontWeight.w500, color: notifire.textcolore), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    data.isFirstDone = !data.isFirstDone!;
                                    debugPrint("isFirstDone == ${data.isFirstDone}!");
                                  });
                                },
                                child: data.isFirstDone! ? Image.asset(AppAssets.fillNotification, height: 18,) : Image.asset(AppAssets.blankNotification, height: 18, color: notifire.textcolore),
                              ),
                              const SizedBox(width: 40,),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    data.isSecondDone = !data.isSecondDone!;
                                    debugPrint("isSecondDone == ${data.isSecondDone}");
                                  });
                                },
                                child: data.isSecondDone! ? Image.asset(AppAssets.fillNotification, height: 18,) : Image.asset(AppAssets.blankNotification, height: 18, color: notifire.textcolore),
                              ),
                              const SizedBox(width: 15,),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(height: 20, color: notifire.borercolour,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
