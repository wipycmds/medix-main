import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/utils.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final double? maxHeight;
  final int? maxLines;
  final bool isBorder;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? prefix, suffix;
  final bool? isObs;
  const MyTextField({
    Key? key,
    required this.hint,
    this.maxHeight,
    this.maxLines = 1,
    this.controller,
    this.enabled = true,
    this.onSubmitted,
    this.validator,
    this.prefix,
    this.isBorder = false,
    this.suffix,
    this.isObs = false, required bool obscureText,
  }) : super(key: key);
  final bool enabled;
  static final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none);
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return TextFormField(
        obscureText: isObs!,
        validator: validator,
        onFieldSubmitted: onSubmitted,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            filled: true,
            enabled: enabled,
            hintMaxLines: maxLines,
            contentPadding: const EdgeInsets.only(right: 10, top: 15, left: 15),
            hintText: hint,
            hintStyle: FontStyleUtilities.h6(
                height: 1.53, fontColor: const Color(0xffABABAB)),
            border: _border,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: isBorder
                    ? BorderSide(
                        width: 1.0,
                        color: isLight ? Colors.black12 : Colors.white12)
                    : BorderSide.none),
            // constraints: ,

            focusedBorder: _border.copyWith(
                borderSide: const BorderSide(
                    color: ColorUtil.primaryColor, width: 1))));
  }
}
