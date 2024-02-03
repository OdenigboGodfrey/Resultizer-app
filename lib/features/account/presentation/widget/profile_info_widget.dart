import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/screen/profile_screen.dart';
import 'package:resultizer_merged/features/account/presentation/widget/normal_profile_info_widget.dart';
import 'package:resultizer_merged/features/account/presentation/widget/tipster_profile_info_widget.dart';
import 'package:resultizer_merged/features/account/presentation/widget/profile_tips_widget/tipster_tip_item_widget.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class ProfileInfoWidget extends StatefulWidget {
  ProfileInfoWidget({super.key, this.uid, this.showTipsterTips = false});
  String? uid;
  bool showTipsterTips;

  @override
  State<ProfileInfoWidget> createState() => ProfileInfoWidgetState();
}

class ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  ColorNotifire notifire = ColorNotifire();
  User? userData;
  late UserDetailCubit userDetailCubit;
  List<dynamic> followersUids = [];
  List<dynamic> followingUids = [];

  Future<void> getProfile() async {
    userDetailCubit = context.read<UserDetailCubit>();
    if (widget.uid != null) {
      userData = await userDetailCubit.fetchUserByUid(widget.uid!);
      if (userData != null) {
        
        if (userData?.followers == null) {
          followersUids = await userDetailCubit.getFollowers(userData!.id);
        } else {
          followersUids = userData!.followers!;
        }
        
        if (userData?.following == null) {
          followingUids  = await userDetailCubit.getFollowing(userData!.id);
        } else {
          followingUids  = userData!.following!;
        }
      }
      
    } else {
      userData = GlobalDataSource.userData;
      followersUids = userData!.followers!;
      followingUids  = userData!.following!;
    }
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    userDetailCubit = context.read<UserDetailCubit>();
    return GestureDetector(
        onTap: () {
          if (userData!.id != AppString.guestUid) Get.to(const ProfileScreen());
        },
        child: Column(
          children: [
            if (userData == null)
              const CircularProgressIndicator(),
            if (userData != null)
              userData != null && userData!.roles!.contains(AppString.tipster)
                  ? Column(
                    children: [
                      TipsterProfileInfo(
                          followersCount: followersUids.length.toString(),
                          followingCount: followingUids.length.toString(),
                          uid: widget.uid,
                          followersUids: followersUids,
                          followingUids: followingUids,
                          userData: userData,
                        ),
                        // if (!widget.showTipsterTips)
                        //   TipsterTipItemWidget(uid: userData!.id),
                    ],
                  )
                  : NormalProfileInfoWidget(
                    followingCount: followingUids.length.toString(),
                      followersCount: followersUids.length.toString(),
                      uid: widget.uid,
                      followersUids: followersUids,
                      followingUids: followingUids,
                      userData: userData,
                    ),
          ],
        ));
  }
}
