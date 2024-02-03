// import 'package:azul_football/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:readmore/readmore.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/get_initials.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/widget/profile_info_widget.dart';
import 'package:resultizer_merged/features/account/presentation/widget/follow_user_widget.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

class InputCommentUser extends StatelessWidget {
  final control;
  final userImage;
  final onTap;
  final String? kUser01 =
      "";

  InputCommentUser({this.control, this.userImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 25.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.pinkColor,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 10.0,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 25.0,
            backgroundColor: AppColor.blackColor,
            // child: CircleAvatar(
            //   maxRadius: 24.0,
            //   backgroundImage: NetworkImage(kUser01!),
            // ),
            // child: ClipOval(
            //         child: ImageWithDefault(
            //             imageUrl:
            //                 kUser01!,
            //             width: 50,
            //             height: 50)),
            child: Text(getInitials(GlobalDataSource.userData.fullname), style: const TextStyle(color: Colors.white),),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                controller: control,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Add a Comment',
                  border: InputBorder.none,
                  hintStyle: theme.textTheme.headline3!.copyWith(
                    color: theme.hintColor.withOpacity(0.3),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 45.0,
            width: 45.0,
            child: MaterialButton(
              onPressed: onTap,
              color: AppColor.blackColor,
              child: const Icon(
                Icons.send_outlined,
                size: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardChat extends StatelessWidget {
  String? image;
  final String name;
  final String message;
  final DateTime dateTime;
  final int fixtureId;
  final String uid;
  ColorNotifire notifire = ColorNotifire();

  CardChat({
    this.image,
    required this.name,
    required this.message,
    required this.dateTime, 
    required this.fixtureId, 
    required this.uid,
  });

  void loadUserProfile(BuildContext context, String uid ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ToggleFollowUserWidget(uid: uid, showTipsterTips: true, setState: () {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                loadUserProfile(context, uid);
              },
              child: CircleAvatar(
                maxRadius: 20.0,
                backgroundColor: AppColor.pinkColor,
                // backgroundImage: NetworkImage(image),
                child: Text(getInitials(name), style: const TextStyle(color: AppColor.offWhite, fontSize: 14),),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 10,
            child: GestureDetector(
              onTap: () {
                loadUserProfile(context, uid);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: AppColor.pinkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: notifire.textcolore),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat('MMM').format(dateTime)} ${DateFormat('dd').format(dateTime)}',
                  style: const TextStyle(color: AppColor.pinkColor, fontSize: 10),
                ),
                Text(
                  '${DateFormat('HH').format(dateTime)}:${DateFormat('mm').format(dateTime)}',
                  style: const TextStyle(color: AppColor.pinkColor, fontSize: 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
