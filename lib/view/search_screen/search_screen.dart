import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_textfild.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';

import '../../theme/themenotifer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ColorNotifire notifire = ColorNotifire();
  List img = [
    AppAssets.image1,
    AppAssets.image2,
    AppAssets.chapion,
    AppAssets.eurpa,
    AppAssets.euro,
    AppAssets.uefa,
    AppAssets.flag1,
    AppAssets.flag2,
    AppAssets.flag3,
    AppAssets.flag4,
  ];
  List text = [
    'World Cup 2022',
    'England',
    'Champions League',
    'Europa League',
    'Euro 2024 Qualification',
    'UEFA Nation League',
    'France',
    'New York',
    'Dubai',
    'signora',
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            AppAssets.backButton,
                            height: 20,
                            width: 20,
                            color: notifire.textcolore,
                          )),
                      const Expanded(
                          child: SizedBox(
                        width: 10,
                      )),
                      Expanded(
                        flex: 18,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: notifire.search,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: search(
                            text: 'Search Country',
                            image: AppAssets.search,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Popular Search',
                    style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: notifire.textcolore),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: img.length,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            img[index],
                            height: 44,
                            width: 44,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            text[index],
                            style: TextStyle(
                                fontFamily: 'Urbanist_bold',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: notifire.textcolore),
                          ),
                          const Expanded(
                              child: SizedBox(
                            width: 10,
                          )),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 20,
                            color: notifire.textcolore,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
