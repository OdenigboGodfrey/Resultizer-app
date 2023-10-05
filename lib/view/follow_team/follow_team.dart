// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/utils/model/follow_to_model.dart';
import 'package:resultizer_merged/utils/model/set_notification_model.dart';
import 'package:resultizer_merged/view/bottom_navigation_bar/bottonnavigation.dart';

import '../../common/common_textfild.dart';
import '../../theme/themenotifer.dart';

class FollowTeam extends StatefulWidget {
  const FollowTeam({Key? key}) : super(key: key);

  @override
  State<FollowTeam> createState() => _FollowTeamState();
}

class _FollowTeamState extends State<FollowTeam> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  SingleValueDropDownController? cnt = SingleValueDropDownController();

  @override
  void initState() {
    cnt = SingleValueDropDownController();

    super.initState();
  }

  var items = [
    "India",
    "Malta",
    "Philippines",
    "United States of America",
  ];

  String dropvalue = "India";
  String countryValue = "India";
  var dropDwonTextfiledvalue = "India";

  int counter = 0;
  bool isObscureText = false;
  bool isConfirmObscureText = false;

  int selectionIndex = 0;
  bool isDone = false;
  bool isRemember = false;

  int? followIndex;

  var countryList = [
    "India",
    "Malta",
    "United States of America",
    "Philippines"
  ];
  List<dynamic> countryName = [
    {
      "name": "India",
      // "value": "value1",
    },
    {
      "name": "Malta",
      // "value": "value2",
    },
    {
      "name": "United States of America",
      // "value": "value3",
    },
    {
      "name": "Philippines",
      // "value": "value4",
    },
  ];

  List<FollowToModel> followPageList = [
    FollowToModel(
        image: AppAssets.follow1,
        isDone: false,
        title: "Burnley",
        subTitle: "Burnley"),
    FollowToModel(
        image: AppAssets.follow2,
        isDone: false,
        title: "Manchester City",
        subTitle: "Manchester City"),
    FollowToModel(
        image: AppAssets.follow3,
        isDone: false,
        title: "Brighton",
        subTitle: "Brighton"),
    FollowToModel(
        image: AppAssets.follow4,
        isDone: false,
        title: "Luton",
        subTitle: "Luton"),
    FollowToModel(
        image: AppAssets.follow4,
        isDone: false,
        title: "Fulham",
        subTitle: "Fulham"),
  ];

  List<SetNotificationModel> setNotificationList = [
    SetNotificationModel(
      image: AppAssets.follow1,
      title: "Burnley",
      subTitle: "Burnley",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow2,
      title: "Manchester City",
      subTitle: "Manchester City",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow3,
      title: "Brighton",
      subTitle: "Brighton",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow4,
      title: "Manchester City",
      subTitle: "Manchester City",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow2,
      title: "fulham",
      subTitle: "fulham",
      isFirstDone: false,
      isSecondDone: false,
    ),
    SetNotificationModel(
      image: AppAssets.follow4,
      title: "fulham",
      subTitle: "fulham",
      isFirstDone: false,
      isSecondDone: false,
    ),
  ];
  List gameList = [
    "Football",
    "Basketball",
    "Ice Hookey",
    "Tennis",
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
        bottomNavigationBar: showBrandsBottomSheet(),
        resizeToAvoidBottomInset: false,
        backgroundColor: notifire.bgcolore,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (counter > 0) {
                            counter--;
                            debugPrint("decreace counter     ----->> $counter");
                          } else {
                            debugPrint("not minus $counter");
                          }
                          if (counter == 0) {
                            Get.back();
                          }
                        });
                      },
                      child: Image.asset(
                        AppAssets.backButton,
                        height: height / 50,
                        color: notifire.textcolore,
                      ),
                    ),
                    SizedBox(
                      width: width / 6,
                    ),
                    LinearPercentIndicator(
                      padding: const EdgeInsets.all(0),
                      width: width / 1.8,
                      lineHeight: height / 130,
                      animationDuration: 2500,
                      percent: counter == 0
                          ? 0.2
                          : counter == 1
                              ? 0.40
                              : counter == 2
                                  ? 0.60
                                  : counter == 3
                                      ? 0.80
                                      : 1,
                      barRadius: const Radius.circular(50),
                      progressColor: AppColor.pinkColor,
                      backgroundColor: AppColor.greyColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                counter == 0
                    ? firstPage()
                    : counter == 1
                        ? secondPage()
                        : counter == 2
                            ? thirdPage()
                            : counter == 3
                                ? forthPage()
                                : counter == 4
                                    ? fifthPage()
                                    : const SizedBox(),
              ],
            ),
          ),
        ));
  }

  showBrandsBottomSheet() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 20,
        vertical: MediaQuery.of(context).size.height / 40,
      ),
      color: notifire.bgcolore,
      // height: MediaQuery.of(context).size.height / 2,
      child: counter == 3
          ? Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: AppColor.pinkColor,
                    buttonName: AppString.continu,
                    textColor: Colors.white,
                    isShadow: true,
                    onTap: () {
                      setState(() {
                        if (counter <= 3) {
                          counter++;
                          debugPrint(" ++++++----- $counter");
                        } else {
                          debugPrint("not work----- $counter");
                        }
                      });
                    },
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Get.offAll(const Bottom());
                      },
                      child: const CommonButton(
                        color: AppColor.babyPinkColor,
                        buttonName: AppString.skip,
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 30,
                ),
                Expanded(
                  child: CommonButton(
                    color: AppColor.pinkColor,
                    buttonName:
                        counter == 4 ? AppString.finish : AppString.continu,
                    textColor: Colors.white,
                    isShadow: true,
                    onTap: () {
                      setState(() {
                        if (counter <= 3) {
                          counter++;
                          debugPrint(" ++++++----- $counter");
                        } else {
                          debugPrint("not work----- $counter");
                        }

                        counter == 4 ? finishDialog() : const SizedBox();
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }

  finishDialog() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Get.offAll(const Bottom());
            },
          );
          return AlertDialog(
            backgroundColor: notifire.background,
            title: Image.asset(
              AppAssets.popupImage,
              height: height / 7,
              width: height / 7,
            ),
            content: Wrap(
              children: [
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Account Setup \n Successful!",
                        style: TextStyle(
                          color: AppColor.pinkColor,
                          fontFamily: "Urbanist_bold",
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Please wait a moment, we are \n preparing for you.",
                        style: TextStyle(
                          color: notifire.textcolore,
                          fontFamily: "Urbanist_regular",
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Lottie.asset("assets/animation_ll3a6kpe.json"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget firstPage() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.followTeams,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_bold",
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.pickAFew,
                maxLines: 2,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_regular",
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: height / 20,
              child: ListView.separated(
                itemCount: gameList.length,
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
                        selectionIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 2,
                          color: selectionIndex == index
                              ? Colors.transparent
                              : AppColor.pinkColor,
                        ),
                        color: selectionIndex == index
                            ? AppColor.pinkColor
                            : notifire.background,
                      ),
                      child: Center(
                        child: Text(
                          gameList[index].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Urbanist_medium",
                            color: selectionIndex == index
                                ? Colors.white
                                : AppColor.pinkColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Search Team
            TextField(
              style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: 'Urbanist_regular',
                  fontSize: 16),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                filled: true,
                fillColor: notifire.insidecolor,
                focusedBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: notifire.insidecolor),
                ),
                hintText: 'Search Teams',
                hintStyle: TextStyle(
                    fontFamily: 'Urbanist_regular',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: notifire.textcolore),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(AppAssets.search,
                      height: 10, width: 10, color: notifire.textcolore),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: notifire.insidecolor,
                border: Border.all(width: 1, color: notifire.borercolour),
              ),
              child: ListView.separated(
                itemCount: followPageList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = followPageList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        data.isDone = !data.isDone!;
                      });
                      debugPrint("followIndex == $followIndex");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          followPageList[index].image.toString(),
                          height: height / 30,
                          width: height / 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Urbanist_medium",
                                  fontWeight: FontWeight.bold,
                                  color: notifire.textcolore),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              data.title.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Urbanist_medium",
                                  color: notifire.textcolore),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const Spacer(),
                        data.isDone!
                            ? Image.asset(
                                AppAssets.stare.toString(),
                                height: height / 50,
                              )
                            : Image.asset(
                                AppAssets.blankStare.toString(),
                                height: height / 50,
                                color: notifire.textcolore,
                              ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 40,
                  color: notifire.borercolour,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget secondPage() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.setNotification,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_bold",
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.chooseTheTeam,
                maxLines: 2,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_regular",
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: height / 20,
              child: ListView.separated(
                itemCount: gameList.length,
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
                        selectionIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 2,
                          color: selectionIndex == index
                              ? Colors.transparent
                              : AppColor.pinkColor,
                        ),
                        color: selectionIndex == index
                            ? AppColor.pinkColor
                            : notifire.bgcolore,
                      ),
                      child: Center(
                        child: Text(
                          gameList[index].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Urbanist_medium",
                            color: selectionIndex == index
                                ? Colors.white
                                : AppColor.pinkColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: notifire.insidecolor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: notifire.borercolour, width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppString.notification,
                        style: TextStyle(
                            fontFamily: "Urbanist_bold",
                            fontSize: 14,
                            color: notifire.textcolore),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        AppString.match,
                        style: TextStyle(
                            fontFamily: "Urbanist_bold",
                            fontSize: 14,
                            color: notifire.textcolore),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppString.news,
                        style: TextStyle(
                            fontFamily: "Urbanist_bold",
                            fontSize: 14,
                            color: notifire.textcolore),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    itemCount: setNotificationList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = setNotificationList[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              data.image.toString(),
                              height: height / 30,
                              width: height / 30,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.title.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Urbanist_medium",
                                        fontWeight: FontWeight.bold,
                                        color: notifire.textcolore),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    data.title.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Urbanist_medium",
                                        color: notifire.textcolore),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  data.isFirstDone = !data.isFirstDone!;
                                  debugPrint(
                                      "isFirstDone == ${data.isFirstDone}!");
                                });
                              },
                              child: data.isFirstDone!
                                  ? Image.asset(
                                      AppAssets.fillNotification,
                                      height: height / 50,
                                    )
                                  : Image.asset(
                                      AppAssets.blankNotification,
                                      height: height / 50,
                                      color: notifire.textcolore,
                                    ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  data.isSecondDone = !data.isSecondDone!;
                                  debugPrint(
                                      "isSecondDone == ${data.isSecondDone}");
                                });
                              },
                              child: data.isSecondDone!
                                  ? Image.asset(
                                      AppAssets.fillNotification,
                                      height: height / 50,
                                    )
                                  : Image.asset(
                                      AppAssets.blankNotification,
                                      height: height / 50,
                                      color: notifire.textcolore,
                                    ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: height / 20,
                      color: notifire.borercolour,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget thirdPage() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.followCompetition,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_bold",
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.pickAFewCompetitions,
                maxLines: 2,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_regular",
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: height / 20,
              child: ListView.separated(
                itemCount: gameList.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: width / 30,
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectionIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 2,
                          color: selectionIndex == index
                              ? Colors.transparent
                              : AppColor.pinkColor,
                        ),
                        color: selectionIndex == index
                            ? AppColor.pinkColor
                            : notifire.bgcolore,
                      ),
                      child: Center(
                        child: Text(
                          gameList[index].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Urbanist_medium",
                            color: selectionIndex == index
                                ? Colors.white
                                : AppColor.pinkColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: 'Urbanist_regular',
                  fontSize: 16),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                filled: true,
                fillColor: notifire.insidecolor,
                focusedBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: notifire.insidecolor),
                ),
                hintText: 'Search Teams',
                hintStyle: TextStyle(
                    fontFamily: 'Urbanist_regular',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: notifire.textcolore),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(AppAssets.search,
                      height: 10, width: 10, color: notifire.textcolore),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: notifire.insidecolor,
                  border: Border.all(color: notifire.borercolour, width: 1)),
              child: ListView.separated(
                itemCount: followPageList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = followPageList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        data.isDone = !data.isDone!;
                      });
                      debugPrint("followIndex == $followIndex");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          followPageList[index].image.toString(),
                          height: height / 30,
                          width: height / 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Urbanist_medium",
                                    fontWeight: FontWeight.bold,
                                    color: notifire.textcolore),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                data.title.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Urbanist_medium",
                                    color: notifire.textcolore),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        data.isDone!
                            ? Image.asset(
                                AppAssets.stare.toString(),
                                height: height / 50,
                              )
                            : Image.asset(
                                AppAssets.blankStare.toString(),
                                height: height / 50,
                                color: notifire.textcolore,
                              ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: height / 20,
                  color: notifire.borercolour,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget forthPage() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.createAnAccount,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_bold",
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.enterEmailAndPassword,
                maxLines: 2,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_regular",
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Urbanist_semiBold",
                    color: notifire.textcolore),
              ),
            ),
            CommonTextfield(
              fieldController: emailController,
              onTap: () {},
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Urbanist_semiBold",
                    color: notifire.textcolore),
              ),
            ),
            CommonTextfield(
              fieldController: passwordController,
              onTap: () {},
              validator: (value) {
                return null;
              },
              obscureText: isObscureText ? false : true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscureText = !isObscureText;
                    debugPrint("isObscureText--- $isObscureText");
                  });
                },
                child: isObscureText
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          AppAssets.eyes,
                          color: AppColor.pinkColor,
                          height: height / 120,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(14),
                        child: Image.asset(
                          AppAssets.offEyes,
                          color: AppColor.pinkColor,
                          height: height / 120,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm Password",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Urbanist_semiBold",
                    color: notifire.textcolore),
              ),
            ),
            CommonTextfield(
              fieldController: confirmPasswordController,
              onTap: () {},
              validator: (value) {
                return null;
              },
              obscureText: isConfirmObscureText ? false : true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isConfirmObscureText = !isConfirmObscureText;
                    debugPrint("isConfirmObscureText--- $isConfirmObscureText");
                  });
                },
                child: isConfirmObscureText
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          AppAssets.eyes,
                          color: AppColor.pinkColor,
                          height: height / 120,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(14),
                        child: Image.asset(
                          AppAssets.offEyes,
                          color: AppColor.pinkColor,
                          height: height / 120,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDone = !isDone;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: AppColor.pinkColor,
                      child: isDone
                          ? Image.asset(
                              AppAssets.done,
                              height: height / 70,
                              width: height / 70,
                            )
                          : SizedBox(
                              height: height / 70,
                              width: height / 70,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 30,
                ),
                Text(
                  "Remember me",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Urbanist_semiBold",
                      color: notifire.textcolore),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fifthPage() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.completeYourProfile,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_bold",
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppString.completeYourProfileNow,
                maxLines: 2,
                style: TextStyle(
                  color: notifire.textcolore,
                  fontFamily: "Urbanist_regular",
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Urbanist_semiBold",
                    color: notifire.textcolore),
              ),
            ),
            CommonTextfield(
              fieldController: fullNameController,
              onTap: () {},
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Urbanist_semiBold",
                    color: notifire.textcolore),
              ),
            ),
            CommonTextfield(
              fieldController: phoneNumController,
              onTap: () {},
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Date of Birth",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Urbanist_semiBold",
                    color: notifire.textcolore),
              ),
            ),
            TextField(
              controller: dateOfBirthController,
              readOnly: true,
              style: TextStyle(
                  fontFamily: "Urbanist_bold", color: notifire.textcolore),
              onTap: () async {
                var pickedDate = await showDatePicker(
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

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  print(formattedDate);

                  setState(() {
                    dateOfBirthController.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Image.asset(
                    AppAssets.calender,
                    color: AppColor.pinkColor,
                    height: height / 100,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.pinkColor,
                    width: 1.6,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.pinkColor,
                    width: 1.6,
                  ),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Country",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Urbanist_semiBold",
                    color: notifire.textcolore),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButton(
              dropdownColor: notifire.bgcolore,
              isExpanded: true,
              style: TextStyle(
                fontFamily: "Urbanist_bold",
                color: notifire.textcolore,
              ),
              underline: Container(
                height: 1.5,
                color: AppColor.pinkColor,
              ),
              // Initial Value
              value: countryValue,

              // Down Arrow Icon
              icon: Row(
                children: [
                  SizedBox(width: width / 40),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    color: AppColor.pinkColor,
                    size: 35,
                  ),
                ],
              ),

              // Array list of items
              items: countryList.map((String countryListItem) {
                return DropdownMenuItem(
                  value: countryListItem,
                  child: Row(
                    children: [
                      SizedBox(width: width / 50),
                      Text(
                        countryListItem,
                        style: TextStyle(fontSize: height / 60),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  countryValue = newValue!;
                });
              },
            ),
            SizedBox(
              height: height / 50,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isRemember = !isRemember;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: AppColor.pinkColor,
                      child: isRemember
                          ? Image.asset(
                              AppAssets.done,
                              height: height / 70,
                              width: height / 70,
                            )
                          : SizedBox(
                              height: height / 70,
                              width: height / 70,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Remember me",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Urbanist_semiBold",
                      color: notifire.textcolore),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
