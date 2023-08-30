import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/utils/constant/app_assets.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_color.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  ColorNotifire notifire = ColorNotifire();
  int selectIndex = 0;
  List title = [
    'General',
    'Account',
    'Service',
    'Payment',
  ];
  List text = [
    'What is Resultizer?',
    'What are the services in Resultizer?',
    'Can I stream sports on Resultizer?',
    'How can I contact contact support?',
    'How to close an Resultizer account?',
  ];
  List img = [
    AppAssets.customer,
    AppAssets.whatapp,
    AppAssets.website,
    AppAssets.facebook,
    AppAssets.twiter,
    AppAssets.instragram,
  ];
  List helptxt = [
    'Customer Service',
    'WhatsApp',
    'Website',
    'Facebook',
    'Twitter',
    'Instagram',
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: notifire.bgcolore,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: notifire.bgcolore,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_sharp,
                color: notifire.textcolore,
              )),
          title: const Text("Help Center"),
          titleTextStyle: TextStyle(
            fontFamily: "Urbanist_bold",
            color: notifire.textcolore,
            fontSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(
                dividerColor: notifire.background,
                tabs: const [
                  Tab(
                    text: 'FAQ',
                  ),
                  Tab(
                    text: 'Contact us',
                  ),
                ],
              ),
              SizedBox(
                height: Get.size.height,
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: SizedBox(
                            height: 38,
                            child: ListView.separated(
                              itemCount: title.length,
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
                                        ? 99
                                        : index == 1
                                            ? 101
                                            : index == 2
                                                ? 96
                                                : 105,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: selectIndex == index
                                          ? AppColor.pinkColor
                                          : notifire.bgcolore,
                                      border: Border.all(
                                        width: 2,
                                        color: selectIndex == index
                                            ? AppColor.pinkColor
                                            : AppColor.pinkColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        title[index],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "gilroy_medium",
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          child: TextField(
                            style: TextStyle(
                                color: notifire.textcolore,
                                fontFamily: 'Urbanist_regular',
                                fontSize: 16),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              filled: true,
                              fillColor: notifire.insidecolor,
                              focusedBorder: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: notifire.insidecolor),
                              ),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  fontFamily: 'Urbanist_regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: notifire.textcolore),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(AppAssets.search,
                                    height: 10,
                                    width: 10,
                                    color: notifire.textcolore),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: text.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: notifire.borercolour, width: 1),
                              ),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: Text(
                                    text[index],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Urbanist_bold',
                                        color: notifire.textcolore),
                                  ),
                                  children: [
                                    ListTile(
                                        title: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do usermod temper incident ut laborer et dolore magna aliqua.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Urbanist_medium',
                                          color: notifire.textcolore),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: img.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: notifire.borercolour, width: 1),
                                ),
                                child: ListTile(
                                  leading: Image.asset(
                                    img[index],
                                    height: 24,
                                    width: 24,
                                  ),
                                  title: Text(
                                    helptxt[index],
                                    style: TextStyle(
                                        fontFamily: 'Urbanist_bold',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: notifire.textcolore),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
}
