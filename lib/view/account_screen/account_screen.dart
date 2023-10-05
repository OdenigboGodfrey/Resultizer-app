// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/view/account_screen/about_screen.dart';
import 'package:resultizer_merged/view/account_screen/general_screen.dart';
import 'package:resultizer_merged/view/account_screen/help_screen.dart';
import 'package:resultizer_merged/view/account_screen/notification_screen.dart';
import 'package:resultizer_merged/view/account_screen/personal_screen.dart';
import 'package:resultizer_merged/view/account_screen/security_screen.dart';
import 'package:resultizer_merged/view/sign_in/sign_in_view.dart';

import '../../common/common_appbar.dart';
import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import '../../utils/constant/app_color.dart';

class Account_screen extends StatefulWidget {
  const Account_screen({super.key});

  @override
  State<Account_screen> createState() => _Account_screenState();
}

class _Account_screenState extends State<Account_screen> {
  int selectIndex = 0;
  ColorNotifire notifire = ColorNotifire();
  List img = [
    AppAssets.parsonal,
    AppAssets.notification,
    AppAssets.gernal,
    AppAssets.secuity,
    AppAssets.dark,
    AppAssets.help,
    AppAssets.about,
    AppAssets.logout,
  ];
  List text = [
    'Personal Info',
    'Notification',
    'General',
    'Security',
    'Dark Mode',
    'Help Center',
    'About Resultizer',
    'Logout',
  ];
  int net = 0;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      key: key,
      drawer: const drawer1(),
      appBar: commonappbar(
          title: 'Account', image: AppAssets.more, context: context),
      body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(const ParsnalScreen());
              },
              child: ListTile(
                leading: Image.asset('assets/images/Ellipse.png'),
                title: Text(
                  'Alon musk',
                  style: TextStyle(
                    fontFamily: "Urbanist_bold",
                    color: notifire.textcolore,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  'alonmusk@yourdomain.com',
                  style: TextStyle(
                    fontFamily: "Urbanist_medium",
                    color: notifire.textcolore,
                    fontSize: 14,
                  ),
                ),
                trailing: Image.asset(
                  AppAssets.edit,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
             Expanded(
          child: 
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemCount: img.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Get.to(const ParsnalScreen());
                    } else if (index == 1) {
                      Get.to(const NotificationScreen());
                    } else if (index == 2) {
                      Get.to(const GeneralScreen());
                    } else if (index == 3) {
                      Get.to(const Securityscreen());
                    } else if (index == 4) {
                    } else if (index == 5) {
                      Get.to(const HelpScreen());
                    } else if (index == 6) {
                      Get.to(const AboutScreen());
                    }
                    // Log out Bottom Sheet
                    else {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 271,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(28)),
                              color: notifire.bgcolore,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontFamily: "Urbanist_bold",
                                    color: Color(0xffF75555),
                                    fontSize: 24,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Divider(
                                    height: 10,
                                    thickness: 1,
                                    color: notifire.borercolour,
                                  ),
                                ),
                                Text(
                                  'Are you sure you want to log out?',
                                  style: TextStyle(
                                      fontFamily: "Urbanist_bold",
                                      fontSize: 20,
                                      color: notifire.textcolore),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CommonButton(
                                      height: 58,
                                      width: 185,
                                      color: AppColor.babyPinkColor,
                                      buttonName: 'Cancel',
                                      onTap: () => Navigator.pop(context),
                                    ),
                                    const Expanded(
                                        child: SizedBox(
                                      width: 10,
                                    )),
                                    CommonButton(
                                      onTap: () {
                                        Get.to(const SignView());
                                      },
                                      height: 58,
                                      width: 185,
                                      color: AppColor.pinkColor,
                                      buttonName: 'Yes, Logout',
                                      textColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
          ],
        ),
    );
  }
}
