import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/format_time_ago.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_cubit.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_state.dart';
import 'package:resultizer_merged/features/videos/presentation/screens/competition_screen.dart';
import 'package:resultizer_merged/features/videos/presentation/screens/team_screen.dart';
import 'package:resultizer_merged/features/videos/presentation/widgets/feeds.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';

class HighlightsViewScreen extends StatefulWidget {
  const HighlightsViewScreen({super.key});

  @override
  State<HighlightsViewScreen> createState() => _HighlightsViewScreenState();
}

class _HighlightsViewScreenState extends State<HighlightsViewScreen> {
  ColorNotifire notifire = ColorNotifire();
  List news = [
    AppAssets.news,
    AppAssets.news1,
    AppAssets.news2,
    AppAssets.news3,
    AppAssets.news4,
    AppAssets.news,
  ];
  List title1 = [
    'Bellingham close to\nthe complete player\nafter England per',
    'Rice claims England\nare starting to\nsilence the critics',
    'Southgate hails\nEngland  young\nlions as France lie',
    'Kane hopes Senegal\nstrike sparks scoring\nrun for England',
    'Kane overtakes\nLineker as England\ntop tournament',
    'Bellingham close to\nthe complete player\nafter England per',
  ];
  List subtitle1 = [
    '1 hour ago',
    '8 hours ago',
    '15 hours ago',
    '1 day ago',
    '2 days ago',
    '4 days ago'
  ];
  List time1 = [
    '01:57',
    '02:35',
    '02:44',
    '01:35',
    '01:43',
    '02:35',
  ];
  List video = [
    '10 hours ago',
    '18 hours ago',
    '1 day ago',
    '2 days ago',
    '2 days ago',
    '3 hours ago',
  ];

  List<ScorebatVideoModel> recentFeeds = [];

  Future<List<ScorebatVideoModel>> fetchData() async {
    if (recentFeeds.isNotEmpty) return recentFeeds;
    final cubit = BlocProvider.of<ScorebatCubit>(context);
    recentFeeds = await cubit.getRecentFeeds().catchError((onError) {
      throw onError;
    });

    return recentFeeds;
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    double height = MediaQuery.of(context).size.height / 13;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ScorebatCubit, ScorebatStates>(
        builder: (context, state) => Scaffold(
              backgroundColor: notifire.bgcolore,
              drawer: const drawer1(),
              appBar: commonappbar(
                  title: 'Watch', image: AppAssets.search, context: context),
              // appBar: AppBar(
              //   actionsIconTheme:
              //       IconThemeData(color: notifire.reverseBgColore),
              //   backgroundColor: notifire.bgcolore,
              //   title: Text(
              //     "Watch",
              //     style: TextStyle(color: notifire.textcolore),
              //   ),
              // ),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Text(
                      'Filter',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Urbanist_bold',
                          color: notifire.textcolore),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'By Competition',
                      style: TextStyle(color: notifire.textcolore),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Get.to(const CompetitionHighlightsViewScreen());
                      },
                      child: Image.asset(
                        AppAssets.right,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Text(
                      'By Team',
                      style: TextStyle(
                          // fontSize: 24,
                          color: notifire.textcolore),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Get.to(const TeamHighlightsViewScreen());
                      },
                      child: Image.asset(
                        AppAssets.right,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: FutureBuilder<List>(
                        future: fetchData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 250,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            print('snapshot.error ${snapshot.error}');
                            return const Text(
                                'An error occurred, Please try again later');
                          } else {
                            final data = snapshot.data;
                            List<Widget> widgets = [];
                            for (ScorebatVideoModel item in data!) {
                              widgets.add(GestureDetector(
                                onTap: () {
                                  Get.to(
                                      FeedDetailView(scorebatVideoModel: item));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                              height: 100,
                                              width: 125,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: ImageWithDefault(
                                                  imageUrl: item.thumbnail,
                                                  height: 100,
                                                  width: 125,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: (width * 0.5),
                                            child: Text(
                                              // title1[index],
                                              item.title,
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: notifire.textcolore,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              maxLines: 1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            item.competition,
                                            style: TextStyle(
                                                fontFamily: 'Urbanist_medium',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: notifire.textcolore),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                // video[index],
                                                formatTimeAgo(item.date),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Urbanist_medium',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: notifire.textcolore),
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
                              ));
                            }
                            return Column(children: widgets);
                          }
                        },
                      ),
                      // child: Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     // ListTile(
                      //     //   leading: Text(
                      //     //     'View All',
                      //     //     style: TextStyle(
                      //     //         fontSize: 24,
                      //     //         fontWeight: FontWeight.w700,
                      //     //         fontFamily: 'Urbanist_bold',
                      //     //         color: notifire.textcolore),
                      //     //   ),
                      //     //   trailing: Image.asset(
                      //     //     AppAssets.right,
                      //     //     height: 24,
                      //     //     width: 24,
                      //     //   ),
                      //     // ),
                      //     // FutureBuilder<List>(
                      //     //   future: fetchData(),
                      //     //   builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                      //     //     if (snapshot.connectionState == ConnectionState.waiting) {
                      //     //       return const SizedBox(
                      //     //         height: 250,
                      //     //         child: Center(
                      //     //           child: CircularProgressIndicator(),
                      //     //         ),
                      //     //       );
                      //     //     }
                      //     //     else if (snapshot.hasError) {
                      //     //       print('snapshot.error ${snapshot.error}');
                      //     //       return const Text('An error occurred, Please try again later');
                      //     //     }
                      //     //     else {

                      //     //     }
                      //     //   },
                      //     // ),
                      //     ListView.builder(
                      //       scrollDirection: Axis.vertical,
                      //       shrinkWrap: true,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       padding: const EdgeInsets.symmetric(horizontal: 15),
                      //       itemCount: news.length,
                      //       itemBuilder: (context, index) {
                      //         return Padding(
                      //           padding: const EdgeInsets.only(bottom: 15),
                      //           child: Row(
                      //             children: [
                      //               Stack(
                      //                 children: [
                      //                   SizedBox(
                      //                       height: 100,
                      //                       width: 125,
                      //                       child: Image.asset(
                      //                         news[index],
                      //                         fit: BoxFit.fill,
                      //                       )),
                      //                   Positioned(
                      //                     bottom: 10,
                      //                     right: 10,
                      //                     child: Container(
                      //                       height: 24,
                      //                       width: 44,
                      //                       decoration: BoxDecoration(
                      //                         borderRadius:
                      //                             BorderRadius.circular(6),
                      //                         color: Colors.black
                      //                             .withOpacity(0.50),
                      //                       ),
                      //                       child: Center(
                      //                           child: Text(
                      //                         time1[index],
                      //                         style: const TextStyle(
                      //                             fontFamily:
                      //                                 'Urbanist_semibold',
                      //                             fontSize: 10,
                      //                             fontWeight: FontWeight.w600,
                      //                             color: Colors.white),
                      //                       )),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               const Expanded(
                      //                   child: SizedBox(
                      //                 width: 10,
                      //               )),
                      //               Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     title1[index],
                      //                     style: TextStyle(
                      //                         fontFamily: 'Urbanist_bold',
                      //                         fontWeight: FontWeight.w700,
                      //                         fontSize: 18,
                      //                         color: notifire.textcolore),
                      //                     overflow: TextOverflow.ellipsis,
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Text(
                      //                         video[index],
                      //                         style: TextStyle(
                      //                             fontFamily: 'Urbanist_medium',
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 12,
                      //                             color: notifire.textcolore),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ],
                      //               ),
                      //               const Expanded(
                      //                   child: SizedBox(
                      //                 width: 10,
                      //               )),
                      //               Icon(Icons.more_vert,
                      //                   color: notifire.textcolore),
                      //             ],
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
