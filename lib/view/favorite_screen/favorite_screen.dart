import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/home/presentation/screen/competition_fixture_view.dart';
import 'package:resultizer_merged/features/home/presentation/screen/team_fixture_view.dart';

import '../../common/common_appbar.dart';
import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/model/favorite_model.dart';
import '../home_view/premierleague.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() { selectIndex = 0; });
  }
  int selectIndex = 0;
  ColorNotifire notifire = ColorNotifire();
  List text = [
    'Matches',
    'Competitions',
    'Teams',
  ];
  List img = [
    'assets/images/folloeImage1.png',
    'assets/images/folloImage2.png',
  ];
  List country = [
    'Burnley',
    'Luton',
  ];
  List img1 = [
    'assets/images/follow4.png',
    'assets/images/folloeImage1.png',
  ];
  List country1 = [
    'Manchester',
    'Fulham',
  ];
  List winner = [
    '1',
    '2',
  ];
  List winner1 = [
    '2',
    '0',
  ];
  List<favoriteModel> competion = [
    favoriteModel(
      image: AppAssets.image1,
      title: 'World Cup 2022',
      subTitle: 'FIFA',
    ),
    favoriteModel(
        image: AppAssets.image2, title: 'Premier League', subTitle: 'England'),
    favoriteModel(
      image: AppAssets.chapion,
      title: 'Champions League',
      subTitle: 'UEFA',
    ),
    favoriteModel(
      image: AppAssets.eurpa,
      title: 'Europa League',
      subTitle: 'UEFA',
    ),
    favoriteModel(
      image: AppAssets.luliga,
      title: 'LaLiga Santander',
      subTitle: 'Spain',
    ),
    favoriteModel(
      image: AppAssets.eradivi,
      title: 'Eredivisie',
      subTitle: 'Netherlands',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      key: GlobalDataSource.scaffoldKey,
      drawer: drawer1(),
      appBar: commonappbar(
        title: 'Resultizer'.tr,
        
        context: context,
        scaffoldKey: GlobalDataSource.scaffoldKey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              // List of Matches
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: SizedBox(
                  height: 38,
                  child: ListView.separated(
                    itemCount: text.length,
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
                          width: index == 0
                              ? 109
                              : index == 1
                                  ? 140
                                  : 109,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: selectIndex == index
                                ? AppColor.pinkColor
                                : notifire.background,
                            border: Border.all(
                              width: 2,
                              color: selectIndex == index
                                  ? AppColor.pinkColor
                                  : AppColor.pinkColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              text[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Urbanist_medium",
                                  color: selectIndex == index
                                      ? Colors.white
                                      : AppColor.pinkColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              selectIndex == 0
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Get.to(const premierscreen());
                            // Get.to(const TeamFixtureScreenView(teamId: 16487,));
                            Get.to(const CompetitionFixtureScreenView(competitionId: 254,));
                          },
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 270,
                                    decoration: BoxDecoration(
                                        color: notifire.insidecolor,
                                        border: Border.all(
                                            color: notifire.borercolour,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
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
                                                    color: notifire.textcolore),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 13),
                                            ],
                                          ),
                                          subtitle: const Text('England',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Urbanist-medium',
                                                  color: AppColor.greyscale)),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 16,
                                              color: notifire.textcolore),
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
                                            '20 Dec\n14:00',
                                            style: TextStyle(
                                                fontFamily: 'Urbanist_bold',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: notifire.textcolore),
                                          ),
                                          title: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Chelsea.png',
                                                    height: 26,
                                                    width: 26,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Chelsea',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Urbanist_bold',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: notifire
                                                            .textcolore),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Arsenal.png',
                                                    height: 26,
                                                    width: 26,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Arsenal',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Urbanist_bold',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: notifire
                                                            .textcolore),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Column(
                                            children: [
                                              star(),
                                            ],
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
                                            '20 Dec\n16:00',
                                            style: TextStyle(
                                                fontFamily: 'Urbanist_bold',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: notifire.textcolore),
                                          ),
                                          title: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Liverpoll.png',
                                                    height: 26,
                                                    width: 26,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Liverpoll',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Urbanist_bold',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: notifire
                                                            .textcolore),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Manchaster City.png',
                                                    height: 26,
                                                    width: 26,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Manchaster City',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Urbanist_bold',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: notifire
                                                            .textcolore),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Column(
                                            children: [
                                              star(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(const premierscreen());
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 15),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: notifire.insidecolor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 1,
                                          color: notifire.borercolour),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Image.asset(
                                            AppAssets.image1,
                                            height: 30,
                                            width: 30,
                                          ),
                                          title: Text(
                                            'World Cup 2022',
                                            style: TextStyle(
                                                fontFamily: 'Urbanist_bold',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: notifire.textcolore),
                                          ),
                                          subtitle: Text(
                                            'Group B',
                                            style: TextStyle(
                                                fontFamily: 'Urbanist_medium',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: notifire.textcolore),
                                          ),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 16,
                                              color: notifire.textcolore),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Divider(
                                            height: 10,
                                            thickness: 1,
                                            color: notifire.borercolour,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'FT',
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: notifire.textcolore),
                                            ),
                                            const SizedBox(
                                              width: 35,
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        img1[index],
                                                        height: 26,
                                                        width: 26,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        country1[index],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Urbanist_bold',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15,
                                                            color: notifire
                                                                .textcolore),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        img[index],
                                                        height: 26,
                                                        width: 26,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        country[index],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Urbanist_bold',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15,
                                                            color: notifire
                                                                .textcolore),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  winner1[index],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Urbanist-bold',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          notifire.textcolore),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  winner[index],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Urbanist-bold',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          notifire.textcolore),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                star(),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Divider(
                                            height: 10,
                                            thickness: 1,
                                            color: notifire.borercolour,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'FT',
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: notifire.textcolore),
                                            ),
                                            const SizedBox(
                                              width: 35,
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        img1[1],
                                                        height: 26,
                                                        width: 26,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        country1[1],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Urbanist_bold',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15,
                                                            color: notifire
                                                                .textcolore),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        img[1],
                                                        height: 26,
                                                        width: 26,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        country[1],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Urbanist_bold',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 15,
                                                            color: notifire
                                                                .textcolore),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  winner1[1],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Urbanist-bold',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          notifire.textcolore),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  winner[1],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Urbanist-bold',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          notifire.textcolore),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                star(),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : selectIndex == 1
                      ? Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: competion.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(const premierscreen());
                                  },
                                  child: Container(
                                    height: 88,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      color: notifire.insidecolor,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: notifire.borercolour,
                                          width: 1),
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        leading: Image.asset(
                                          competion[index].image.toString(),
                                          height: 40,
                                          width: 40,
                                        ),
                                        title: Text(
                                          competion[index].title.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Urbanist_bold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: notifire.textcolore),
                                        ),
                                        subtitle: Text(
                                          competion[index].subTitle.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Urbanist_medium',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: notifire.textcolore),
                                        ),
                                        trailing: star(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : DefaultTabController(
                          length: 3,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                dividerColor: notifire.background,
                                isScrollable: true,
                                tabs: const [
                                  Tab(
                                    text: 'World Cup 2022',
                                  ),
                                  Tab(
                                    text: 'Premier League',
                                  ),
                                  Tab(
                                    text: 'Champions League',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 600,
                                width: Get.size.width,
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          wouldcup(
                                              title: 'Netherlands',
                                              image: AppAssets.flag1,
                                              subtitle: 'Netherlands'),
                                          wouldcup(
                                              title: 'Argentina',
                                              image: AppAssets.flag2,
                                              subtitle: 'Argentina'),
                                          wouldcup(
                                              title: 'Croatia',
                                              image: AppAssets.flag3,
                                              subtitle: 'Croatia'),
                                          wouldcup(
                                              title: 'Morocco',
                                              image: AppAssets.flag4,
                                              subtitle: 'Morocco'),
                                          wouldcup(
                                              title: 'Portugal',
                                              image: AppAssets.flag5,
                                              subtitle: 'Portugal'),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: AppColor.pinkColor,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Add Teams',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Urbanist_bold',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          wouldcup(
                                              title: 'Arsenal',
                                              image: AppAssets.team1,
                                              subtitle: 'Arsenal'),
                                          wouldcup(
                                              title: 'Manchester United',
                                              image: AppAssets.team3,
                                              subtitle: 'Manchester United'),
                                          wouldcup(
                                              title: 'Chelsea',
                                              image: AppAssets.chelsea,
                                              subtitle: 'Chelsea'),
                                          wouldcup(
                                              title: 'Newcastle United',
                                              image: AppAssets.follow3,
                                              subtitle: 'Newcastle United'),
                                          wouldcup(
                                              title: 'Manchester City',
                                              image: AppAssets.team2,
                                              subtitle: 'Manchester City'),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        wouldcup(
                                            title: 'Netherlands',
                                            image: AppAssets.flag1,
                                            subtitle: 'Netherlands'),
                                        wouldcup(
                                            title: 'Argentina',
                                            image: AppAssets.flag2,
                                            subtitle: 'Argentina'),
                                        wouldcup(
                                            title: 'Croatia',
                                            image: AppAssets.flag3,
                                            subtitle: 'Croatia'),
                                        wouldcup(
                                            title: 'Morocco',
                                            image: AppAssets.flag4,
                                            subtitle: 'Morocco'),
                                        wouldcup(
                                            title: 'Portugal',
                                            image: AppAssets.flag5,
                                            subtitle: 'Portugal'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wouldcup(
      {required String title,
      required String image,
      required String subtitle}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(const premierscreen());
          },
          child: Container(
            height: 88,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: notifire.insidecolor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: notifire.borercolour, width: 1),
            ),
            child: Center(
              child: ListTile(
                leading: Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
                title: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Urbanist_bold',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: notifire.textcolore),
                ),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(
                      fontFamily: 'Urbanist_medium',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: notifire.textcolore),
                ),
                trailing: star(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget star() {
    return RatingBar.builder(
      itemSize: 24,
      initialRating: 0,
      direction: Axis.horizontal,
      itemCount: 1,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) =>
          const Image(image: AssetImage(AppAssets.stare)),
      onRatingUpdate: (rating) {},
    );
  }
}
