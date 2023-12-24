// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/account/presentation/screen/manage_chats_screen.dart';
import 'package:resultizer_merged/features/account/presentation/screen/user_detail_screen.dart';
import 'package:resultizer_merged/features/account/presentation/widget/settings_item.dart';
import 'package:resultizer_merged/features/auth/presentation/screens/sign_in_view.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/view/account_screen/about_screen.dart';
import 'package:resultizer_merged/view/account_screen/general_screen.dart';
import 'package:resultizer_merged/view/account_screen/help_screen.dart';
import 'package:resultizer_merged/view/account_screen/notification_screen.dart';
import 'package:resultizer_merged/view/account_screen/personal_screen.dart';
import 'package:resultizer_merged/view/account_screen/security_screen.dart';
import 'package:resultizer_merged/view/sign_in/sign_in_view.dart';

class AccountScreenView extends StatefulWidget {
  const AccountScreenView({super.key});

  @override
  State<AccountScreenView> createState() => _AccountScreenViewState();
}

class _AccountScreenViewState extends State<AccountScreenView> {
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
      key: GlobalDataSource.scaffoldKey,
      drawer: drawer1(),
      appBar:
          commonappbar(title: 'More', image: AppAssets.more, context: context),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(const ParsnalScreen());
            },
            child: ListTile(
              leading: Image.asset('assets/images/Ellipse.png'),
              title: Text(
                GlobalDataSource.userData.fullname ?? '...',
                style: TextStyle(
                  fontFamily: "Urbanist_bold",
                  color: notifire.textcolore,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                GlobalDataSource.userData.email ?? '...',
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
          // SettingsItemWidget(
          //   title: 'Change password',
          //   onSwitchChanged: (switchValue) {},
          //   onOpenIconPressed: () {},
          //   switchValue: notifire.isDark,
          // ),
          if (GlobalDataSource.userData.roles.contains(AppString.admin))
            Column(
              children: [
                SettingsItemWidget(
                  title: 'Manage Users',
                  onSwitchChanged: (switchValue) => {},
                  onOpenIconPressed: () {
                    Get.to(const UserDetailScreen());
                  },
                  isSwitch: false,
                  switchValue: notifire.isDark,
                ),
                SettingsItemWidget(
                  title: 'Manage Chats',
                  onSwitchChanged: (switchValue) => {},
                  onOpenIconPressed: () {
                    Get.to(const ManageChatsScreen());
                  },
                  isSwitch: false,
                  switchValue: notifire.isDark,
                ),
              ],
            ),

          SettingsItemWidget(
            title: 'Night Mode',
            onSwitchChanged: (switchValue) => notifire.isavalable(switchValue),
            onOpenIconPressed: () {},
            isSwitch: true,
            switchValue: notifire.isDark,
          ),
          SettingsItemWidget(
            title: 'Logout',
            onSwitchChanged: (switchValue) {},
            onOpenIconPressed: () {
              GlobalDataSource.clearData();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInView()),
              );
            },
            switchValue: notifire.isDark,
            buttonIcon: Icons.logout,
          ),
          // ListView.builder(
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   scrollDirection: Axis.vertical,
          //   padding: const EdgeInsets.symmetric(vertical: 15),
          //   itemCount: img.length,
          //   itemBuilder: (context, index) {
          //     print('index $index ${img.length}');
          //     return GestureDetector(
          //       onTap: () {
          //         if (index == 0) {
          //           Get.to(const ParsnalScreen());
          //         } else if (index == 1) {
          //           Get.to(const NotificationScreen());
          //         } else if (index == 2) {
          //           Get.to(const GeneralScreen());
          //         } else if (index == 3) {
          //           Get.to(const Securityscreen());
          //         } else if (index == 4) {
          //         } else if (index == 5) {
          //           Get.to(const HelpScreen());
          //         } else if (index == 6) {
          //           Get.to(const AboutScreen());
          //         }
          //         // Log out Bottom Sheet
          //         else {
          //           showModalBottomSheet(
          //             context: context,
          //             builder: (context) {
          //               return Container(
          //                 height: 271,
          //                 width: Get.width,
          //                 decoration: BoxDecoration(
          //                   borderRadius: const BorderRadius.vertical(
          //                       top: Radius.circular(28)),
          //                   color: notifire.bgcolore,
          //                 ),
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   children: [
          //                     const Text(
          //                       'Logout',
          //                       style: TextStyle(
          //                         fontFamily: "Urbanist_bold",
          //                         color: Color(0xffF75555),
          //                         fontSize: 24,
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.symmetric(horizontal: 15),
          //                       child: Divider(
          //                         height: 10,
          //                         thickness: 1,
          //                         color: notifire.borercolour,
          //                       ),
          //                     ),
          //                     Text(
          //                       'Are you sure you want to log out?',
          //                       style: TextStyle(
          //                           fontFamily: "Urbanist_bold",
          //                           fontSize: 20,
          //                           color: notifire.textcolore),
          //                     ),
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceAround,
          //                       children: [
          //                         const SizedBox(
          //                           width: 10,
          //                         ),
          //                         CommonButton(
          //                           height: 58,
          //                           width: 185,
          //                           color: AppColor.babyPinkColor,
          //                           buttonName: 'Cancel',
          //                           onTap: () => Navigator.pop(context),
          //                         ),
          //                         const Expanded(
          //                             child: SizedBox(
          //                           width: 10,
          //                         )),
          //                         CommonButton(
          //                           onTap: () {
          //                             Get.to(const SignView());
          //                           },
          //                           height: 58,
          //                           width: 185,
          //                           color: AppColor.pinkColor,
          //                           buttonName: 'Yes, Logout',
          //                           textColor: Colors.white,
          //                         ),
          //                         const SizedBox(
          //                           width: 10,
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           );
          //         }
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
