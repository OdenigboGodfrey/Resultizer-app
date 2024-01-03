import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/view/home_view/detail_screen.dart';
import 'package:resultizer_merged/view/home_view/matchdtails.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import '../../utils/constant/app_color.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  ColorNotifire notifire = ColorNotifire();
  int selectIndex = 0;
  List text = [
    'Fixtures',
    'Results',
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      appBar: AppBar(
        backgroundColor: notifire.background,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: notifire.textcolore),
        ),
        title: Text('LIVE Match', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 20, color: notifire.textcolore),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: SizedBox(
                height: 45,
                child: ListView.separated(
                  itemCount: text.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10,);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectIndex = index;
                        });
                      },
                      child: Container(
                        width: 185,
                        padding: const EdgeInsets.symmetric(horizontal: 10,),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: selectIndex == index ? AppColor.pinkColor : notifire.background,
                          border: Border.all(
                            width: 2,
                            color: selectIndex == index ? AppColor.pinkColor : AppColor.pinkColor,
                          ),
                        ),
                        child: Center(
                          child: Text(text[index], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "gilroy_medium", color: selectIndex == index ? Colors.white : AppColor.pinkColor ), overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child:  livematch(selectIndex),
            ),
          ],
        ),
      ),
    );
  }
  Widget livematch(int index){
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(const Matchdetail());
          },
          child: Stack(
            children: [
              Container(
                height: 242,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xff4C0033),
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
                            const SizedBox(height: 20,),
                            const Text('World Cup 2022', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 24, color: Colors.white),),
                            const Text('FIFA', style: TextStyle(fontFamily: 'Urbanist_medium', fontWeight: FontWeight.w500, fontSize: 16, color: AppColor.greyColor),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(AppAssets.team3, height: 80,),
                                    const Text('United', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('1 : 3', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 40, color: Colors.white),),
                                    Container(
                                      height: 26,
                                      width: 66,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('90 + 2', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(AppAssets.chelsea, height: 80,),
                                    const Text('Chelsea', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
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
        const SizedBox(height: 20,),
        GestureDetector(
          onTap: () {
            Get.to(const DetailScreen());
          },
          child: Stack(
            children: [
              Container(
                height: 242,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xff673AB3),
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
                            const SizedBox(height: 20,),
                            const Text('Premier League', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 24, color: Colors.white),),
                            const Text('England', style: TextStyle(fontFamily: 'Urbanist_medium', fontWeight: FontWeight.w500, fontSize: 16, color: AppColor.greyColor),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(AppAssets.team1, height: 80,),
                                    const Text('Arsenal', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('3 : 5', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 40, color: Colors.white),),
                                    Container(
                                      height: 26,
                                      width: 66,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('90 + 2', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(AppAssets.team2, height: 80,),
                                    const Text('Brentford', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
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
        const SizedBox(height: 20,),
        index == 1 ? const SizedBox() : GestureDetector(
          onTap: () {
            Get.to(const DetailScreen());
          },
          child: Stack(
            children: [
              Container(
                height: 242,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xff3F51B2),
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
                            const SizedBox(height: 20,),
                            const Text('World Cup 2022', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 24, color: Colors.white),),
                            const Text('FIFA', style: TextStyle(fontFamily: 'Urbanist_medium', fontWeight: FontWeight.w500, fontSize: 16, color: AppColor.greyColor),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(AppAssets.team7, height: 80,),
                                    const Text('Liverpool', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('2 : 6', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 40, color: Colors.white),),
                                    Container(
                                      height: 26,
                                      width: 66,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('90 + 4', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(AppAssets.team1, height: 80,),
                                    const Text('Arsenal', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white),),
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
      ],
    );
  }
}
