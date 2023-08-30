import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/utils/constant/app_assets.dart';
import 'package:resultizer/utils/constant/app_string.dart';

import '../../theme/themenotifer.dart';
import '../on_boarding/on_boarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  ColorNotifire notifire = ColorNotifire();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 4,
      ),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingView(),
            ),
            (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      body: Column(
        children: [
          SizedBox(
            height: height / 3,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.logoImage,
                  height: height / 10,
                ),
                // SizedBox(
                //   height: height / 30,
                // ),
                // Text(
                //   AppString.resultizer,
                //   style: TextStyle(
                //     fontSize: 48,
                //     fontFamily: "Urbanist_bold",
                //     color: notifire.textcolore,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  AppString.subResultizer,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Urbanist",
                    color: notifire.textcolore,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 120,
            width: 120,
            child: Lottie.asset("assets/animation_ll3a6kpe.json"),
          ),
          SizedBox(
            height: height / 15,
          ),
        ],
      ),
    );
  }
}
