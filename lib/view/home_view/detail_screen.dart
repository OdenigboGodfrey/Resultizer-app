import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/utils/constant/app_color.dart';
import 'package:resultizer/view/home_view/matchdtails.dart';
import 'package:resultizer/view/home_view/playerprofile.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ColorNotifire notifire = ColorNotifire();
  List text = [
    'W',
    'L',
    'W',
    'W',
    'W',
  ];
  List<Color> colors = [
    const Color(0xff12D18E),
    const Color(0xffF75555),
    const Color(0xff12D18E),
    const Color(0xff12D18E),
    const Color(0xff12D18E),
  ];
  List img = [
    AppAssets.follow2,
    AppAssets.follow2,
    AppAssets.chelsea,
  ];
  List score = [
    '0 - 2',
    '1 - 3',
    '0 - 1',
  ];
  List img1 = [
    AppAssets.team1,
    AppAssets.follow3,
    AppAssets.follow4,
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      appBar: AppBar(
        backgroundColor: notifire.background,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: notifire.textcolore,
          ),
        ),
        title: Text(
          'Croatia',
          style: TextStyle(
              fontFamily: 'Urbanist_bold',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: notifire.textcolore),
        ),
        actions: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Next Match',
                style: TextStyle(
                    fontFamily: 'Urbanist_bold',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: notifire.textcolore),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                    Get.to(const Matchdetail());
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 242,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: AppColor.purple,
                        ),
                        child: Stack(
                          children: [
                            Center(child: Image.asset(AppAssets.union)),
                            Container(
                              height: 242,
                              color: Colors.transparent,
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Premier League',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          color: Colors.white),
                                    ),
                                    const Text(
                                      'England',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_medium',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: AppColor.greyColor),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              AppAssets.team1,
                                              height: 80,
                                            ),
                                            const Text(
                                              'Arsenal',
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              '15 : 00',
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 40,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '30 Dec',
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_medium',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              AppAssets.team2,
                                              height: 80,
                                            ),
                                            const Text(
                                              'Brentford',
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Form',
                style: TextStyle(
                    fontFamily: 'Urbanist_bold',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: notifire.textcolore),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 151,
                  decoration: BoxDecoration(
                    color: notifire.insidecolor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: notifire.borercolour, width: 1),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Last 5',
                              style: TextStyle(
                                  fontFamily: 'Urbanist_bold',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: notifire.textcolore),
                            ),
                            SizedBox(
                              height: 20,
                              width: 127,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: text.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: colors[index],
                                    ),
                                    child: Center(
                                      child: Text(
                                        text[index],
                                        style: const TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
                        child: Divider(
                          height: 10,
                          thickness: 1,
                          color: notifire.borercolour,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 350,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: img.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 135,
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: notifire.borercolour, width: 1),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      img[index],
                                      height: 20,
                                      width: 20,
                                    ),
                                    Text(
                                      score[index],
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: notifire.textcolore),
                                    ),
                                    Image.asset(
                                      img1[index],
                                      height: 20,
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Player Stats',
                style: TextStyle(
                    fontFamily: 'Urbanist_bold',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: notifire.textcolore),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      stats(),
                      stats(),
                      stats(),
                      stats(),
                    ],
                  ),
                ),
              ),
              Text(
                'Top Scorers',
                style: TextStyle(
                    fontFamily: 'Urbanist_bold',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: notifire.textcolore),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Container(
                      height: 384,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: notifire.insidecolor,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: notifire.borercolour, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(20),
                              1: FixedColumnWidth(50),
                              2: FixedColumnWidth(250),
                            },
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 15),
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 20),
                                    child: Image.asset(
                                      AppAssets.team1,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Mohamed Elneny',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                    subtitle: Text(
                                      'Arsenal',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_medium',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: notifire.textcolore),
                                    ),
                                    trailing: Text(
                                      '9',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 15),
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 20),
                                    child: Image.asset(
                                      AppAssets.team1,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Rob Holding',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                    subtitle: Text(
                                      'Arsenal',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_medium',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: notifire.textcolore),
                                    ),
                                    trailing: Text(
                                      '7',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 15),
                                    child: Text(
                                      '3',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 20),
                                    child: Image.asset(
                                      AppAssets.team1,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'William Saliba',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                    subtitle: Text(
                                      'Arsenal',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_medium',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: notifire.textcolore),
                                    ),
                                    trailing: Text(
                                      '5',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 15),
                                    child: Text(
                                      '4',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 20),
                                    child: Image.asset(
                                      AppAssets.team1,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Héctor Bellerín',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                    subtitle: Text(
                                      'Arsenal',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_medium',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: notifire.textcolore),
                                    ),
                                    trailing: Text(
                                      '2',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  )
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 15),
                                    child: Text(
                                      '5',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 20),
                                    child: Image.asset(
                                      AppAssets.team1,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Jorginho',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                    subtitle: Text(
                                      'Arsenal',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_medium',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: notifire.textcolore),
                                    ),
                                    trailing: Text(
                                      '1',
                                      style: TextStyle(
                                          fontFamily: 'Urbanist_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: notifire.textcolore),
                                    ),
                                  )
                                ],
                              ),
                            ],
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
    );
  }

  Widget stats() {
    return GestureDetector(
      onTap: () {
        Get.to(const Playerprofile());
      },
      child: Stack(
        children: [
          Image.asset(
            'assets/images/backgroud.png',
            height: 103,
          ),
          Positioned(
            top: 10,
            left: 15,
            child: Row(
              children: [
                Transform.translate(
                    offset: const Offset(0, -10),
                    child: Image.asset(
                      AppAssets.goulkeeper,
                      height: 42,
                    )),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sergio Aguero',
                      style: TextStyle(
                          fontFamily: 'Urbanist_semibold',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                    Text(
                      'Most Goals',
                      style: TextStyle(
                          fontFamily: 'Urbanist_regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    Text(
                      '2',
                      style: TextStyle(
                          fontFamily: 'Urbanist_semibold',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
