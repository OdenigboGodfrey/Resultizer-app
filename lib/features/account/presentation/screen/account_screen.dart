// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/app_session.dart';
import 'package:resultizer_merged/features/account/presentation/screen/manage_chats_screen.dart';
import 'package:resultizer_merged/features/account/presentation/screen/user_detail_screen.dart';
import 'package:resultizer_merged/features/account/presentation/widget/settings_item.dart';
import 'package:resultizer_merged/features/on_boarding/on_boarding_view.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/view/account_screen/personal_screen.dart';

class AccountScreenView extends StatefulWidget {
  const AccountScreenView({super.key});

  @override
  State<AccountScreenView> createState() => _AccountScreenViewState();
}

class _AccountScreenViewState extends State<AccountScreenView> {
  int selectIndex = 0;
  ColorNotifire notifire = ColorNotifire();
  
  // List text = [
  //   'Personal Info',
  //   'Notification',
  //   'General',
  //   'Security',
  //   'Dark Mode',
  //   'Help Center',
  //   'About Resultizer',
  //   'Logout',
  // ];
  int net = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      key: scaffoldKey,
      drawer: drawer1(),
      appBar:
          commonappbar(title: 'More', image: AppAssets.more, context: context, scaffoldKey: scaffoldKey),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (GlobalDataSource.userData.id != '0') Get.to(const ParsnalScreen());
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
              // trailing: Image.asset(
              //   AppAssets.edit,
              //   height: 24,
              //   width: 24,
              // ),
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
              AppSession.clear();
              Get.offAll(const OnBoardingScreenView());
              // Get.of
            },
            switchValue: notifire.isDark,
            buttonIcon: Icons.logout,
          ),
        ],
      ),
    );
  }
}
