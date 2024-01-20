// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/app_session.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/account/presentation/screen/manage_chats_screen.dart';
import 'package:resultizer_merged/features/account/presentation/screen/profile_screen.dart';
import 'package:resultizer_merged/features/account/presentation/screen/user_detail_screen.dart';
import 'package:resultizer_merged/features/account/presentation/widget/normal_profile_info_widget.dart';
import 'package:resultizer_merged/features/account/presentation/widget/profile_info_widget.dart';
import 'package:resultizer_merged/features/account/presentation/widget/settings_item.dart';
import 'package:resultizer_merged/features/account/presentation/widget/tipster_profile_info_widget.dart';
import 'package:resultizer_merged/features/on_boarding/on_boarding_view.dart';
import 'package:resultizer_merged/onesignal_config.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

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

  void logout() {
    initOneSignal();
    return;
    // unsubscribe from from topics
    List following = GlobalDataSource.userData.following;
    for(var item in following) {
      unsubscribeFromTag(item);
    }
    unsubscribeFromTag(GlobalDataSource.userData.id.toString());
    
    // clear apps' global data
    GlobalDataSource.clearData();
    // clear app shared preference
    AppSession.clear();
    

    
    Get.offAll(const OnBoardingScreenView());
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    List<String> userRole = GlobalDataSource.userData.roles;
    return Scaffold(
      backgroundColor: notifire.background,
      key: scaffoldKey,
      drawer: drawer1(),
      appBar: commonappbar(
          title: 'More', context: context, scaffoldKey: scaffoldKey),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ProfileInfoWidget(),
              ],
            ),
          ),

          // SettingsItemWidget(
          //   title: 'Change password',
          //   onSwitchChanged: (switchValue) {},
          //   onOpenIconPressed: () {},
          //   switchValue: notifire.isDark,
          // ),
          Divider(
            color: notifire.textcolore,
            height: 2,
          ),
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
              logout();
            },
            switchValue: notifire.isDark,
            buttonIcon: Icons.logout,
          ),
        ],
      ),
    );
  }
}
