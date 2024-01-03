import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_bottom_sheet.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/common/common_textfild.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/app_session.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/auth/data/datasources/auth_datasource.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/features/bottom_navigation_bar/bottonnavigation.dart';
import 'package:resultizer_merged/view/follow_team/follow_team.dart';
import 'package:resultizer_merged/view/forget_password/forget_pass/forget_password_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  bool isObscureText = false;
  bool isDone = false;
  bool isLoading = false;
  final AuthDatasource authDatasource = FirebaseAuthDatasource();

  showErrorSnack(message) {
    showSnack(context, message, Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      resizeToAvoidBottomInset: true,
      bottomSheet: CommonBottomSheet(
        buttonName: AppString.signIn,
        onTap: () async {
          try {
            UserModel user = await authDatasource.signUpWithEmail(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              username: usernameController.text.trim(),
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
            );
            if (user.id.isNotEmpty) {
              GlobalDataSource.userData = user;
              AppSession.saveItem('userData', GlobalDataSource.userData.toMap());
              Get.offAll(const Bottom());
            }
            else {
              showErrorSnack('Sign up failed, please try again.');
            }
            // Get.offAll(const Bottom());
          } catch (e, stackTrace) {
            showErrorSnack('Error during sign up');
            print("Error during signup: $e,");
            // print(stackTrace);
            // Handle the error (show an error message on screen or something similar)
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            height: height,
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
                          "Username",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Urbanist_semiBold",
                              color: notifire.textcolore),
                        ),
                      ),
                      CommonTextfield(
                        fieldController: usernameController,
                        onTap: () {},
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "First Name",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Urbanist_semiBold",
                              color: notifire.textcolore),
                        ),
                      ),
                      CommonTextfield(
                        fieldController: firstNameController,
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
                          "Last Name",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Urbanist_semiBold",
                              color: notifire.textcolore),
                        ),
                      ),
                      CommonTextfield(
                        fieldController: lastNameController,
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
                    ],
                  ),
                ),
              ],
            ),
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
