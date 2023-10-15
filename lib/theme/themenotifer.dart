// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constant/app_assets.dart';
import 'colors.dart';

class ColorNotifire with ChangeNotifier {
  get getIsDark => isDark;
  get TextColorgreay => isDark ? coloreblack : colorewhite;


  get getdrwer => isDark ? coloredrwer : colorewhite;
  get background => isDark ? backgroundcolore : colorewhite;

  get bgcolore => isDark ? backgroundcolore : backgrounde;
  get reverseBgColore => isDark ? backgrounde : backgroundcolore;
  get search => isDark ? backgroundcolore1 : backgrounde;

  get textcolore => isDark ? colorewhite : coloreblack;
  get reverseTextColore => isDark ? coloreblack: colorewhite;
  get textcolorgray => isDark ? textcoloregreay : colorewhite;

  get containcolore1 => isDark ? containcolore : colorewhite;
  get getsecoundcontain => isDark ? secoundecpntain : colorewhite;

  get deercolore => isDark ? drowercolore : const Color(0xffF0EFFC);
  get drwetextcode => isDark ? const Color(0xffFFFFFF) :  const Color(0xff5648DF);
  
  get borercolour => isDark ? const Color(0xff35383F) : const Color(0xffEEEEEE);
  get insidecolor => isDark ? const Color(0xff1F222A) : const Color(0xffFAFAFA);
  get image => isDark ? Image.asset(AppAssets.video) : Image.asset(AppAssets.video1);

  bool _isDark = false;
  bool get isDark => _isDark;

  void isavalable(bool value) {
    _isDark = value;
    notifyListeners();
  }
}