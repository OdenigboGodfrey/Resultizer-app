import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/screen/profile_screen.dart';
import 'package:resultizer_merged/features/account/presentation/widget/manage_social_circle/manage_social_circle_view.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class NormalProfileInfoWidget extends StatefulWidget {
  NormalProfileInfoWidget(
      {super.key,
      this.uid,
      this.followingCount = '-',
      this.followersCount = '-',
      this.followersUids,
      this.followingUids,
      this.userData});
  String? uid;
  User? userData;
  List<dynamic>? followersUids = [];
  List<dynamic>? followingUids = [];
  String? followingCount = '-';
  String? followersCount = '-';

  @override
  State<NormalProfileInfoWidget> createState() =>
      _NormalProfileInfoWidgetState();
}

class _NormalProfileInfoWidgetState extends State<NormalProfileInfoWidget> {
  @override
  void initState() {
    super.initState();

    userData = widget.userData;
    followingCount =
        widget.followingCount != null ? widget.followingCount! : '-';
    uids = widget.followersUids != null ? widget.followersUids! : [];
  }

  ColorNotifire notifire = ColorNotifire();
  late UserDetailCubit userDetailCubit;

  User? userData;
  List<dynamic> uids = [];
  String followingCount = '-';

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    userDetailCubit = context.read<UserDetailCubit>();
    return ListTile(
      // leading: Image.asset('assets/images/Ellipse.png'),
      leading: ClipOval(child: ImageWithDefault(imageUrl: userData != null ? userData!.profileImageURL! : '', width: 50, height: 50,)),
      title: Text(
        userData != null ? userData!.fullname! : '...',
        style: TextStyle(
          fontFamily: "Urbanist_bold",
          color: notifire.textcolore,
          fontSize: 20,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 3,
          ),
          Text(
            userData != null ? '@${userData!.username}' : '...',
            style: TextStyle(
              fontFamily: "Urbanist_medium",
              color: notifire.textcolore,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.followingUids != null && widget.followingUids!.isNotEmpty) {
                    Get.to(ManageSocialCircleScreenView(userIds: widget.followingUids!, title: 'Following', disableFollowBtn: false,));
                  }
                },
                child: Text(
                  '${widget.followingCount != null ? widget.followingCount! : '0'} following',
                  style: TextStyle(
                    fontFamily: "Urbanist_medium",
                    color: notifire.textcolore,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.followersUids!= null && widget.followersUids!.isNotEmpty) {
                    Get.to(ManageSocialCircleScreenView(userIds: widget.followersUids!, title: 'Followers', disableFollowBtn: true,));
                  }
                },
                child: Text(
                  '${widget.followersCount != null ? widget.followersCount! : '0'} followers',
                  style: TextStyle(
                    fontFamily: "Urbanist_medium",
                    color: notifire.textcolore,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          if (userData!.id != AppString.guestUid) Get.to(const ProfileScreen());
        },
        child: Image.asset(
          AppAssets.edit,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
