import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class FeedDetailView extends StatefulWidget {
  const FeedDetailView(
      {super.key,
      required this.title,
      this.htmlContent =
          '''<div style='width:100%;height:0px;position:relative;padding-bottom:56.250%;background:#000;'><iframe src='https:\/\/www.scorebat.com\/embed\/v\/VVlNYnhHdVpiZ0NBaHVWNGlRbXZtUT09\/?token=MTIxOTE0XzE2OTcwODU4OTNfYTE4MjMzNmRiMjJkYzdjMDA0NTdmMjRmMTc5M2Y4NzBlNmZiMWQwMg==&utm_source=api&utm_medium=video&utm_campaign=apifd' frameborder='0' width='100%' height='100%' allowfullscreen allow='autoplay; fullscreen' style='width:100%;height:100%;position:absolute;left:0px;top:0px;overflow:hidden;'><\/iframe><\/div>'''});

  final String htmlContent;
  final String title;

  @override
  State<FeedDetailView> createState() => _FeedDetailViewState();
}

class _FeedDetailViewState extends State<FeedDetailView> {
  late InAppWebViewController webView;
  ColorNotifire notifire = ColorNotifire();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: width,
                  height: height * 0.25,
                  child: InAppWebView(
                    initialData:
                        InAppWebViewInitialData(data: widget.htmlContent),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 25,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(0.50),
                    ),
                    child: Center(
                      child: GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontFamily: 'Urbanist_bold',
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                            color: notifire.textcolore),
                      ),
                      const Spacer(),
                      Icon(Icons.keyboard_arrow_down_outlined,
                          color: notifire.textcolore),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ]))),
          ]),
    );
  }
}
