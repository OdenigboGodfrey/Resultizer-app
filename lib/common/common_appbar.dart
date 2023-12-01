// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/features/account/presentation/screen/account_screen.dart';
import 'package:resultizer_merged/view/search_screen/search_screen.dart';

import '../theme/themenotifer.dart';
import '../utils/constant/app_assets.dart';
import '../utils/constant/app_color.dart';
import '../utils/model/drawer_model.dart';

List<DrawerModel> imagelist = [
  DrawerModel(
    image: AppAssets.frame,
    name: 'Football',
  ),
  DrawerModel(
    image: AppAssets.fillPerson,
    name: 'Account',
    action: () {
      Get.to(const AccountScreenView());
    }
  ),
  // DrawerModel(
  //   image: AppAssets.frame1,
  //   name: 'Tennis',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame2,
  //   name: 'Basketball',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame3,
  //   name: 'Hockey',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame4,
  //   name: 'Volleyball',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame5,
  //   name: 'Handball',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame6,
  //   name: 'Esports',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame7,
  //   name: 'Baseball',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame8,
  //   name: 'Cricket',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame9,
  //   name: 'Motorsport',
  // ),
  // DrawerModel(
  //   image: AppAssets.frame10,
  //   name: 'Rugby',
  // ),
];

int selectIndex = 0;
final GlobalKey<ScaffoldState> key = GlobalKey();

ColorNotifire notifire = ColorNotifire();

PreferredSizeWidget commonappbar(
    {required String title, required String image, IconData? icon, context, Function? onTrailWidgetClick, Widget? trailWidget}) {
  notifire = Provider.of<ColorNotifire>(context, listen: true);
  return AppBar(
    backgroundColor: notifire.background,
    leading: GestureDetector(
        onTap: () {
          key.currentState!.openDrawer();
        },
        child: Icon(
          Icons.menu,
          color: notifire.textcolore,
        )),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: "Urbanist_bold",
        color: notifire.textcolore,
        fontSize: 20,
      ),
    ),
    actions: [
      Icon(
        icon,
        size: 28,
      ),
      GestureDetector(
          onTap: () {
            if (onTrailWidgetClick != null) {
              onTrailWidgetClick();
            } else {
              Get.to(const SearchScreen());
            }
          },
          child: onTrailWidgetClick != null ? trailWidget : Image.asset(
            image,
            height: 28,
            width: 28,
            color: notifire.textcolore,
          )),
      const SizedBox(
        width: 15,
      ),
    ],
  );
}

class drawer1 extends StatefulWidget {
  const drawer1({super.key});

  @override
  State<drawer1> createState() => _drawer1State();
}

class _drawer1State extends State<drawer1> {
  @override
  Widget build(BuildContext context) {
    int selectIndex = 0;
    return StatefulBuilder(builder: (context, setState) {
      return Drawer(
        width: 250,
        backgroundColor: notifire.bgcolore,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "resultizer",
                  style: TextStyle(
                    fontFamily: "Urbanist_bold",
                    color: notifire.textcolore,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 600,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imagelist.length,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectIndex = index;
                            if (imagelist[index].action != null) {
                              imagelist[index].action!();
                            }
                            // Navigator.pop(context);
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                imagelist[index].image.toString(),
                                height: 28,
                                color: selectIndex == index
                                    ? AppColor.pinkColor
                                    : notifire.textcolore,
                              ),
                            ),
                            Text(
                              imagelist[index].name.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Urbanist_bold",
                                  color: selectIndex == index
                                      ? AppColor.pinkColor
                                      : notifire.textcolore),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
