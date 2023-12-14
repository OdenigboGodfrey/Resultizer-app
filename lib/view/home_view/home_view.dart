import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/view/home_view/live_screen.dart';
import 'package:resultizer_merged/view/home_view/premierleague.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/model/drawer_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectIndex = 0;
  int selected = 0;
  dynamic selectedValue;
  ColorNotifire notifire = ColorNotifire();
  List cup = [
    'World Cup 20221',
    'World Cup 2022',
    'World Cup 2022',
    'Premier League',
  ];
  List logo = [
    'assets/images/Poland.png',
    'assets/images/canada.png',
    'assets/images/Germany.png',
  ];

  List logo1 = [
    'assets/images/Argentina.png',
    'assets/images/Morocco.png',
    'assets/images/Costa Rica.png',
  ];
  List subtitle = [
    'Group C',
    'Group F',
    'Group E',
    'England',
  ];
  List time = [
    'FT     ',
    '10:00 ',
    '18:00 ',
  ];
  List text = [
    'Poland',
    'Canada',
    'Costa Rica',
  ];
  List text1 = [
    'Argentina',
    'Morocco',
    'Germany',
  ];
  // Second list
  List logo2 = [
    'assets/images/arebia.png',
    'assets/images/Croatia.png',
    'assets/images/japan.png',
  ];
  List logo02 = [
    'assets/images/mexico.png',
    'assets/images/Belgium.png',
    'assets/images/spain.png',
  ];
  List time2 = [
    '15:00',
    '14:00',
    '21:00',
  ];
  List text2 = [
    'Saudi Arabia',
    'Croatia',
    'Japan',
  ];
  List text02 = [
    'Mexico',
    'Belgium',
    'Spain',
  ];
  List<DrawerModel> imagelist = [
    DrawerModel(
      image: AppAssets.frame,
      name: 'Football',
    ),
    DrawerModel(
      image: AppAssets.frame1,
      name: 'Tennis',
    ),
    DrawerModel(
      image: AppAssets.frame2,
      name: 'Basketball',
    ),
    DrawerModel(
      image: AppAssets.frame3,
      name: 'Hockey',
    ),
    DrawerModel(
      image: AppAssets.frame4,
      name: 'Volleyball',
    ),
    DrawerModel(
      image: AppAssets.frame5,
      name: 'Handball',
    ),
    DrawerModel(
      image: AppAssets.frame6,
      name: 'Esports',
    ),
    DrawerModel(
      image: AppAssets.frame7,
      name: 'Baseball',
    ),
    DrawerModel(
      image: AppAssets.frame8,
      name: 'Cricket',
    ),
    DrawerModel(
      image: AppAssets.frame9,
      name: 'Motorsport',
    ),
    DrawerModel(
      image: AppAssets.frame10,
      name: 'Rugby',
    ),
  ];
  final List day = [
    AppString.sun,
    AppString.mon,
    AppString.tod,
    AppString.wet,
    AppString.thu,
    AppString.fri,
    AppString.sat,
  ];
  final List date = [
    AppString.date1,
    AppString.date2,
    AppString.date3,
    AppString.date4,
    AppString.date5,
    AppString.date6,
    AppString.date7,
  ];
  int fillstar1 = 0;
  int fillstar2 = 0;
  int fillstar3 = 0;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: notifire.background,
      key: GlobalDataSource.scaffoldKey,
      drawer: drawer1(),
      appBar: commonappbar(
          title: 'Resultizer', image: AppAssets.search, context: context),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 10,
          ),
          // Team name
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: height / 22,
              child: ListView.separated(
                itemCount: imagelist.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: selectIndex == index
                            ? AppColor.pinkColor
                            : notifire.background,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 2,
                          color: AppColor.pinkColor,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                imagelist[index].image.toString(),
                                color: selectIndex == index
                                    ? Colors.white
                                    : notifire.textcolore,
                              ),
                            ),
                            Text(
                              imagelist[index].name.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Urbanist_medium",
                                color: selectIndex == index
                                    ? Colors.white
                                    : AppColor.pinkColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // Calendar
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const LiveScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            width: 2,
                            color: AppColor.pinkColor,
                          ),
                        ),
                        child: const Text(
                          "Live",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Urbanist_medium",
                            color: AppColor.pinkColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: day.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = index;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 14,
                                    width: MediaQuery.of(context).size.width /
                                        8.48,
                                    decoration: BoxDecoration(
                                      color: selected == index
                                          ? AppColor.pinkColor
                                          : notifire.background,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          day[index],
                                          style: TextStyle(
                                            color: selected == index
                                                ? Colors.white
                                                : notifire.textcolore,
                                            fontFamily: 'Urbanist_semibold',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          date[index],
                                          style: TextStyle(
                                            color: selected == index
                                                ? Colors.white
                                                : notifire.textcolore,
                                            fontSize: 14,
                                            fontFamily: 'Urbanist_bold',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDatePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: AppColor.pinkColor,
                                          onPrimary: Colors.white,
                                          onSurface: AppColor.blackColor,
                                          surface: Color(0xffFFFFFF)),
                                    ),
                                    child: child!);
                              },
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                        },
                        child: Image.asset(
                          AppAssets.calender,
                          height: height / 22,
                          width: width / 22,
                          color: AppColor.pinkColor,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // World Cup
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: logo.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(const premierscreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 280,
                                  decoration: BoxDecoration(
                                    color: notifire.insidecolor,
                                    border: Border.all(
                                        color: notifire.borercolour, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        leading: Image.asset(
                                          AppAssets.image1,
                                          height: 30,
                                          width: 30,
                                        ),
                                        title: Row(
                                          children: [
                                            Text(cup[index],
                                                style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: notifire.textcolore,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Icon(Icons.star,
                                                color: Colors.amber, size: 13),
                                          ],
                                        ),
                                        subtitle: Text(subtitle[index],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Urbanist-medium',
                                              color: notifire.textcolore,
                                            )),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: notifire.textcolore,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Divider(
                                          height: 10,
                                          thickness: 1,
                                          color: notifire.borercolour,
                                        ),
                                      ),
                                      ListTile(
                                        leading: Text(
                                          time[index],
                                          style: TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: notifire.textcolore,
                                          ),
                                        ),
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  logo[index],
                                                  height: 26,
                                                  width: 26,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  text[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Urbanist_bold',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: notifire.textcolore,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  logo1[index],
                                                  height: 26,
                                                  width: 26,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  text1[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Urbanist_bold',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: notifire.textcolore,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: RatingBar.builder(
                                          itemSize: 24,
                                          initialRating: 0,
                                          direction: Axis.horizontal,
                                          itemCount: 1,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Image(
                                                  image: AssetImage(
                                                      AppAssets.stare)),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Divider(
                                          height: 10,
                                          thickness: 1,
                                          color: notifire.borercolour,
                                        ),
                                      ),
                                      ListTile(
                                        leading: Text(
                                          time2[index],
                                          style: TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: notifire.textcolore,
                                          ),
                                        ),
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  logo2[index],
                                                  height: 26,
                                                  width: 26,
                                                ),
                                                Text(
                                                  text2[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Urbanist_bold',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: notifire.textcolore,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  logo02[index],
                                                  height: 26,
                                                  width: 26,
                                                ),
                                                Text(
                                                  text02[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Urbanist_bold',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: notifire.textcolore,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: RatingBar.builder(
                                          itemSize: 24,
                                          initialRating: 0,
                                          direction: Axis.horizontal,
                                          itemCount: 1,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Image(
                                                  image: AssetImage(
                                                      AppAssets.stare)),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Positioned(
                              left: Get.width * 0.35,
                              top: -18,
                              child: Container(
                                height: 34,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.deepOrange,
                                ),
                                child: const Center(
                                  child: Text(
                                    'LIVE',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist_bold',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Premier League
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(const premierscreen());
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 450,
                                decoration: BoxDecoration(
                                    color: notifire.insidecolor,
                                    border: Border.all(
                                        color: notifire.borercolour, width: 1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      leading: Image.asset(
                                        AppAssets.image2,
                                        height: 30,
                                        width: 30,
                                      ),
                                      title: Row(
                                        children: [
                                          Text(
                                            'Premier League',
                                            style: TextStyle(
                                              fontFamily: 'Urbanist_bold',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: notifire.textcolore,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 13),
                                        ],
                                      ),
                                      subtitle: Text('England',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Urbanist-medium',
                                            color: notifire.textcolore,
                                          )),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: notifire.textcolore,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Divider(
                                        height: 10,
                                        thickness: 1,
                                        color: notifire.borercolour,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Divider(
                                        height: 10,
                                        thickness: 1,
                                        color: notifire.borercolour,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Divider(
                                        height: 10,
                                        thickness: 1,
                                        color: notifire.borercolour,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Divider(
                                        height: 10,
                                        thickness: 1,
                                        color: notifire.borercolour,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: Get.width * 0.35,
                                top: -18,
                                child: Container(
                                  height: 34,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.deepOrange,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'LIVE',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
