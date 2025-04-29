import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTextField extends StatelessWidget {
  final String hint;
  final double? maxHeight;
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Widget? prefix, suffix;
  final bool? isObs;
  const HomeTextField({
    Key? key,
    required this.hint,
    this.maxHeight,
    this.maxLines = 1,
    this.controller,
    this.onSubmitted,
    this.validator,
    this.prefix,
    this.suffix,
    this.isObs = false,
  }) : super(key: key);

  static final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9.r), borderSide: BorderSide.none);
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
            fillColor:
                isLight ? const Color(0xffFFFFFF) : ColorUtil.surfaceDark,
            filled: true,
            hintMaxLines: maxLines,
            contentPadding: const EdgeInsets.only(right: 10, top: 15, left: 15),
            hintText: hint,
            hintStyle: FontStyleUtilities.h6(
                height: 1.53, fontColor: const Color(0xffABABAB)),
            border: _border,
            enabledBorder: _border.copyWith(
                borderSide: BorderSide(color: Colors.black.withOpacity(.05))),
            focusedBorder: _border.copyWith(
                borderSide: const BorderSide(
                    color: ColorUtil.primaryColor, width: 1))));
  }
}
