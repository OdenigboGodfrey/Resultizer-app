import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/widget/profile_info_widget.dart';
import 'package:resultizer_merged/features/account/presentation/widget/profile_tips_widget/tipster_tip_item_widget.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

class ToggleFollowUserWidget extends StatefulWidget {
  ToggleFollowUserWidget({super.key, required this.uid, required this.setState, this.showTipsterTips = false});
  final String uid;
  bool showTipsterTips;
  Function setState;

  @override
  State<ToggleFollowUserWidget> createState() => Toggle_FollowStateUserWidget();
}

class Toggle_FollowStateUserWidget extends State<ToggleFollowUserWidget> {
  ColorNotifire notifire = ColorNotifire();
  late UserDetailCubit userDetailCubit;
  String uid = '';
  bool isFollowing = false;
  

  GlobalKey<ProfileInfoWidgetState> profileInfoWidgetKey = GlobalKey<ProfileInfoWidgetState>();
  String followMessageString = 'follow';

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    isFollowing = GlobalDataSource.userData.following.contains(uid);
  }

  void toggleFollowUser(BuildContext context) async {
    userDetailCubit = context.read<UserDetailCubit>();
    showSnack(context, '${followMessageString}ing user', Colors.blue);
    await userDetailCubit.toggleFollowUser(widget.uid, isFollowing).then((value) {
      if (value) {
        showSnack(context, 'User ${followMessageString}ed', Colors.green);
        try {
          setState(() {
            
            uid = widget.uid;
            isFollowing = !isFollowing;
            followMessageString = isFollowing ? 'unfollow' : 'follow';
          });
          // recreate profile info widget
          profileInfoWidgetKey = GlobalKey<ProfileInfoWidgetState>();
          // AppSession.writeGlobalUserDataToLocal();
        } catch (e, stackTrace) {
          print(stackTrace);
        }
      } else {
        showSnack(
            context, 'An error occurred while ${followMessageString}ing user', Colors.red);
      }
    }).catchError((onError) {
      print(onError);
      showSnack(context, 'An error occurred while ${followMessageString}ing user', Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return AlertDialog(
      backgroundColor: notifire.background,
      title: Text(
        'User Profile',
        style: TextStyle(
            color: notifire.textcolore,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          // height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ProfileInfoWidget(uid: uid, key: profileInfoWidgetKey),
                if (widget.showTipsterTips)
                    TipsterTipItemWidget(uid: uid, setState: widget.setState,),
                if (widget.uid != GlobalDataSource.userData.id)
                  ElevatedButton(
                    onPressed: () async {
                      toggleFollowUser(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: AppColor.pinkColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (isFollowing ? 'Unfollow' : 'Follow'),
                          style: const TextStyle(
                              fontFamily: 'Urbanist_bold',
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
