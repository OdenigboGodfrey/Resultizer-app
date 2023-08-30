import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/view/forget_password/otp_view/otp_view.dart';

import '../../../common/common_bottom_sheet.dart';
import '../../../common/common_textfild.dart';
import '../../../theme/themenotifer.dart';
import '../../../utils/constant/app_assets.dart';
import '../../../utils/constant/app_string.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      resizeToAvoidBottomInset: false,
      bottomSheet: CommonBottomSheet(
        buttonName: AppString.continu,
        onTap: () {
          Get.offAll(const OtpView());
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
                        AppString.forgotPassword,
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
                        AppString.enterYourEmail,
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
