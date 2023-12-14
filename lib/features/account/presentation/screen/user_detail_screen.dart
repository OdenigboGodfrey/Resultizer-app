// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_textfild.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  ColorNotifire notifire = ColorNotifire();
  var countryList = [
    "India",
    "Malta",
    "United States of America",
    "Philippines"
  ];
  var items = [
    "India",
    "Malta",
    "Philippines",
    "United States of America",
  ];
  List text = [
    '212',
    '92',
    '13',
  ];
  List text1 = ['Appearances', 'Goal', 'Winner'];
  List leading = [
    'National team',
    'Country of birth',
    'Date of birth',
    'Age',
    'PL debut',
  ];
  List traling = [
    "Chelsea",
    "Chelsea",
    '13/05/1979',
    '41',
    'Jan 19, 2002',
  ];

  String dropvalue = "India";
  String countryValue = "India";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailSearchController = TextEditingController();
  List<String> selectedRoles = [];

  bool hasResult = false;
  bool isSearching = false;
  bool isAdmin = false;
  bool isTipster = false;

  late UserDetailCubit userDetailCubit;
  late UserModel userModel;

  void searchByEmail() {
    userDetailCubit = context.read<UserDetailCubit>();
    selectedRoles = [];
    hasResult = false;
    isSearching = true;
    userDetailCubit.fetchUserByEmail(emailSearchController.text.trim()).then((value) {
      isSearching = false;
      if (value!.email.isNotEmpty) {
        hasResult = true;
        userModel = value;
        selectedRoles = userModel.roles ?? [];
        var fullName = userModel.fullname!.split(' ');
        firstNameController.text = fullName[0];
        lastNameController.text  = fullName[1];
      }
      setState(() {});
    });
    setState(() {});
    // return true;
  }

  void updateRoles(String role) {
    if (selectedRoles.contains(role)) {
      selectedRoles.remove(role);
    } else {
      selectedRoles.add(role);
    }
    setState(() {});
    
    // hasResult = !hasResult;
    // return true;
  }

  void updateUser() {
    showSnack(context, 'Updating user detail', Colors.amber);
    userModel.roles = selectedRoles;
    userDetailCubit.updateUser(userModel).then((value) {
      if (value) {
        // ok
        showSnack(context, 'User detail updated', Colors.green);
      } else {
        // not okay
        showSnack(context, 'User detail failed to update', Colors.red);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return DefaultTabController(
      length: 3,
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
          title: const Text("Manage user"),
          titleTextStyle: TextStyle(
            fontFamily: "Urbanist_bold",
            color: notifire.textcolore,
            fontSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Search by email",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Urbanist_bold",
                                fontWeight: FontWeight.w700,
                                color: notifire.textcolore),
                          ),
                        ),
                        CommonTextfield(
                          fieldController: emailSearchController,
                          // readOnly: true,
                          onTap: () {},
                          validator: (value) {
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        // ElevatedButton(onPressed: () {}, child: Text('Search')),
                        GestureDetector(
                          onTap: () {
                            // save to fire store all selected
                            searchByEmail();
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
                                  Icons.search_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Search',
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
              const SizedBox(
                height: 40,
              ),
              if (hasResult)
                Column(
                  children: [
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
                          Tab(text: 'User Profile'),
                          Tab(text: 'Roles'),
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
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 20),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Urbanist_bold",
                                          fontWeight: FontWeight.w700,
                                          color: notifire.textcolore),
                                    ),
                                  ),
                                  CommonTextfield(
                                    fieldController: emailSearchController,
                                    readOnly: true,
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
                                    readOnly: true,
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
                                    readOnly: true,
                                    onTap: () {},
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Is Admin",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Urbanist_bold",
                                              fontWeight: FontWeight.w700,
                                              color: notifire.textcolore),
                                        ),
                                      ),
                                      Checkbox(
                                          value: userModel!.roles!.contains(AppString.admin),
                                          onChanged: (checked) {
                                            updateRoles(AppString.admin);
                                          }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Is Tipster",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Urbanist_bold",
                                              fontWeight: FontWeight.w700,
                                              color: notifire.textcolore),
                                        ),
                                      ),
                                      Checkbox(
                                          value: userModel!.roles!.contains(AppString.tipster),
                                          onChanged: (checked) {
                                            updateRoles(AppString.tipster);
                                          }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.save_alt_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Save',
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
              if (!hasResult && !isSearching)
                const Center(
                  child: Text('No User to show'),
                ),
              if (isSearching)
                const Center(
                    child: SizedBox(
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
