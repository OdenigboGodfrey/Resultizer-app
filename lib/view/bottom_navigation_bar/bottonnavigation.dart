import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/features/account/presentation/screen/account_screen.dart';
import 'package:resultizer_merged/features/home/presentation/screen/home_view.dart';
import 'package:resultizer_merged/features/videos/presentation/screens/feeds.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/view/favorite_screen/favorite_screen.dart';
import 'package:resultizer_merged/view/home_view/news_view.dart';
import 'package:resultizer_merged/view/watch_screen/watch_screen.dart';

import '../../theme/themenotifer.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  ColorNotifire notifire = ColorNotifire();
  List bottom = [
    const HomeScreenView(),
    const FavoriteScreen(),
    const NewsviewScreen(),
    const AccountScreenView(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        heroTag: null,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) { 
                return const FeedsView();
                // return const WatchScreen();
              },
            ),
          );
        },
        child: notifire.image,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: notifire.insidecolor,
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _selectedIndex == 0
                          ? Image.asset(
                              AppAssets.fillHome1,
                              height: 24,
                              width: 24,
                            )
                          : Image.asset(
                              AppAssets.fillHome,
                              height: 24,
                              width: 24,
                              color: _selectedIndex == 0
                                  ? AppColor.pinkColor
                                  : notifire.textcolore,
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 12,
                            color: _selectedIndex == 0
                                ? AppColor.pinkColor
                                : notifire.textcolore,
                            fontFamily: 'Urbanist-regular'),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _selectedIndex == 1
                          ? Image.asset(
                              AppAssets.stareBottom1,
                              height: 24,
                              width: 24,
                            )
                          : Image.asset(
                              AppAssets.starblank,
                              height: 24,
                              width: 24,
                              color: notifire.textcolore,
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Favorites',
                        style: TextStyle(
                            fontSize: 12,
                            color: _selectedIndex == 1
                                ? AppColor.pinkColor
                                : notifire.textcolore,
                            fontFamily: 'Urbanist-regular'),
                      )
                    ],
                  )),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _selectedIndex == 2
                          ? Image.asset(
                              AppAssets.newsic1,
                              height: 24,
                              width: 24,
                            )
                          : Image.asset(
                              AppAssets.newsic,
                              height: 24,
                              width: 24,
                              color: notifire.textcolore,
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'News',
                        style: TextStyle(
                            fontSize: 12,
                            color: _selectedIndex == 2
                                ? AppColor.pinkColor
                                : notifire.textcolore,
                            fontFamily: 'Urbanist-regular'),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _selectedIndex == 3
                          ? Image.asset(
                              AppAssets.person01,
                              height: 24,
                              width: 24,
                            )
                          : Image.asset(
                              AppAssets.person,
                              height: 24,
                              width: 24,
                              color: notifire.textcolore,
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Account',
                        style: TextStyle(
                            fontSize: 12,
                            color: _selectedIndex == 3
                                ? AppColor.pinkColor
                                : notifire.textcolore,
                            fontFamily: 'Urbanist-regular'),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: bottom[_selectedIndex],
      ),
    );
  }
}
