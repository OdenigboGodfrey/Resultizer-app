// import 'package:azul_football/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:readmore/readmore.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/get_initials.dart';

class InputCommentUser extends StatelessWidget {
  final control;
  final userImage;
  final onTap;
  final String? kUser01 =
      "https://avatars.githubusercontent.com/u/77888926?v=4";

  InputCommentUser({this.control, this.userImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 25.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.hintColor.withOpacity(0.2),
            blurRadius: 10.0,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 25.0,
            backgroundColor: theme.primaryColor,
            // child: CircleAvatar(
            //   maxRadius: 24.0,
            //   backgroundImage: NetworkImage(kUser01!),
            // ),
            child: Text(getInitials(GlobalDataSource.userData.fullname)),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                controller: control,
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
              color: theme.primaryColor,
              child: Icon(
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
  //final image;
  final String name;
  final String message;
  final DateTime dateTime;

  CardChat({
    //required this.image,
    required this.name,
    required this.message,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: CircleAvatar(
              maxRadius: 20.0,
              // backgroundImage: NetworkImage(image),
              child: Text(getInitials(name)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                ReadMoreText(
                  message,
                  trimLines: 2,
                  colorClickableText: theme.primaryColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' More',
                  trimExpandedText: ' Less',
                  style: theme.textTheme.bodyText2,
                  moreStyle: TextStyle(
                    fontSize: 12,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat('MMM').format(dateTime)} ${DateFormat('dd').format(dateTime)}',
                  style: TextStyle(color: theme.primaryColor, fontSize: 10),
                ),
                Text(
                  '${DateFormat('HH').format(dateTime)}:${DateFormat('mm').format(dateTime)}',
                  style: TextStyle(color: theme.primaryColor, fontSize: 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
