import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/common/common_textfild.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/view/bottom_navigation_bar/bottonnavigation.dart';

import '../../common/common_bottom_sheet.dart';
import '../../theme/themenotifer.dart';
import '../../utils/constant/app_color.dart';
import '../forget_password/forget_pass/forget_password_view.dart';

class SignView extends StatefulWidget {
  const SignView({Key? key}) : super(key: key);

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscureText = false;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      resizeToAvoidBottomInset: false,
      bottomSheet: CommonBottomSheet(
        buttonName: AppString.signIn,
        onTap: () {
          Get.offAll(const Bottom());
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  AppAssets.backButton,
                  height: height / 50,
                  color: notifire.textcolore,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppString.helloThere,
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
                      height: 20,
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
                                  height: height / 100,
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
                      height: 20,
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
                                      height: height / 70, width: height / 70),
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAll(const ForgotPassword());
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: "Urbanist_bold",
                          fontSize: 18,
                          color: AppColor.pinkColor,
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
    );
  }

  Widget showBottomSheet() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 20,
        vertical: MediaQuery.of(context).size.height / 40,
      ),
      child: const CommonButton(
        color: AppColor.pinkColor,
        buttonName: AppString.signIn,
        textColor: Colors.white,
      ),
    );
  }
}
