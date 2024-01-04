import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/format_time_ago.dart';
import 'package:resultizer_merged/core/utils/random_array_subset.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_cubit.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class FeedDetailView extends StatefulWidget {
  final ScorebatVideoModel scorebatVideoModel;

  const FeedDetailView({super.key, required this.scorebatVideoModel});
  // final String htmlContent;
  // final String title;
  // final String time;
  // final String competition;
  // final String video;

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
    final cubit = BlocProvider.of<ScorebatCubit>(context);
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var highlightSuggestions = getRandomSubset(cubit.recentFeeds, 6);
    for (int i = 0; i < highlightSuggestions.length; i++) {
      var item = highlightSuggestions[i];
      if (item.videos[0].id == widget.scorebatVideoModel.videos[0].id) {
        highlightSuggestions.remove(item);
      }
    } // 'background="${notifire.bgcolore.toHex()}"'

    // print(widget.scorebatVideoModel.toJson());

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
                        // InAppWebViewInitialData(data: '''<body bgcolor="red">${widget.scorebatVideoModel.videos[0].embed}</body>'''),
                        InAppWebViewInitialData(
                            data:
                                '''<body bgcolor="${(notifire.isDark ? 'black' : 'white')}" >${widget.scorebatVideoModel.videos[0].embed}</body>'''),
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
                      SizedBox(
                        width: width * 0.85,
                        child: Text(
                          widget.scorebatVideoModel.title,
                          style: TextStyle(
                            fontFamily: 'Urbanist_bold',
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                            color: notifire.textcolore,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.keyboard_arrow_down_outlined,
                          color: notifire.textcolore),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.scorebatVideoModel.competition,
                      style: TextStyle(
                          fontFamily: 'Urbanist_medium',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: notifire.textcolore),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      // widget.scorebatVideoModel.time,
                      formatTimeAgo(widget.scorebatVideoModel.date),
                      style: TextStyle(
                          fontFamily: 'Urbanist_medium',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: notifire.textcolore),
                    ),
                  ),

                  // Highlights
                  ListTile(
                    leading: Text(
                      'Highlights',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Urbanist_bold',
                          color: notifire.textcolore),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: highlightSuggestions.length < 5
                        ? highlightSuggestions.length
                        : 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(FeedDetailView(
                              scorebatVideoModel: highlightSuggestions[index]));
                        },
                        child: Container(
                          color: notifire.bgcolore,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                        height: 100,
                                        width: 125,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: ImageWithDefault(
                                            imageUrl: highlightSuggestions[index].thumbnail,
                                            height: 100,
                                            width: 125,
                                          ),
                                        )),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Container(
                                        height: 24,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.black.withOpacity(0.50),
                                        ),
                                        child: Center(
                                            child: Text(
                                          formatTimeAgo(
                                              highlightSuggestions[index].date),
                                          style: const TextStyle(
                                              fontFamily: 'Urbanist_semibold',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                const Expanded(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width * 0.5,
                                      child: Text(
                                        highlightSuggestions[index].title,
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: notifire.textcolore),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.5,
                                          child: Text(
                                            highlightSuggestions[index]
                                                .competition,
                                            style: TextStyle(
                                                fontFamily: 'Urbanist_medium',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: notifire.textcolore,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Expanded(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                Icon(Icons.more_vert,
                                    color: notifire.textcolore),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ]))),
          ]),
    );
  }
}
