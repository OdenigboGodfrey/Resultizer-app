import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/features/auth/presentation/screens/sign_in_view.dart';
import 'package:resultizer_merged/features/auth/presentation/screens/sign_up_view.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/utils/model/on_bording.dart';


class OnBoardingScreenView extends StatefulWidget {
  const OnBoardingScreenView({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreenView> createState() => _OnBoardingScreenViewState();
}

class _OnBoardingScreenViewState extends State<OnBoardingScreenView> {
  ColorNotifire notifire = ColorNotifire();
  int currentIndex = 0;
  List<OnBoardingModel> item = [
    OnBoardingModel(
        image: AppAssets.onbording,
        title: AppString.welCome,
        subTitle: AppString.onbondingSubTitle),
    OnBoardingModel(
        image: AppAssets.onbording1,
        title: AppString.welCome1,
        subTitle: AppString.onbondingSubTitle1),
    OnBoardingModel(
        image: AppAssets.onbording2,
        title: AppString.welCome2,
        subTitle: AppString.onbondingSubTitle2),
    OnBoardingModel(
        image: AppAssets.onbording3,
        title: AppString.welCome3,
        subTitle: AppString.onbondingSubTitle3),
    OnBoardingModel(
        image: AppAssets.onbording4,
        title: AppString.welCome4,
        subTitle: AppString.onbondingSubTitle4),
  ];

   _navigateToSignIn() async {
    await Future.delayed(
        const Duration(seconds: 3)); // 3 seconds delay for splash
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                 const SignInView())); // Navigates to another page after splash
  }


  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: notifire.bgcolore,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: CarouselSlider.builder(
                  itemCount: item.length,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    initialPage: 0,
                    height: height / 1.5,
                    enableInfiniteScroll: false,
                  ),
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            item[itemIndex].image.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          item[itemIndex].title.toString(),
                          style: const TextStyle(
                            fontSize: 30,
                            color: AppColor.pinkColor,
                            fontFamily: "Urbanist_bold",
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            item[itemIndex].subTitle.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: notifire.textcolore,
                              fontFamily: "Urbanist_medium",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      item.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: height / 100,
                            width: currentIndex == index
                                ? width / 20
                                : height / 100,
                            color: currentIndex == index
                                ? AppColor.pinkColor
                                : AppColor.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    onTap: () {
                      // Get.offAll(const FollowTeam());
                      Get.to(const SignUpView());
                    },
                    buttonName: AppString.getStarted,
                    isShadow: true,
                    textColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    textColor: AppColor.pinkColor,
                    buttonName: AppString.alreadyHaveAnAccount,
                    isShadow: false,
                    color: AppColor.babyPinkColor,
                    onTap: () {
                      _navigateToSignIn();
                      // Get.to(
                      //   const SignInView(),
                      // );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
