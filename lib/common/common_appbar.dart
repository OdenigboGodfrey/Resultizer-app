// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/account/presentation/screen/account_screen.dart';
import 'package:resultizer_merged/features/account/presentation/screen/user_detail_screen.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/utils/model/drawer_model.dart';
import 'package:resultizer_merged/view/search_screen/search_screen.dart';

List<DrawerModel> drawerListItems = [];
void buildDrawerListItems() {
  drawerListItems = [
    DrawerModel(
      image: AppAssets.frame,
      name: 'Football',
    ),
  ];
  drawerListItems.add(DrawerModel(
      image: AppAssets.fillPerson,
      name: 'Account',
      action: () {
        Get.to(const AccountScreenView());
      }));
}

// last item in drawerListItems

int selectIndex = 0;
late GlobalKey<ScaffoldState> key;

ColorNotifire notifire = ColorNotifire();

PreferredSizeWidget commonappbar(
    {required String title,
    required String image,
    IconData? icon,
    context,
    Function? onTrailWidgetClick,
    Widget? trailWidget}) {
  notifire = Provider.of<ColorNotifire>(context, listen: true);
  key = GlobalDataSource.scaffoldKey;
  return AppBar(
    backgroundColor: notifire.background,
    leading: GestureDetector(
        onTap: () {
          print('opening drawer ${key.currentState}');
          if (key.currentState != null) {
            // Access the state
            key.currentState!.openDrawer();
          }
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
          child: onTrailWidgetClick != null
              ? trailWidget
              : Image.asset(
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
  drawer1({super.key}) {
    buildDrawerListItems();
  }

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
                    itemCount: drawerListItems.length,
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
                            if (drawerListItems[index].action != null) {
                              drawerListItems[index].action!();
                            }
                            // Navigator.pop(context);
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                drawerListItems[index].image.toString(),
                                height: 28,
                                color: selectIndex == index
                                    ? AppColor.pinkColor
                                    : notifire.textcolore,
                              ),
                            ),
                            Text(
                              drawerListItems[index].name.toString(),
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
