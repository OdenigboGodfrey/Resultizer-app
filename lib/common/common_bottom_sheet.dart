import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/common/common_button.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

import '../utils/constant/app_color.dart';
import '../utils/constant/app_string.dart';

class CommonBottomSheet extends StatefulWidget {
  final String? buttonName;
  final VoidCallback? onTap;
  const CommonBottomSheet({Key? key, this.buttonName, this.onTap})
      : super(key: key);

  @override
  State<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 22,
      ),
      color: notifire.bgcolore,
      child: CommonButton(
        color: AppColor.pinkColor,
        buttonName: widget.buttonName ?? AppString.signIn,
        textColor: Colors.white,
        onTap: widget.onTap,
        isShadow: true,
      ),
    );
  }
}
