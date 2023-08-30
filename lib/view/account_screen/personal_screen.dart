// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/common_textfild.dart';
import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';
import '../../utils/constant/app_color.dart';

class ParsnalScreen extends StatefulWidget {
  const ParsnalScreen({super.key});

  @override
  State<ParsnalScreen> createState() => _ParsnalScreenState();
}

class _ParsnalScreenState extends State<ParsnalScreen> {
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
  List text1 = [
    'Appearances',
    'Goal',
    'Winner'
  ];
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

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
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
              child:  Icon(Icons.arrow_back_sharp, color: notifire.textcolore,)),
          title: const Text("Personal Info"),
          titleTextStyle: TextStyle(fontFamily: "Urbanist_bold", color: notifire.textcolore, fontSize: 20,),
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
                        borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(25), bottomEnd: Radius.circular(25)),
                      image: DecorationImage(image: AssetImage(AppAssets.matchcard),fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -50,
                      child: Image.asset('assets/images/Ellipse.png', height: 100, width: 100,),
                  ),
                  Positioned(
                    right: 0,
                    left: 70,
                    bottom: -50,
                    child: Image.asset('assets/images/Edit Square.png', height: 20,width: 20,),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60,),
                child: ListTile(
                  title: Center(
                      child: Text('Lionel Messi', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', color: notifire.textcolore), overflow: TextOverflow.ellipsis,)),
                  subtitle: Center(
                      child: Text('Footballer', style: TextStyle(fontSize: 10, color: notifire.textcolore, fontFamily: 'Urbanist-regular'), overflow: TextOverflow.ellipsis,)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700),
                  dividerColor: notifire.background,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.pinkColor,
                    ),
                    tabs: const [
                      Tab(text: 'Profile',),
                      Tab(text: 'Overview',),
                      Tab(text: 'Stats',),
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
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Full Name", style: TextStyle(fontSize: 16, fontFamily: "Urbanist_bold", fontWeight: FontWeight.w700, color: notifire.textcolore),),
                              ),
                              CommonTextfield(
                                fieldController: fullNameController,
                                onTap: () {},
                                validator: (value) {
                                  return null;
                                },
                              ),
                              const SizedBox(height: 40,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Phone Number", style: TextStyle(fontSize: 16, fontFamily: "Urbanist_bold", fontWeight: FontWeight.w700, color: notifire.textcolore),),
                              ),
                              CommonTextfield(
                                fieldController: phoneNumController,
                                onTap: () {},
                                validator: (value) {
                                  return null;
                                },
                              ),
                              const SizedBox(height: 40,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Date of Birth", style: TextStyle(fontSize: 16, fontFamily: "Urbanist_bold", fontWeight: FontWeight.w700, color: notifire.textcolore),),
                              ),
                              TextField(
                                controller: dateOfBirthController,
                                readOnly: true,
                                style: TextStyle(
                                  fontFamily: "Urbanist_bold",
                                  color: notifire.textcolore,
                                ),
                                onTap: () async {
                                  var pickedDate = await showDatePicker(
                                      context: context,
                                      builder: (context, child) {
                                        return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: const ColorScheme.light(
                                                  primary: AppColor.pinkColor,
                                                  onPrimary: Colors.white,
                                                  onSurface: AppColor.blackColor,
                                                  surface: Color(0xffFFFFFF)),
                                            ),
                                            child: child!);
                                      },
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    if (kDebugMode) {
                                      print(pickedDate);
                                    }
                                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                    if (kDebugMode) {
                                      print(formattedDate);
                                    }

                                    setState(() {
                                      dateOfBirthController.text = formattedDate;
                                    });
                                  } else {
                                    if (kDebugMode) {
                                      print("Date is not selected");
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Image.asset(AppAssets.calender, color: AppColor.pinkColor, height: 28,),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.pinkColor,
                                      width: 1.6,
                                    ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.pinkColor,
                                      width: 1.6,
                                    ),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Country", style: TextStyle(fontSize: 16, fontFamily: "Urbanist_bold", fontWeight: FontWeight.w700, color: notifire.textcolore),),
                              ),
                              const SizedBox(height: 15,),
                              DropdownButton(
                                dropdownColor: notifire.bgcolore,
                                isExpanded: true,
                                style: TextStyle(fontSize: 20, fontFamily: "Urbanist_bold", fontWeight: FontWeight.w700, color: notifire.textcolore),
                                underline: Container(height: 1.5, color: AppColor.pinkColor,),
                                // Initial Value
                                value: countryValue,
                                // Down Arrow Icon
                                icon: const Row(
                                  children: [
                                    SizedBox(width: 40),
                                    Icon(Icons.keyboard_arrow_down_outlined, color: AppColor.pinkColor, size: 35,),
                                  ],
                                ),

                                // Array list of items
                                items: countryList.map((String countryListItem) {
                                  return DropdownMenuItem(
                                    value: countryListItem,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(countryListItem, style: TextStyle(fontSize: 20, color: notifire.textcolore),),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    countryValue = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: 3,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey.withOpacity(0.15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(text[index], style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Urbanist_bold', fontSize: 18, color: notifire.textcolore),),
                                                  Text(text1[index], style:  TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Urbanist_medium', fontSize: 13, color: notifire.textcolore),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Text('PARSONAL DETAILS', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Urbanist_bold', fontSize: 18, color: notifire.textcolore),),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.only(top: 20),
                                shrinkWrap: true,
                                itemCount: leading.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(leading[index], style: const TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Urbanist_medium', fontSize: 15, color: Colors.grey),),
                                            Text(traling[index], style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Urbanist_medium', fontSize: 15, color: notifire.textcolore),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                              },)
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 320,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: notifire.bgcolore,
                                border: Border.all(color: notifire.borercolour, width: 1),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Match Stats', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Chelsea', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                        const Expanded(child: SizedBox(width: 20,)),
                                        Image.asset(AppAssets.chelsea, height: 40, width: 40,),
                                        const Expanded(child: SizedBox(width: 30,)),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.grey.withOpacity(0.25),
                                          ),
                                          child: Center(
                                            child: Text('vs', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                          ),
                                        ),
                                        const Expanded(child: SizedBox(width: 30,)),
                                        Image.asset(AppAssets.team1, height: 40, width: 40,),
                                        const Expanded(child: SizedBox(width: 20,)),
                                        Text('Arsenal', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                      ],
                                    ),
                                  ),
                                  Column(
                                     children: [
                                       stats(score: '6', target: 'Shots on target', score1: '3'),
                                       const SizedBox(height: 15,),
                                       stats(score: '53', target: 'Possession', score1: '3'),
                                       const SizedBox(height: 15,),
                                       stats(score: '766', target: 'Touches', score1: '45'),
                                       const SizedBox(height: 15,),
                                       stats(score: '565', target: 'Posses', score1: '40'),
                                       const SizedBox(height: 15,),
                                       stats(score: '4', target: 'Shots', score1: '3'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Container(
                              height: 320,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: notifire.bgcolore,
                                border: Border.all(color: notifire.borercolour, width: 1),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Top Player Stats', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Chelsea', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                        const Expanded(child: SizedBox(width: 20,)),
                                        Image.asset(AppAssets.chelsea, height: 40, width: 40,),
                                        const Expanded(child: SizedBox(width: 30,)),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.grey.withOpacity(0.25),
                                          ),
                                          child: Center(
                                            child: Text('vs', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                          ),
                                        ),
                                        const Expanded(child: SizedBox(width: 30,)),
                                        Image.asset(AppAssets.team1, height: 40, width: 40,),
                                        const Expanded(child: SizedBox(width: 20,)),
                                        Text('Arsenal', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, color: notifire.textcolore),),
                                      ],
                                    ),
                                  ),
                                  Column(
                                     children: [
                                       stats(score: '1', target: 'Goalkeeper', score1: '5'),
                                       const SizedBox(height: 15,),
                                       stats(score: 'White', target: 'Defenders', score1: 'White'),
                                       const SizedBox(height: 15,),
                                       stats(score: '7', target: 'Touches', score1: '45'),
                                       const SizedBox(height: 15,),
                                       stats(score: '565', target: 'Posses', score1: '40'),
                                       const SizedBox(height: 15,),
                                       stats(score: '4', target: 'Shots', score1: '3'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
  Widget stats({required String score, required String target,required String score1}){
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(50),
        1: FixedColumnWidth(150),
        2: FixedColumnWidth(50),
      },
      children: [
        TableRow(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(score, style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 15, color: notifire.textcolore),),
              ],
            ),
            Center(child: Text(target, style: TextStyle(fontFamily: 'Urbanist_medium', fontSize: 15, fontWeight: FontWeight.w500, color: notifire.textcolore),)),
            Text(score1, style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 15, color: notifire.textcolore),),
          ],
        ),
      ],
    );
  }
}