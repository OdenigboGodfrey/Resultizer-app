import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

class SocialCircleUserRowWidget extends StatefulWidget {
  String uid;
  bool disableFollowBtn = false;

  SocialCircleUserRowWidget(
      {super.key, required this.uid, this.disableFollowBtn = false});

  @override
  State<SocialCircleUserRowWidget> createState() =>
      _SocialCircleUserRowWidgetState();
}

class _SocialCircleUserRowWidgetState extends State<SocialCircleUserRowWidget> {
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  ColorNotifire notifire = ColorNotifire();

  UserModel? userData;
  bool isFollowing = true;
  late UserDetailCubit userDetailCubit;
  String followMessageString = 'unfollow';

  Future<void> getProfile() async {
    userDetailCubit = context.read<UserDetailCubit>();
    userData = await userDetailCubit.fetchUserByUid(widget.uid);
    if (userData != null) {
      userData?.followers ??= await userDetailCubit.getFollowers(userData!.id);

      userData?.following ??= await userDetailCubit.getFollowing(userData!.id);
    }

    setState(() {});
  }

  void toggleFollowUser(BuildContext context) async {
    userDetailCubit = context.read<UserDetailCubit>();
    showSnack(context, '${followMessageString}ing user', Colors.blue);
    await userDetailCubit
        .toggleFollowUser(widget.uid, isFollowing)
        .then((value) {
      if (value) {
        showSnack(context, 'User ${followMessageString}ed', Colors.green);
        try {
          setState(() {
            isFollowing = !isFollowing;
            followMessageString = isFollowing ? 'unfollow' : 'follow';
          });
        } catch (e, stackTrace) {
          print(stackTrace);
        }
      } else {
        showSnack(
            context,
            'An error occurred while ${followMessageString}ing user',
            Colors.red);
      }
    }).catchError((onError) {
      print(onError);
      showSnack(context,
          'An error occurred while ${followMessageString}ing user', Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Column(
      children: [
        ListTile(
          leading: ClipOval(
              child: ImageWithDefault(
            imageUrl: userData != null ? userData!.profileImageURL! : '',
            width: 50,
            height: 50,
          )),
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
                  Text(
                    '${userData != null && userData!.following != null ? userData!.following!.length : '0'} following',
                    style: TextStyle(
                      fontFamily: "Urbanist_medium",
                      color: notifire.textcolore,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${userData != null && userData!.followers != null ? userData!.followers!.length : '0'} followers',
                    style: TextStyle(
                      fontFamily: "Urbanist_medium",
                      color: notifire.textcolore,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
          trailing: GestureDetector(
              onTap: () {
                toggleFollowUser(context);
              },
              child: widget.disableFollowBtn
                  ? const SizedBox()
                  : Column(
                    children: [
                      const SizedBox(height: 10,),
                      Text(
                          followMessageString,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColor.purple),
                        ),
                    ],
                  )),
        ),
        Divider(
          color: notifire.textcolore,
          height: 2,
        ),
      ],
    );
  }
}
