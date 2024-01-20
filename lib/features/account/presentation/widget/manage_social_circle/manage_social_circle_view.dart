// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/account/presentation/widget/manage_social_circle/social_circle_user_row.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class ManageSocialCircleScreenView extends StatefulWidget {
  const ManageSocialCircleScreenView(
      {super.key,
      required this.userIds,
      required this.title,
      required this.disableFollowBtn});
  final List<dynamic> userIds;
  final String title;
  final bool disableFollowBtn;

  @override
  State<ManageSocialCircleScreenView> createState() =>
      _ManageSocialCircleScreenViewState();
}

class _ManageSocialCircleScreenViewState
    extends State<ManageSocialCircleScreenView> {
  int selectIndex = 0;
  ColorNotifire notifire = ColorNotifire();
  int net = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    List<String> userRole = GlobalDataSource.userData.roles;
    return Scaffold(
      backgroundColor: notifire.background,
      key: scaffoldKey,
      drawer: drawer1(),
      appBar: AppBar(
        backgroundColor: notifire.bgcolore,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_sharp,
              color: notifire.textcolore,
            )),
        title: Text(widget.title),
        titleTextStyle: TextStyle(
          fontFamily: "Urbanist_bold",
          color: notifire.textcolore,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          if (widget.userIds.isEmpty) const Text('No Users to load'),
          if (widget.userIds.isNotEmpty)
            for (var userId in widget.userIds)
              SocialCircleUserRowWidget(
                  uid: userId, disableFollowBtn: widget.disableFollowBtn),
        ],
      ),
    );
  }
}
