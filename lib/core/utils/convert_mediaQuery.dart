library convertMediaQuery;

import 'package:flutter/cupertino.dart';


class ConvertToMediaQuery {
  static double convertFontSizeToMediaQuery(double fontSize, BuildContext context) {
    double numMediaQuery = fontSize / 685.71;
    double fontSizeInMediaQuery =
        MediaQuery.of(context).size.height * numMediaQuery;
    return fontSizeInMediaQuery;
  }

  static double convertWidthToMediaQuery(double width, BuildContext context) {
    double numMediaQuery = width / 333.33;
    double widthInMediaQuery =
        MediaQuery.of(context).size.width * numMediaQuery;
    return widthInMediaQuery;
  }

  static double convertHeightToMediaQuery(double height, BuildContext context) {
    double numMediaQuery = height / 666.66;
    double heightInMediaQuery =
        MediaQuery.of(context).size.height * numMediaQuery;
    return heightInMediaQuery;
  }
}


// class ConvertToMediaQuery {
//   static double convertFontSizeToMediaQuery(double fontSize, BuildContext context) {
//     double numMediaQuery = fontSize / 685.71;
//     double fontSizeInMediaQuery =
//         MediaQuery.of(context).size.height * numMediaQuery;
//     return fontSizeInMediaQuery;
//   }

//   static double convertWidthToMediaQuery(double width, BuildContext context) {
//     double numMediaQuery = width / 333.33;
//     double widthInMediaQuery =
//         MediaQuery.of(context).size.width * numMediaQuery;
//     return widthInMediaQuery;
//   }

//   static double convertHeightToMediaQuery(double height, BuildContext context) {
//     double numMediaQuery = height / 666.66;
//     double heightInMediaQuery =
//         MediaQuery.of(context).size.height * numMediaQuery;
//     return heightInMediaQuery;
//   }
// }
