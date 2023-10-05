import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/view/bottom_navigation_bar/bottonnavigation.dart';

import '../../../common/common_bottom_sheet.dart';
import '../../../common/common_textfild.dart';
import '../../../theme/themenotifer.dart';
import '../../../utils/constant/app_assets.dart';
import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/app_string.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController createNewPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObscureText = false;
  bool isConfirmObscureText = false;
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
        buttonName: AppString.confirm,
        onTap: () {
          welComeDialog();
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
                  Get.back();
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
                        AppString.createNewPassword,
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
                        AppString.saveTheNew,
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
                        AppString.createANewpassword,
                        style: TextStyle(
                          color: notifire.textcolore,
                          fontSize: 15,
                          fontFamily: "Urbanist_semiBold",
                        ),
                      ),
                    ),
                    CommonTextfield(
                      fieldController: createNewPasswordController,
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
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppString.confirmaNewPassword,
                        style: TextStyle(
                          color: notifire.textcolore,
                          fontSize: 15,
                          fontFamily: "Urbanist_semiBold",
                        ),
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
                            debugPrint(
                                "isConfirmObscureText--- $isConfirmObscureText");
                          });
                        },
                        child: isConfirmObscureText
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
                        SizedBox(width: width / 30),
                        Text(
                          "Remember me",
                          style: TextStyle(
                            color: notifire.textcolore,
                            fontSize: 15,
                            fontFamily: "Urbanist_semiBold",
                          ),
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

  welComeDialog() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            titlePadding: const EdgeInsets.only(top: 25, left: 24, right: 24),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: notifire.bgcolore,
            title: Image.asset(
              AppAssets.welComePopupImage,
              height: height / 7,
              width: height / 7,
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: CommonButton(
                  buttonName: AppString.ok,
                  textColor: Colors.white,
                  onTap: () {
                    Get.offAll(const Bottom());
                  },
                ),
              ),
            ],
            content: Wrap(
              children: [
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppString.welComeBack,
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
                        AppString.passwordChangedSuccessfully,
                        style: TextStyle(
                          color: notifire.textcolore,
                          fontFamily: "Urbanist_regular",
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
