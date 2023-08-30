import 'package:flutter/material.dart';
import 'package:resultizer/utils/constant/app_color.dart';

class CommonButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  final String? buttonName;
  final bool? isShadow;
  final VoidCallback? onTap;

  const CommonButton(
      {Key? key,
      this.height,
      this.width,
      this.color,
      this.textColor,
      this.buttonName = "Login",
      this.isShadow,
      this.onTap})
      : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? double.infinity,
        clipBehavior: Clip.antiAlias,
        height: widget.height ?? height / 18,
        decoration: BoxDecoration(
          color: widget.color ?? AppColor.pinkColor,
          borderRadius: BorderRadius.circular(35),
          boxShadow: widget.isShadow == true
              ? [
                  BoxShadow(
                    color: AppColor.pinkColor.withOpacity(0.25),
                    blurRadius: 24,
                    offset: const Offset(4, 8),
                  )
                ]
              : [],
        ),
        child: Center(
          child: Text(
            widget.buttonName.toString(),
            style: TextStyle(
              fontFamily: "Urbanist_bold",
              fontSize: 14,
              color: widget.textColor ?? Colors.pink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
