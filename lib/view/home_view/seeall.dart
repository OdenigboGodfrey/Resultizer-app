import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import 'detail_screen.dart';

class SeeallScreen extends StatefulWidget {
  const SeeallScreen({super.key});

  @override
  State<SeeallScreen> createState() => _SeeallScreenState();
}

class _SeeallScreenState extends State<SeeallScreen> {
  ColorNotifire notifire = ColorNotifire();
  List time = [
    '10:00',
    '13:00',
    '15:30',
    '10:00',
    '13:00',
    '15:30',
  ];
  List img = [
    'assets/images/folloeImage1.png',
    'assets/images/folloImage2.png',
    'assets/images/follow3.png',
    'assets/images/folloeImage1.png',
    'assets/images/folloImage2.png',
    'assets/images/follow3.png',
  ];
  List country = [
    'Burnley',
    'Luton',
    'Brighton',
    'burlin',
    'New York',
    'finlang'
  ];
  List img1 = [
    'assets/images/follow4.png',
    'assets/images/folloeImage1.png',
    'assets/images/Everton.png',
    'assets/images/follow4.png',
    'assets/images/folloeImage1.png',
    'assets/images/Everton.png',
  ];
  List country1 = [
    'Manchester',
    'Fulham',
    'Everton',
    'FCAB',
    'London',
    'Luton'
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
          child: Icon(Icons.arrow_back, color: notifire.textcolore),
        ),
        title: const Text("All Match"),
        titleTextStyle: TextStyle(fontFamily: "Urbanist_bold", color: notifire.textcolore, fontSize: 20,),
        actions: const [
          Icon(Icons.star, color: Colors.amber,),
          SizedBox(width: 20,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 30),
              child: Text('Today, 30 December', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: notifire.textcolore),),
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: time.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const DetailScreen());
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 116,
                              width: 382,
                              decoration: BoxDecoration(
                                color: notifire.insidecolor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 1, color: notifire.borercolour),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    leading: Text(time[index], style:  TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 15, color: notifire.textcolore),),
                                    title: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(img[index], height: 36, width: 36,),
                                            const SizedBox(width: 10,),
                                            Text(country[index], style:  TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: notifire.textcolore),),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Image.asset(img1[index], height: 36, width: 36,),
                                            const SizedBox(width: 10,),
                                            Text(country1[index], style:  TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: notifire.textcolore),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: RatingBar.builder(
                                      itemSize: 24,
                                      initialRating: 0,
                                      direction: Axis.horizontal,
                                      itemCount: 1,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => const Image(image: AssetImage(AppAssets.stare)),
                                      onRatingUpdate: (rating) {},
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
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.deepOrange,
                                ),
                                child: const Center(
                                  child: Text('LIVE', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: Colors.white),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
