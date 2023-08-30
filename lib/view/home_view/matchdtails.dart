// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';

class Matchdetail extends StatefulWidget {
  const Matchdetail({super.key});

  @override
  State<Matchdetail> createState() => _MatchdetailState();
}

class _MatchdetailState extends State<Matchdetail> {
  ColorNotifire notifire = ColorNotifire();
  int index = 0;
  int selectIndex = 0;
  List text = [
    'Info',
    'Summary',
    'Report',
    'Stats',
    'Line-Ups',
    'Table',
    'H2H',
  ];
  List<Color> colors = [
    const Color(0xffF75555),
    const Color(0xffF75555),
    const Color(0xffF75555),
    const Color(0xff12D18E),
    const Color(0xffF75555),
  ];
  List<Color> colors1 = [
    const Color(0xff12D18E),
    const Color(0xffF75555),
    const Color(0xff12D18E),
    const Color(0xff12D18E),
    const Color(0xff12D18E),
  ];
  List img = [
    AppAssets.follow2,
    AppAssets.follow2,
    AppAssets.chelsea,
  ];
  List score =[
    '0 - 2',
    '1 - 3',
    '0 - 1',
  ];
  List score1 =[
    '1 - 0',
    '2 - 0',
    '0 - 1',
  ];
  List img1 = [
    AppAssets.team1,
    AppAssets.follow3,
    AppAssets.follow4,
  ];
  List text1 = [
    'W',
    'L',
    'W',
    'W',
    'W',
  ];
  List text2 = [
    'L',
    'L',
    'L',
    'W',
    'L',
  ];
  List num = [
    '1',
    '4',
    '5',
  ];
  List pic = [
    'assets/images/pic1.png',
    'assets/images/pic2.png',
    'assets/images/pic3.png',
  ];
  List num1 = [
    '2',
    '6',
    '2',
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,

    );
  }
  Widget secoundrow({required String img,required String txt1}){
    return Row(
      children: [
        Image(image: AssetImage(img),height: 24,width: 24),
        SizedBox(width: 10,),
        Flexible(child: Text(txt1, style:  TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 16, color: notifire.textcolore), overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
