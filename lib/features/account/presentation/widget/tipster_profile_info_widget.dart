import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/screen/profile_screen.dart';
import 'package:resultizer_merged/features/account/presentation/widget/manage_social_circle/manage_social_circle_view.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class TipsterProfileInfo extends StatefulWidget {
  TipsterProfileInfo(
      {super.key,
      this.uid,
      this.followersCount = '-',
      this.followingCount = '-',
      this.followersUids,
      this.followingUids,
      this.userData});
  String? uid;
  String? followersCount;
  String? followingCount;
  List<dynamic>? followersUids;
  List<dynamic>? followingUids;
  User? userData;

  @override
  State<TipsterProfileInfo> createState() => _TipsterProfileInfoState();
}

class _TipsterProfileInfoState extends State<TipsterProfileInfo> {
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  ColorNotifire notifire = ColorNotifire();

  User? userData;
  late UserDetailCubit userDetailCubit;
  List<dynamic> uids = [];

  void getProfile() {
    uids = widget.followersUids != null ? widget.followersUids! : [];
    userData = widget.userData;
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ManageSocialCircleScreenView(
                        userIds: widget.followersUids!,
                        title: 'Followers',
                        disableFollowBtn: true,
                      ));
                    },
                    child: Column(
                      children: [
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontFamily: "Urbanist_bold",
                            color: notifire.textcolore,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.followersCount != null
                              ? widget.followersCount!
                              : '-',
                          style: TextStyle(
                            fontFamily: "Urbanist_bold",
                            color: notifire.textcolore,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    'Success Rate',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Urbanist_bold",
                      color: notifire.textcolore,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '-',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Urbanist_bold",
                      color: notifire.textcolore,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (userData != null && userData!.id != AppString.guestUid)
                Get.to(const ProfileScreen());
            },
            child: Column(
              children: [
                Text(
                  '${userData != null ? userData!.fullname : '-'}',
                  style: TextStyle(
                    fontFamily: "Urbanist_bold",
                    color: notifire.textcolore,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userData != null ? '@${userData!.username}' : '-',
                  style: TextStyle(
                    fontFamily: "Urbanist_bold",
                    color: notifire.textcolore,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipOval(
                    child: ImageWithDefault(
                        imageUrl: userData != null &&
                                userData!.profileImageURL != null
                            ? userData!.profileImageURL!
                            : '',
                        width: 120,
                        height: 120)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'ROI',
                  style: TextStyle(
                    fontFamily: "Urbanist_bold",
                    color: notifire.textcolore,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: "Urbanist_bold",
                    color: notifire.textcolore,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(ManageSocialCircleScreenView(
                            userIds: widget.followingUids!,
                            title: 'Following',
                            disableFollowBtn: false,
                          ));
                        },
                        child: Column(
                          children: [
                            Text(
                              'Following',
                              style: TextStyle(
                                fontFamily: "Urbanist_bold",
                                color: notifire.textcolore,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.followingCount != null
                                  ? widget.followingCount!
                                  : '-',
                              style: TextStyle(
                                fontFamily: "Urbanist_bold",
                                color: notifire.textcolore,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Units Won',
                    style: TextStyle(
                      fontFamily: "Urbanist_bold",
                      color: notifire.textcolore,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '-',
                    style: TextStyle(
                      fontFamily: "Urbanist_bold",
                      color: notifire.textcolore,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
