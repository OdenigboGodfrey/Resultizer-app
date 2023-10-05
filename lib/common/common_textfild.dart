import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? fieldController;
  final String? fieldName;
  final TextCapitalization? textCapitalization;
  final String? hint;
  final TextInputType? fieldInputType;
  final bool? enabled;
  final Color? bgColor;
  final int? maxLine;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSaved;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double? contentpadding;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final double? cursorHeight;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatter;
  final bool? autofocus;
  final bool? readOnly;
  final Color? cursorColors;
  final String? hintText;
  // final MaxLengthEnforcement? maxLengthEnforcement;

  const CustomTextfield({
    Key? key,
    this.fieldName,
    this.textCapitalization,
    this.bgColor,
    this.fieldController,
    this.fieldInputType,
    this.enabled,
    this.maxLine,
    this.maxLength,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.autofocus,
    this.contentpadding,
    this.cursorColor,
    this.cursorHeight,
    this.errorText,
    this.hint,
    this.hintStyle,
    this.inputFormatter,
    this.obscureText,
    this.onChange,
    this.onSaved,
    this.onTap,
    this.readOnly,
    this.cursorColors,
    this.hintText,
    // this.maxLengthEnforcement,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: widget.cursorColor ?? AppColor.pinkColor,
      controller: widget.fieldController,
      inputFormatters: widget.inputFormatter,
      validator: widget.validator,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly ?? false,
      obscureText: widget.obscureText ?? false,
      textInputAction: TextInputAction.next,
      keyboardType: widget.fieldInputType ?? TextInputType.text,
      decoration: InputDecoration(
          hintText: widget.hintText ?? " ",
          isDense: true,
          filled: true,
          fillColor: AppColor.offWhite,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          hintStyle: widget.hintStyle,
          labelText: widget.hint,
          labelStyle: const TextStyle(color: AppColor.greyColor),
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 60,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16),
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: CustomColors.grey),
          //   borderRadius: BorderRadius.circular(16),
          // ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}

class CommonTextfield extends StatefulWidget {
  final TextEditingController? fieldController;
  final String? fieldName;
  final TextCapitalization? textCapitalization;
  final String? hint;
  final TextInputType? fieldInputType;
  final bool? enabled;
  final Color? bgColor;
  final int? maxLine;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSaved;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double? contentpadding;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final double? cursorHeight;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatter;
  final bool? autofocus;
  final bool? readOnly;
  final Color? cursorColors;
  final String? hintText;

  const CommonTextfield(
      {Key? key,
      this.fieldName,
      this.textCapitalization,
      this.hint,
      this.fieldInputType,
      this.enabled,
      this.bgColor,
      this.maxLine,
      this.maxLength,
      this.validator,
      this.onChange,
      this.onSaved,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText,
      this.contentpadding,
      this.cursorColor,
      this.hintStyle,
      this.cursorHeight,
      this.errorText,
      this.inputFormatter,
      this.autofocus,
      this.readOnly,
      this.cursorColors,
      this.hintText,
      this.fieldController})
      : super(key: key);

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontFamily: "Urbanist_bold",
          fontSize: 14,
          color: notifire.textcolore),
      controller: widget.fieldController,
      obscureText: widget.obscureText ?? false,
      textInputAction: TextInputAction.next,
      keyboardType: widget.fieldInputType ?? TextInputType.text,
      inputFormatters: widget.inputFormatter,
      validator: widget.validator,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly ?? false,
      cursorColor: widget.cursorColor ?? AppColor.pinkColor,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.pinkColor,
            width: 1.8,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.pinkColor,
            width: 1.8,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

Widget search({required String text, required String image}) {
  return TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15),
        child: Image.asset(image, color: notifire.textcolore),
      ),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      hintText: text,
      hintStyle: TextStyle(
          fontFamily: 'Urbanist_regular',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: notifire.textcolore),
    ),
  );
}
