import 'package:flutter/material.dart';

class AppColor {
  static const Color blackColor = Color(0xff212121);
  static const Color pinkColor = Color(0xff62208D);
  static const Color greyColor = Color(0xffEEEEEE);
  static const Color babyPinkColor = Color(0xffFDE7F3);
  static const Color offWhite = Color(0xffF5F5F5);
  static const Color hintTextColor = Color(0xffBDBDBD);
  static const Color greyscale = Color(0xff616161);
  static const Color purple = Color(0xff673AB3);
  static const Color secondary = Color(0xff4C0033);
  static const Color yellow = Color(0xffFACC15);
  static const Color primary = Color(0xffFDE7F3);
  static const Color patter = Color(0xff2F0D3A);
}


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  // String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
  //     '${alpha.toRadixString(16).padLeft(2, '0')}'
  //     '${red.toRadixString(16).padLeft(2, '0')}'
  //     '${green.toRadixString(16).padLeft(2, '0')}'
  //     '${blue.toRadixString(16).padLeft(2, '0')}';

  String toHex() {
  String hex = value.toRadixString(16);
  // The color.value returns the color as an integer.
  // We use toRadixString(16) to convert it to a hexadecimal string.
  // The value may not include leading zeros, so you may want to pad it.
  while (hex.length < 8) {
    hex = '0$hex';
  }
  return '#${hex.toUpperCase()}'; // Add '#' and convert to uppercase for the standard hex format.
}
}