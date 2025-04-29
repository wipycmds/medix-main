import 'package:flutter/material.dart';
import 'color_utils.dart';

///WE HAVE CONFIGURED THIS COLOR-SCHEME ACCORDING TO THE MATERIAL
///THEM GUIDELINES.
class AppColorScheme {
  const AppColorScheme._();
  static const ColorScheme lightScheme = ColorScheme(
      primary: ColorUtil.primaryColor,
      secondary: ColorUtil.primaryColor,
      surface: ColorUtil.scaffoldDark,
      error: ColorUtil.errorColor,
      onPrimary: ColorUtil.surfaceLight,
      onSecondary: ColorUtil.surfaceLight,
      onSurface: ColorUtil.onLightSurface,
      onError: ColorUtil.surfaceLight,
      brightness: Brightness.light);

  static const ColorScheme darkScheme = ColorScheme(
      primary: ColorUtil.scaffoldDark,
      secondary: ColorUtil.primaryColor,
      surface: ColorUtil.primaryColor,
      error: ColorUtil.errorColor,
      onPrimary: ColorUtil.surfaceLight,
      onSecondary: ColorUtil.surfaceLight,
      onSurface: Colors.white,
      onError: ColorUtil.surfaceLight,
      brightness: Brightness.dark);

  static ColorScheme getScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }
}
