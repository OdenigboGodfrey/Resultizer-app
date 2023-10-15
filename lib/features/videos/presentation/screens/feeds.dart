import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class FeedsView extends StatefulWidget {
  const FeedsView(
      {super.key,
      this.htmlContent =
          '''<div style='width:100%;height:0px;position:relative;padding-bottom:56.250%;background:#000;'><iframe src='https:\/\/www.scorebat.com\/embed\/v\/VVlNYnhHdVpiZ0NBaHVWNGlRbXZtUT09\/?token=MTIxOTE0XzE2OTcwODU4OTNfYTE4MjMzNmRiMjJkYzdjMDA0NTdmMjRmMTc5M2Y4NzBlNmZiMWQwMg==&utm_source=api&utm_medium=video&utm_campaign=apifd' frameborder='0' width='100%' height='100%' allowfullscreen allow='autoplay; fullscreen' style='width:100%;height:100%;position:absolute;left:0px;top:0px;overflow:hidden;'><\/iframe><\/div>'''});

  final String htmlContent;

  @override
  State<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  late InAppWebViewController webView;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(children: <Widget>[
          Expanded(
              child: InAppWebView(
            initialData: InAppWebViewInitialData(data: widget.htmlContent),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
          ))
        ]),
      );
  }
}
