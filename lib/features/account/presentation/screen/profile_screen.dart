// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_textfild.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/app_session.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/account/domain/usecase/user_detail_usecase.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ColorNotifire notifire = ColorNotifire();

  User userData = GlobalDataSource.userData;

  // TextEditingController fullNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  //
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  late UserDetailCubit userDetailCubit;

  void updateUser() {
    var firstName = firstNameController.text.trim();
    var lastName = lastNameController.text.trim();
    var userName = usernameController.text.trim();
    if (firstName.isEmpty || lastName.isEmpty) {
      showSnack(context, 'Please fill all fields', Colors.red);
      return;
    }
    userDetailCubit = context.read<UserDetailCubit>();
    showSnack(context, 'Updating profile', Colors.amber);
    var fullName = '${firstName} ${lastName}';
    UserModel userModel = UserModel(
        email: userData.email,
        fullname: fullName,
        id: userData.id,
        username: userData.username,
        roles: userData.roles);
    userDetailCubit.updateUser(userModel).then((value) {
      if (value) {
        // ok
        showSnack(context, 'Profile updated', Colors.green);

        setState(() {
          userData = User(
              email: userModel.email,
              fullname: fullName,
              id: userModel.id,
              username: userModel.username,
              roles: GlobalDataSource.userData.roles);
          GlobalDataSource.userData = userData;
        });
      } else {
        // not okay
        showSnack(context, 'Profile failed to update.', Colors.red);
      }
    });
  }

  void updatePassword() {
    userDetailCubit = context.read<UserDetailCubit>();
    if (newPasswordController.text.trim() !=
        confirmNewPasswordController.text.trim()) {
      showSnack(
          context,
          "Passwords don't match, please check the new password and try again.",
          Colors.red);
      return;
    }
    showSnack(context, 'Updating password', Colors.blue);
    userDetailCubit
        .updatePassword(ChangePasswordParams(oldPasswordController.text.trim(),
            newPasswordController.text.trim()))
        .then((value) {
      if (value) {
        // ok
        showSnack(context, 'Password updated.', Colors.green);
      } else {
        // not okay
        showSnack(
            context,
            'Password failed to update, please verify old password is correct.',
            Colors.red);
      }

      setState(() {});
    });
  }

  Future<void> _pickImage() async {
    userDetailCubit = context.read<UserDetailCubit>();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      showSnack(context, 'Uploading image', Colors.blue);
      userDetailCubit
          .uploadImage(pickedFile!.path, pickedFile.path.split('.').last)
          .then((value) async {
        if (value.isNotEmpty) {
          // write to user account
          GlobalDataSource.userData.profileImageURL = value;
          var updateResult = await userDetailCubit
              .updateUser(UserModel.fromMap(GlobalDataSource.userData.toMap()))
              .catchError((onError) {
            print(onError);
          });
          if (updateResult) {
            AppSession.writeGlobalUserDataToLocal();
            showSnack(context, 'Image uploaded', Colors.green);
            setState(() {});
          } else {
            showSnack(
                context,
                'Something went wrong with image  upload, please try again later',
                Colors.red);
          }
        } else {
          showSnack(
              context,
              'Something went wrong with image  upload, please try again later',
              Colors.red);
        }
      }).catchError((onError) {
        print(onError);
        showSnack(context, 'Failed to upload image, please try again later',
            Colors.red);
      });
    } else {
      showSnack(context, 'Failed to select image', Colors.red);
    }
    // Handle the pickedFile (could be null if the user canceled)
    // You can set the picked image to a variable for further use.
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    List<String> name = userData.fullname!.split(' ');

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: notifire.bgcolore,
        appBar: AppBar(
          backgroundColor: notifire.bgcolore,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_sharp,
                color: notifire.textcolore,
              )),
          title: const Text("Personal Info"),
          titleTextStyle: TextStyle(
            fontFamily: "Urbanist_bold",
            color: notifire.textcolore,
            fontSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color(0xff673AB3),
                      borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(25),
                          bottomEnd: Radius.circular(25)),
                      image: DecorationImage(
                          image: AssetImage(AppAssets.matchcard),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    // top: 100,
                    bottom: -50,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          print('tapped');
                          _pickImage();
                        },
                        // child: ImageWithDefault(
                        //   imageUrl: GlobalDataSource.userData.profileImageURL,
                        //   height: 100,
                        //   width: 100,
                        // ),

                        // child: SizedBox(
                        //   width: 100,
                        //   height: 100,
                        //   child: ClipOval(
                        //       child: ImageWithDefault(
                        //           imageUrl:
                        //               GlobalDataSource.userData.profileImageURL,
                        //           width: 100,
                        //           height: 100,
                        //           fit: BoxFit.contain,
                        //         )),
                        // ),

                        // child: Image.asset(
                        //   'assets/images/Ellipse.png',
                        //   height: 100,
                        //   width: 100,
                        // ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: ImageWithDefault(
                            imageUrl: userData.profileImageURL!,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      left: 70,
                      bottom: -50,
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Image.asset(
                          'assets/images/Edit Square.png',
                          height: 20,
                          width: 20,
                        ),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListTile(
                  title: Center(
                      child: Text(
                    userData.fullname!,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Urbanist-semibold',
                        color: notifire.textcolore),
                    overflow: TextOverflow.ellipsis,
                  )),
                  subtitle: Center(
                      child: Text(
                    (userData.roles!.isNotEmpty
                        ? userData.roles!.join(',')
                        : ''),
                    style: TextStyle(
                        fontSize: 10,
                        color: notifire.textcolore,
                        fontFamily: 'Urbanist-regular'),
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Urbanist_bold',
                      fontWeight: FontWeight.w700),
                  dividerColor: notifire.background,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.pinkColor,
                  ),
                  tabs: const [
                    Tab(
                      text: 'Profile',
                    ),
                    Tab(
                      text: 'Password',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  height: Get.size.height * 0.8,
                  child: TabBarView(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "First Name",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Urbanist_bold",
                                    fontWeight: FontWeight.w700,
                                    color: notifire.textcolore),
                              ),
                            ),
                            CommonTextfield(
                              fieldController: firstNameController,
                              hintText: name.isNotEmpty ? name[0] : '',
                              onTap: () {},
                              validator: (value) {
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Last Name",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Urbanist_bold",
                                    fontWeight: FontWeight.w700,
                                    color: notifire.textcolore),
                              ),
                            ),
                            CommonTextfield(
                              fieldController: lastNameController,
                              hintText: name.isNotEmpty ? name[1] : '',
                              onTap: () {},
                              validator: (value) {
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                // save to fire store all selected
                                updateUser();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: AppColor.pinkColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.save_alt_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Update Profile',
                                      style: TextStyle(
                                        fontFamily: 'Urbanist_bold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Old Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Urbanist_bold",
                                    fontWeight: FontWeight.w700,
                                    color: notifire.textcolore),
                              ),
                            ),
                            CommonTextfield(
                              fieldController: oldPasswordController,
                              obscureText: true,
                              onTap: () {},
                              validator: (value) {
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "New Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Urbanist_bold",
                                    fontWeight: FontWeight.w700,
                                    color: notifire.textcolore),
                              ),
                            ),
                            CommonTextfield(
                              fieldController: newPasswordController,
                              obscureText: true,
                              onTap: () {},
                              validator: (value) {
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Confirm New Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Urbanist_bold",
                                    fontWeight: FontWeight.w700,
                                    color: notifire.textcolore),
                              ),
                            ),
                            CommonTextfield(
                              fieldController: confirmNewPasswordController,
                              obscureText: true,
                              onTap: () {},
                              validator: (value) {
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                updatePassword();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: AppColor.pinkColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.save_alt_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Change Password',
                                      style: TextStyle(
                                        fontFamily: 'Urbanist_bold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
