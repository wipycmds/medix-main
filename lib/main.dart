import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/Pre_auth/on_boarding/splash.dart';
import 'package:medix/Utils/utils.dart';
import 'Utils/theme_switcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important!
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // BEFORE runApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => ThemeSwitcher(
            buildController: () => ThemeController(),
            builder: (context, controller) => ThemeProviderInheritedWidget(
                  themeController: controller,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'LUVMED',
                    theme: AppTheme.theme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode:
                        controller.isLight ? ThemeMode.light : ThemeMode.dark,
                    home: const SplashScreen(),
                  ),
                )));
  }
}
