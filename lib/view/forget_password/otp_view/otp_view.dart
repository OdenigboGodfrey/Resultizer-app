// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

import '../../../common/common_bottom_sheet.dart';
import '../../../theme/themenotifer.dart';
import '../../../utils/constant/app_color.dart';
import '../create_new_password/create_new_password_view.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController pinController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      bottomSheet: CommonBottomSheet(
        buttonName: AppString.continu,
        onTap: () {
          Get.offAll(const CreateNewPasswordView());
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
                        AppString.youGotMail,
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
                        AppString.weHaveSentThe,
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
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,

                      // width: width / 1.2,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        cursorColor: AppColor.pinkColor,
                        cursorHeight: 18,
                        enablePinAutofill: true,
                        keyboardType: TextInputType.number,
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 55,
                          fieldWidth: 55,
                          inactiveColor: AppColor.offWhite,
                          activeColor: AppColor.greyColor,
                          selectedColor: AppColor.pinkColor,
                          activeFillColor: AppColor.offWhite,
                          inactiveFillColor: AppColor.offWhite,
                          selectedFillColor: AppColor.babyPinkColor,
                          borderWidth: 0.5,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        controller: pinController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your otp';
                          }
                          return null;
                        },
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppString.didnReceiveEmail,
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
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppString.youCanResend,
                        maxLines: 2,
                        style: TextStyle(
                          color: notifire.textcolore,
                          fontFamily: "Urbanist_regular",
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
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
}
