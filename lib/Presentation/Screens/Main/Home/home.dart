import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medix/Data/Model/Home/doctor.dart';
import 'package:medix/Data/Model/Home/pharmacy.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Doctor_profile/doctor_profile.dart';
import 'package:medix/Presentation/Screens/Profile/Profile/profile_screen.dart';
import 'package:medix/Utils/theme_switcher.dart';
import '../../Profile/Drawer/drawer_controller.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Search/search_screen.dart';
import 'Compo/pharmacy.dart';
import 'Compo/popular_doctor.dart';
import 'Compo/services.dart';
import '../Shared/home_text_field.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Controller();

  final initTheme =
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.theme;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ThemeProvider(
        initTheme: initTheme,
        duration: const Duration(milliseconds: 300),
        builder: (_, myTheme) {
          var size2 = MediaQuery.of(context).size;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Theme.of(context).scaffoldBackgroundColor),
            child: Scaffold(
              body: homeMain(isLight, context, size2),
            ),
          );
        });
  }

  CustomScrollView homeMain(bool isLight, BuildContext context, Size size2) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            pinned: true,
            leadingWidth: 40.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgIcon(
                    'assets/Icons/menu.svg',
                    color: isLight ? null : ColorUtil.onLightSurface,
                  )),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: CircleAvatar(
                  backgroundColor: isLight
                      ? ColorUtil.primaryColor.withOpacity(.30)
                      : Colors.grey.shade300.withOpacity(0.2),
                  child: AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      duration: const Duration(milliseconds: 1000),
                      child: isLight
                          ? IconButton(
                              splashRadius: 24,
                              onPressed: () {
                                ThemeProviderInheritedWidget.of(context)!
                                    .themeController
                                    .toggleThem(false);
                              },
                              icon: Icon(
                                Icons.mode_night,
                                color: Colors.grey.shade100,
                              ))
                          : IconButton(
                              splashRadius: 24,
                              onPressed: () {
                                ThemeProviderInheritedWidget.of(context)!
                                    .themeController
                                    .toggleThem(true);
                              },
                              icon: const Icon(Icons.sunny),
                              color: Colors.white,
                            )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  NavigationUtil.to(context, const ProfileScreen());
                },
                child: Hero(
                  tag: 'Profile Hero',
                  child: CircleAvatar(
                    backgroundImage: const AssetImage(
                      'assets/Images/Temp/profile.png',
                    ),
                    backgroundColor: ColorUtil.primaryColor.withOpacity(.10),
                    radius: 20.r,
                  ),
                ),
              ),
              SizedBox(width: 20.w)
            ]),
        MyStickyHeader(
          pinned: true,
          expandedHeight: 72.h,
          height: 72.h,
          elevation: 3,
          child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 8.h, bottom: 12.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      NavigationUtil.to(context, const SearchScreen());
                    },
                    child: AbsorbPointer(
                      absorbing: true,
                      child: HomeTextField(
                          prefix: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 11.42.w),
                              child: SvgIcon(
                                'assets/Icons/Search.svg',
                                color: isLight
                                    ? Colors.black.withOpacity(.30)
                                    : ColorUtil.mediumTextColor,
                              )),
                          hint: 'Search'),
                    ),
                  )),
                ],
              )),
        ),
        SliverSizedBox(height: 10.h),
        const Services(),
        SliverSizedBox(height: 29.h),
        Pharmacy(onTap: (PharmacyModel value) {}),
        SliverSizedBox(height: 10.h),
        // PopularDoctor(onTap: (DoctorModel value) {
        //   NavigationUtil.to(context, const DoctorProfile());
        // }),
        SliverPadding(
            padding: EdgeInsets.only(
          bottom: size2.height * 0.050,
        ))
      ],
    );
  }
}

class BottomWrapper extends StatelessWidget {
  const BottomWrapper(
      {Key? key,
      required this.icon,
      this.activeTab = false,
      required this.text})
      : super(key: key);

  final IconData icon;
  final bool activeTab;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            children: [
              Icon(icon),
              Text(
                text,
                style: FontStyleUtilities.t2(
                    fontColor: activeTab
                        ? ColorUtil.primaryColor
                        : ColorUtil.lightTextColor,
                    fontWeight: FWT.semiBold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
