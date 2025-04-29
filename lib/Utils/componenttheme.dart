import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_utils.dart';

class ComponentTheme {
  ///LIGHT DIVIDER
  const ComponentTheme._();

  static final AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    backgroundColor: ColorUtil.scaffoldDark,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      height: 28 / 20,
      letterSpacing: .38,
      color: Colors.white.withOpacity(.85),
    ),
    centerTitle: true,
  );

  static final InputDecorationTheme darkInputDecorationThem =
      InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: 16.w),
          hintStyle: TextStyle(
              fontSize: 17.sp, color: const Color(0xff5B5F6F), height: 24 / 17),
          filled: true,
          fillColor: ColorUtil.surfaceDark,
          border: _baseBorder,
          enabledBorder: _baseBorder,
          focusedBorder: _focusedBorder);

  static final InputDecorationTheme lightInputDecorationThem =
      InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: 16.w),
          hintStyle: TextStyle(
              fontSize: 17.sp, color: const Color(0xffFFFFFF), height: 24 / 17),
          filled: true,
          fillColor: const Color(0xffFFFFFF),
          border: _baseBorder,
          enabledBorder: _baseBorder,
          focusedBorder: _focusedBorder);

  static final OutlineInputBorder _baseBorder = OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(4.r));

  static final UnderlineInputBorder _focusedBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: const BorderSide(
        color: ColorUtil.primaryColor,
      ));
}
