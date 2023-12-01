import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_bottom_sheet.dart';
import 'package:resultizer_merged/common/common_textfild.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:resultizer_merged/features/auth/presentation/screens/forget_password_view.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/view/forget_password/otp_view/otp_view.dart';


class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    if (emailController.text.isEmpty) {
      showSnack(context, 'Please provide an email address', Colors.red);
      return;
    }
    final authCubit = BlocProvider.of<AuthCubit>(context);
    var result = await authCubit.resetPassword(emailController.text.toLowerCase().trim());
    if (result) {
      showSnack(context, 'Password reset email sent.', Colors.green);
    } else {
      showSnack(context, 'Please try again, password reset failed', Colors.red);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      resizeToAvoidBottomInset: false,
      bottomSheet: CommonBottomSheet(
        buttonName: AppString.sendReset,
        onTap: () {
          resetPassword();
          // Get.offAll(const OtpView());
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
