import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/utils/constant/app_assets.dart';

import '../../theme/themenotifer.dart';

class Playerprofile extends StatefulWidget {
  const Playerprofile({super.key});

  @override
  State<Playerprofile> createState() => _PlayerprofileState();
}

class _PlayerprofileState extends State<Playerprofile> {
  ColorNotifire notifire = ColorNotifire();
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: notifire.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios_new, color: notifire.textcolore, size: 24)),
        centerTitle: true,
        title: Text("Profile", style: TextStyle(fontFamily: 'Urbanist_semibold', fontWeight: FontWeight.w600, fontSize: 17, color: notifire.textcolore)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                   Column(
                     children: [
                       Image.asset(AppAssets.profilepic),
                       SizedBox(height: 700,width: Get.width,),
                     ],
                   ),
                   Container(
                     height: 720,
                     decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: notifire.background,
                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           const SizedBox(height: 100,),
                           Text("About", style: TextStyle(fontFamily: 'Urbanist_semibold', fontWeight: FontWeight.w600, fontSize: 17, color: notifire.textcolore),),
                           const SizedBox(height: 10,),
                           Text("Aguero is a Brazilian professional footballer & captains the Brazil national, Considered one of the greatest defenders of all time", style: TextStyle(fontFamily: 'Urbanist_regular', fontWeight: FontWeight.w400, fontSize: 15, color: notifire.textcolore),),
                           const SizedBox(height: 20,),
                           Row(
                             children: [
                               Image.asset(AppAssets.footballground, height: 290,),
                               const Expanded(child: SizedBox(width: 40,)),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   profile(text: 'Full name', text1: 'Sergio Aguero'),
                                   const SizedBox(height: 20,),
                                   profile(text: 'Place of birth', text1: 'Buenos Aires'),
                                   const SizedBox(height: 20,),
                                   profile(text: 'Date of birth', text1: '2 June 1988'),
                                   const SizedBox(height: 20,),
                                   profile(text: 'Height', text1: '1.73 m'),
                                 ],
                               ),
                               const Expanded(child: SizedBox(width: 20,)),
                             ],
                           ),
                           Container(
                             height: 165,
                             width: Get.width,
                             margin: const EdgeInsets.only(top: 20),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15),
                               color: notifire.insidecolor,
                               border: Border.all(color: notifire.borercolour, width: 1),
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(30),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('Statistics', style: TextStyle(fontFamily: 'Urbanist_semibold', fontWeight: FontWeight.w600, fontSize: 17, color: notifire.textcolore),),
                                   const SizedBox(height: 15,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       statis(stattxt: 'Total Passes', statno: '66'),
                                       statis(stattxt: 'Success Passes', statno: '69'),
                                       statis(stattxt: 'Passes per', statno: '59'),
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
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 180,
                    child: Container(
                      height: 147,
                      width: 315,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xff4C0033),
                        image: const DecorationImage(image: AssetImage('assets/images/backgroud.png'), fit: BoxFit.cover)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Sergio Aguero', style: TextStyle(fontFamily: 'Urbanist_bold', fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),),
                            Row(
                              children: [
                                Image.asset('assets/images/jersey.png', height: 12, width: 12,),
                                const SizedBox(width: 10,),
                                const Text('Defender/midfielder', style: TextStyle(fontFamily: 'Urbanist_bold', fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey),),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text('Age', style: TextStyle(fontFamily: 'Urbanist_regular', fontWeight: FontWeight.w400, fontSize: 11, color: Colors.grey),),
                                      Text('35', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('World Cup Match', style: TextStyle(fontFamily: 'Urbanist_regular', fontWeight: FontWeight.w400, fontSize: 11, color: Colors.grey),),
                                      Text('15', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Goals', style: TextStyle(fontFamily: 'Urbanist_regular', fontWeight: FontWeight.w400, fontSize: 11, color: Colors.grey),),
                                      Text('9', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Assists', style: TextStyle(fontFamily: 'Urbanist_regular', fontWeight: FontWeight.w400, fontSize: 11, color: Colors.grey),),
                                      Text('2', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget profile({required String text, required String text1}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: TextStyle(fontFamily: 'Urbanist_regular', fontWeight: FontWeight.w400, fontSize: 15, color: notifire.textcolore),),
        const SizedBox(height: 10,),
        Text(text1, style: TextStyle(fontFamily: 'Urbanist_semibold', fontWeight: FontWeight.w600, fontSize: 15, color: notifire.textcolore),),
      ],
    );
  }
  Widget statis({required String stattxt, required String statno}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stattxt, style: TextStyle(fontFamily: 'Urbanist_regular', fontWeight: FontWeight.w400, fontSize: 15, color: notifire.textcolore),),
        const SizedBox(height: 10,),
        Text(statno, style: TextStyle(fontFamily: 'Urbanist_semibold', fontWeight: FontWeight.w600, fontSize: 22, color: notifire.textcolore),),
      ],
    );
  }
}
