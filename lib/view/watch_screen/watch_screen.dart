import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/view/watch_screen/video_screen.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import '../../utils/constant/app_color.dart';
import '../search_screen/search_screen.dart';

enum SampleItem { itemOne, itemTwo, itemThree, itemFour, itemFive }

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final PageController controller = PageController();
  int selectIndex = 0;
  SampleItem? selectedMenu;
  ColorNotifire notifire = ColorNotifire();
  List img = [
    AppAssets.player1,
    AppAssets.player2,
    AppAssets.player1,
    AppAssets.player2,
  ];
  List img1 = [
    AppAssets.ronaldo,
    AppAssets.ronaldo1,
    AppAssets.ronaldo,
    AppAssets.ronaldo1,
  ];
  List title = [
    'Leao hails hat-trick hero\nRamos as president\npurrs over Portugal',
    'Ronaldo denies mega-money\nAl Nassr deal is\nsigned and sealed',
    'Leao hails hat-trick hero\nRamos as president\npurrs over Portugal',
    'Ronaldo denies mega-money\nAl Nassr deal is\nsigned and sealed',
  ];
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
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    GlobalKey<FormState> abcKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      key: abcKey,
      appBar: AppBar(
        backgroundColor: notifire.background,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_rounded,
            color: notifire.textcolore,
          ),
        ),
        title: Text(
          'Watch',
          style: TextStyle(
            fontFamily: "Urbanist_bold",
            color: notifire.textcolore,
            fontSize: 20,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(const SearchScreen());
              },
              child: Image.asset(
                AppAssets.search,
                height: 28,
                width: 28,
                color: notifire.textcolore,
              )),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 280,
                width: 350,
                child: GestureDetector(
                  onTap: () {
                    Get.to(const VideoScreen());
                  },
                  child: PageView(
                    controller: controller,
                    children: <Widget>[
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: const Image(
                              height: 200,
                              width: 350,
                              fit: BoxFit.cover,
                              image: AssetImage(AppAssets.ronaldo),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text(
                              'Ronaldo denies mega-money Al Nassr deal is signed and sealed',
                              style: TextStyle(
                                  fontFamily: 'Urbanist_bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: notifire.textcolore),
                            ),
                            subtitle: Text(
                              '10 hours ago',
                              style: TextStyle(
                                  fontFamily: 'Urbanist_medium',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: notifire.textcolore),
                            ),
                            trailing: Transform.translate(
                              offset: const Offset(15, -20),
                              child: PopupMenuButton<SampleItem>(
                                color: notifire.textcolore,
                                initialValue: selectedMenu,
                                onSelected: (SampleItem item) {
                                  setState(() {
                                    selectedMenu = item;
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<SampleItem>>[
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemOne,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.send,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Share',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemTwo,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.hide,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Hide this',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemThree,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.notinter,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Not Interested',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemFour,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.report,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Report',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemFive,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.feedback,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Send Feedback',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: const Image(
                                height: 200,
                                width: 350,
                                fit: BoxFit.cover,
                                image: AssetImage(AppAssets.ronaldo1)),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                              style: TextStyle(
                                  fontFamily: 'Urbanist_bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: notifire.textcolore),
                            ),
                            subtitle: Text(
                              '16 hours ago',
                              style: TextStyle(
                                  fontFamily: 'Urbanist_medium',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: notifire.textcolore),
                            ),
                            trailing: Transform.translate(
                              offset: const Offset(15, -20),
                              child: PopupMenuButton<SampleItem>(
                                color: notifire.textcolore,
                                initialValue: selectedMenu,
                                onSelected: (SampleItem item) {
                                  setState(() {
                                    selectedMenu = item;
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<SampleItem>>[
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemOne,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.send,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Share',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemTwo,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.hide,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Hide this',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemThree,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.notinter,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Not Interested',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemFour,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.report,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Report',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemFive,
                                    child: ListTile(
                                      leading: Image.asset(
                                        AppAssets.feedback,
                                        height: 20,
                                        width: 20,
                                      ),
                                      title: const Text(
                                        'Send Feedback',
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_semibold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Text(
                  'Shorts Live Streaming',
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
              SizedBox(
                height: 280,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(const VideoScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Stack(
                          children: [
                            Container(
                              height: 280,
                              width: 186,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(img[index]),
                                    fit: BoxFit.cover),
                                color: Colors.red,
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Container(
                                height: 24,
                                width: 41,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColor.pinkColor,
                                ),
                                child: const Center(
                                    child: Text(
                                  'LIVE',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist_semibold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                            Positioned(
                              left: 60,
                              top: 10,
                              child: Container(
                                height: 24,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(0.50),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      AppAssets.persons,
                                      color: Colors.white,
                                      height: 16,
                                      width: 16,
                                    ),
                                    const Text(
                                      '1.8K',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_semibold',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Positioned(
                              right: 10,
                              top: 10,
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                title[index],
                                style: const TextStyle(
                                    fontFamily: 'Urbanist_semibold',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                leading: Text(
                  'Featured',
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
              SizedBox(
                height: 280,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: img1.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(const VideoScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Stack(
                          children: [
                            Container(
                              height: 280,
                              width: 186,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(img1[index]),
                                    fit: BoxFit.cover),
                                color: Colors.red,
                              ),
                            ),
                            const Positioned(
                              right: 10,
                              top: 10,
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                title[index],
                                style: const TextStyle(
                                    fontFamily: 'Urbanist_semibold',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(const VideoScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
