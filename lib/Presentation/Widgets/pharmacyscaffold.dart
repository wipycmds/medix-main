import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/Main/Home/Compo/bottomnav.dart';
import 'package:medix/Presentation/Widgets/sliver_bar.dart';
import 'dart:math' as math;
import 'package:medix/Utils/font_style.dart';
import 'package:medix/Utils/navigation_util.dart';

import '../../Utils/color_utils.dart';
import '../Screens/Main/Home/Compo/end_drawer.dart';
import '../Screens/shopping/shopping.dart';
import 'svg_icon.dart';

class PharmacyScaffold extends StatefulWidget {
  final String? nextText;

  final Widget? button;
  final GlobalKey<ScaffoldState> scaffkey;
  final Widget child;

  const PharmacyScaffold(
      {Key? key,
      this.nextText,
      this.button,
      required this.scaffkey,
      required this.child})
      : super(key: key);

  @override
  State<PharmacyScaffold> createState() => _PharmacyScaffoldState();
}

class _PharmacyScaffoldState extends State<PharmacyScaffold> {
  @override
  Widget build(BuildContext context) {
    var of = MediaQuery.of(context);
    return Scaffold(
      key: widget.scaffkey,
      endDrawer: const HomeFilter(),
      body: CustomScrollView(
        slivers: [
          SliverBar(
            titleWidget: Text(
              'Online Pharmacy',
              style: FontStyleUtilities.h5(
                      fontColor: Colors.white, fontWeight: FWT.semiBold)
                  .copyWith(fontSize: 18.sp),
            ),
            expandedHeight: of.size.height * 0.186.h - of.viewPadding.top,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNav(
                                index: 0,
                              )),
                      (route) => false);
                  NavigationUtil.to(
                      context,
                      const BottomNav(
                        index: 1,
                      ));
                },
                child: Padding(
                    padding: EdgeInsets.only(
                      left: 11.42.w,
                      right: 11.42.w,
                    ),
                    child: SvgIcon(
                      'assets/Icons/Home.svg',
                      width: 23.w,
                      height: 23.h,
                      color: ColorUtil.surfaceLight,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigationUtil.to(context, const ShoppingScreen());
                },
                child: Padding(
                    padding: EdgeInsets.only(
                      left: 11.42.w,
                      right: 11.42.w,
                    ),
                    child: const SvgIcon(
                      'assets/Icons/bag.svg',
                      color: ColorUtil.surfaceLight,
                    )),
              ),
              SizedBox(
                width: 15.w,
              )
            ],
            bottomHeight: 44.h,
            mainChild: Positioned(
              bottom: 25.h,
              left: 24.w,
              child: Row(
                children: [
                  Text(
                    'Online Pharmacy',
                    style: FontStyleUtilities.t4(
                      fontColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const ForwardButton(),
                  Text(
                    'Prescription Drugs',
                    style: FontStyleUtilities.t4(
                      fontColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  widget.button ?? const SizedBox(),
                  Text(
                    widget.nextText ?? '',
                    style: FontStyleUtilities.t4(
                      fontColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r)),
          ),
          SliverToBoxAdapter(child: widget.child)
        ],
      ),
    );
  }
}

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -math.pi,
        child: Padding(
          padding:
              EdgeInsets.only(left: 8.w, top: 12.h, bottom: 12.h, right: 10),
          child: SizedBox(
              height: 8.h,
              width: 10.w,
              child: SvgIcon(
                'assets/Icons/arrow_back.svg',
                color: Colors.white.withOpacity(0.7),
              )),
        ));
  }
}
