import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/home/presentation/widget/chat/chats_view.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';

class TipsScreenView extends StatefulWidget {
  const TipsScreenView({super.key});

  @override
  State<TipsScreenView> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<TipsScreenView> {
  @override
  void initState() {
    super.initState();
  }

  ColorNotifire notifire = ColorNotifire();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
        backgroundColor: notifire.background,
        key: scaffoldKey,
        drawer: drawer1(),
        appBar: commonappbar(
            title: 'Tips', image: AppAssets.search, context: context, scaffoldKey: scaffoldKey),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            width: width,
            height: height * 0.85,
            child: ChatView()
          ),
        ));
  }
}
