import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../theme/themenotifer.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
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
    '75K views • 10 hours ago',
    '103K views • 18 hours ago',
    '98K views • 1 day ago',
    '146K views • 2 days ago',
    '137K views • 2 days ago',
    '90K views • 3 hours ago',
  ];
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'YYoFNcOKib0',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller.addListener(() {});
                },
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
                        'Bellingham close to the\ncomplete player England per',
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      '125K views • 1 day ago',
                      style: TextStyle(
                          fontFamily: 'Urbanist_medium',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: notifire.textcolore),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '#football #worldcup2022 #portugal #switzerland',
                      style: TextStyle(
                          fontFamily: 'Urbanist_medium',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColor.pinkColor),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Comments 14.7K',
                      style: TextStyle(
                          fontFamily: 'Urbanist_semibold',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: notifire.textcolore),
                    ),
                    trailing: Image.asset(AppAssets.swap,
                        height: 20, width: 20, color: notifire.textcolore),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/Ellipse.png',
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          height: 56,
                          width: 300,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              labelText: 'Add a comment...',
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist_regular',
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.greyscale),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // highlights
                  ListTile(
                    leading: Text(
                      'Highlights',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Urbanist_bold',
                          color: notifire.textcolore),
                    ),
                    trailing: Image.asset(
                      AppAssets.right,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                    height: 100,
                                    width: 125,
                                    child: Image.asset(
                                      news[index],
                                      fit: BoxFit.fill,
                                    )),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                    height: 24,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.black.withOpacity(0.50),
                                    ),
                                    child: Center(
                                        child: Text(
                                      time1[index],
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
                                Text(
                                  title1[index],
                                  style: TextStyle(
                                      fontFamily: 'Urbanist_bold',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: notifire.textcolore),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      video[index],
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_medium',
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
                            Icon(Icons.more_vert, color: notifire.textcolore),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
