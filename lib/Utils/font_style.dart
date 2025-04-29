///FRAME WORK IMPORT..
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///WE HAVE CONFIGURED THIS CLASS WITH COLOR INHERITANCE OF THE APP NOW IT NOT
///DEPENDS UPON LOCALLY DEFINED COLORS...

/// THIS ENUM IS USED TO MANAGE FONT_WEIGHT...
enum FWT { light, regular, medium, semiBold, bold, extrabold }

enum FF { poppins, sans }

/// THIS CLASS IS USED TO MANAGE FONT_STYLES USED IN THE APPLICATION...
class FontStyleUtilities {
  /// THIS FUNCTION RETURNS FONT_WEIGHT ACCORDING TO USER REQUIREMENT(FROM ENUM)...
  static FontWeight getFontWeight({FWT? fontWeight = FWT.semiBold}) {
    switch (fontWeight) {
      case FWT.extrabold:
        return FontWeight.w800;
      case FWT.bold:
        return FontWeight.w700;
      case FWT.semiBold:
        return FontWeight.w600;
      case FWT.medium:
        return FontWeight.w500;
      case FWT.regular:
        return FontWeight.w400;
      case FWT.light:
        return FontWeight.w300;
      default:
        return FontWeight.w400;
    }
  }

  ///THIS FUNCTION RETURNS FONT_FAMILY ....
  static String getFontFamily({FF? fontFamily = FF.sans}) {
    switch (fontFamily) {
      case FF.poppins:
        return "Poppins";
      case FF.sans:
        return "DM";
      default:
        return 'DM';
    }
  }

  /// FONT_STYLE FOR FONT SIZE 34
  static TextStyle h1({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 34.sp,
    );
  }

  static TextStyle h32({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 32.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 30
  static TextStyle h2({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 30.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 24
  static TextStyle h3({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 24.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 20
  static TextStyle h4({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 20.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 17
  static TextStyle h5({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 17.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 16
  static TextStyle h6({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 16.4.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 15
  static TextStyle t1({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    bool isLineThrough = false,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 15.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 14
  static TextStyle t2({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    bool isLineThrough = false,
    double? letterSpacing,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      letterSpacing: letterSpacing ?? 0,
      fontFamily: "TT Commons",
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 13
  static TextStyle t3({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 13.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 12
  static TextStyle t4({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    double? letterSpacing,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      letterSpacing: letterSpacing,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 12.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 11
  static TextStyle t5({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    bool isLineThrough = false,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 11.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 14
  static TextStyle l1({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 14
  static TextStyle p1({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 13
  static TextStyle p2({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 13.sp,
    );
  }

  /// FONT_STYLE FOR FONT SIZE 12
  static TextStyle p3({
    Color? fontColor,
    double? height,
    FF? fontFamily,
    FWT? fontWeight = FWT.regular,
  }) {
    return TextStyle(
      height: height ?? 1.53,
      fontFamily: "TT Commons",
      color: fontColor ?? Colors.black,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 12.sp,
    );
  }
}
