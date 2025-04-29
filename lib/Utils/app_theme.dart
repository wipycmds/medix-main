import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medix/Utils/font_style.dart';
import 'app_scheme.dart';
import 'color_utils.dart';
import 'componenttheme.dart';
import 'material_color.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: MaterialAppColor.primaryColor),
      scaffoldBackgroundColor: const Color(0xffFBFBFD),
      primaryTextTheme: Typography(platform: TargetPlatform.android).black,
      textTheme: Typography(platform: TargetPlatform.android).black,
      inputDecorationTheme: ComponentTheme.lightInputDecorationThem,
      primarySwatch: Colors.blue,
      dividerColor: const Color.fromRGBO(242, 244, 245, 1),
      appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xffFBFBFD),
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          centerTitle: true,
          titleTextStyle: FontStyleUtilities.h3(fontWeight: FWT.medium)));

  static final ThemeData darkTheme = ThemeData(

      ///GENERAL CONFIG
      scaffoldBackgroundColor: ColorUtil.scaffoldDark,
      primaryColor: ColorUtil.primaryColor,
      colorScheme: AppColorScheme.darkScheme,
      primaryTextTheme: Typography(platform: TargetPlatform.android).white,
      textTheme: Typography(platform: TargetPlatform.android).white,
      indicatorColor: ColorUtil.primaryColor,
      tabBarTheme: TabBarTheme(
          unselectedLabelColor: ColorUtil.lightTextColor,
          labelColor: Colors.white),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: ColorUtil.primaryColor),
      dividerColor: Colors.white12,
      iconTheme: const IconThemeData(color: Colors.white),
      inputDecorationTheme: ComponentTheme.darkInputDecorationThem,
      appBarTheme: ComponentTheme.darkAppBarTheme,
      drawerTheme:
          const DrawerThemeData(backgroundColor: ColorUtil.scaffoldDark));
}
