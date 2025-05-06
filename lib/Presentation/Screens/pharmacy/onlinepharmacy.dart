
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/Main/Search/search_screen.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/category.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/staggeredwrapper.dart';
import 'package:medix/Presentation/Screens/shopping/shopping.dart';
import 'package:medix/Presentation/Widgets/back_button.dart';
import 'package:medix/Presentation/Widgets/sliver_bar.dart';
import 'package:medix/Presentation/Widgets/svg_icon.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';
import 'package:medix/Utils/navigation_util.dart';

import '../../Widgets/rowwrapper.dart';
import '../Consultation_flow/audio_call_doctor/audio_call_doctor.dart';
import '../Profile/Drawer/drawer_controller.dart';
import '../Profile/Profile/profile_screen.dart';
import 'compo/category1.dart';

class OnlinePharmacy extends StatefulWidget {
  const OnlinePharmacy({Key? key, this.onIndexChanged}) : super(key: key);

  final ValueChanged<int>? onIndexChanged;

  @override
  State<OnlinePharmacy> createState() => _OnlinePharmacyState();
}

class _OnlinePharmacyState extends State<OnlinePharmacy> {
  late PageController controller;

  List pages = [0, 1, 2, 3];
  int pageIndicate = 0;
  IncreasingClockController timeController = IncreasingClockController()
    ..reset(seconds: 60, minutes: 34)
    ..setUpdecrementTimer();

  Color sliverColor = ColorUtil.primaryColor;
  late ScrollController scrollController;

  void changedIndex(int index) {
    widget.onIndexChanged!(index);
    setState(() {});
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels > 270) {
        sliverColor = ColorUtil.scaffoldDark;
        setState(() {});
      } else {
        sliverColor = ColorUtil.primaryColor;
        setState(() {});
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timeController.minutes = 34;
      timeController.seconds = 60;
    });
    controller = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  List image = ['drugs.svg', 'foods.svg', 'personalcare.svg'];

  @override
  Widget build(BuildContext context) {
    var size2 = MediaQuery.of(context).size;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                leading: MyBackButton(
                  color: Colors.white,
                  onTap: () {
                    currentIndex.value = 0;
                    setState(() {});
                    changedIndex(currentIndex.value);
                  },
                ),
                toolbarHeight: 61.h,
                collapsedHeight: 67.h,
                forceElevated: false,
                elevation: 0.0,
                scrolledUnderElevation: 0.0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        NavigationUtil.to(context,  ProfileScreen());
                      },
                      child: CircleAvatar(
                        radius: 16.r,
                        backgroundImage:
                            const AssetImage('assets/Images/Temp/profile.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  )
                ],
                backgroundColor: isLight ? ColorUtil.primaryColor : sliverColor,
                pinned: true,
                centerTitle: false,
                titleSpacing: 2,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location',
                        style: FontStyleUtilities.t3(
                            fontColor:
                                ColorUtil.surfaceLight.withOpacity(0.7))),
                    Text('35 St Martin’s St, West End',
                        style: FontStyleUtilities.t3(
                            fontWeight: FWT.semiBold, fontColor: Colors.white))
                  ],
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: currentIndex,
                  builder: (BuildContext context, int value, Widget? child) {
                    return SliverBar(
                        toolbarHeight: 0,
                        collapseHeight: 0,
                        isPinned: false,
                        widget: Positioned(
                          top: 0.h,
                          left: 20.w,
                          child: Container(
                            color: ColorUtil.primaryColor,
                            width: size2.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Online',
                                      style: FontStyleUtilities.h32(
                                          height: 1.1.h,
                                          fontWeight: FWT.semiBold,
                                          fontColor: ColorUtil.surfaceLight),
                                    ),
                                    Text(
                                      'Pharmacy',
                                      style: FontStyleUtilities.h32(
                                          fontWeight: FWT.semiBold,
                                          height: 1.2.h,
                                          fontColor: ColorUtil.surfaceLight),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        NavigationUtil.to(
                                            context, const SearchScreen());
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 11.42.w,
                                            right: 11.42,
                                          ),
                                          child: const SvgIcon(
                                            'assets/Icons/Search.svg',
                                            color: ColorUtil.surfaceLight,
                                          )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        NavigationUtil.to(
                                            context, const ShoppingScreen());
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 11.42.w,
                                            right: 11.42,
                                          ),
                                          child: const SvgIcon(
                                            'assets/Icons/bag.svg',
                                            color: ColorUtil.surfaceLight,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 34.w,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        mainChild: Positioned(
                          bottom: 50.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 32.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                discountPageView(isLight),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.w, top: 20.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0; i < pages.length; i++)
                                        DotIndicator(
                                          isIndicate: i == pageIndicate,
                                          color: isLight
                                              ? Colors.white
                                              : ColorUtil.surfaceDark,
                                          unhighlightcolor: isLight
                                              ? Colors.white54
                                              : Colors.black26,
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        bottomHeight: 46.h,
                        backgroundColor:
                            isLight ? ColorUtil.primaryColor : sliverColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(22.r)),
                        expandedHeight: 283.h);
                  }),
              SliverPadding(
                  padding: EdgeInsets.only(bottom: 19.h),
                  sliver: SliverToBoxAdapter(
                      child: RowWrapper(
                    text: 'Categories',
                    textRightStyle: FontStyleUtilities.h6(
                        fontWeight: FWT.semiBold,
                        fontColor: ColorUtil.primaryColor),
                  ))),
              category1(size2, categories: categories),
              category1(size2, categories: categories2),
              SliverPadding(
                  padding: EdgeInsets.only(bottom: 19.h),
                  sliver: const SliverToBoxAdapter(
                      child: RowWrapper(
                    text: 'Feature Products',
                  ))),
              SliverPadding(
                padding: EdgeInsets.only(left: 24.w),
                sliver: const SliverToBoxAdapter(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StaggeredWrapper(productList: productlist)),
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.only(bottom: 19.h),
                  sliver: SliverToBoxAdapter(
                      child: RowWrapper(
                    text: 'Flash Sale',
                    textright: 'Closing in',
                    isTimer: true,
                    textRightStyle: FontStyleUtilities.h5(
                        height: 1.7.h,
                        fontWeight: FWT.semiBold,
                        fontColor: Colors.red),
                    child: AnimatedBuilder(
                      animation: timeController,
                      builder: (context, child) => Text(
                        '04:${timeController.minute.toString().padLeft(2, '0')}:${timeController.second.toString().padLeft(2, '0')}',
                        style: FontStyleUtilities.h5(
                            fontWeight: FWT.regular,
                            fontColor: ColorUtil.primaryColor),
                      ),
                    ),
                  ))),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  bottom: size2.height * 0.050,
                ),
                sliver: const SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StaggeredWrapper(
                      productList: productlist2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox discountPageView(bool isLight) {
    return SizedBox(
      width: 375.w,
      height: 152.h,
      child: PageView.builder(
          itemCount: pages.length,
          pageSnapping: true,
          controller: controller,
          padEnds: false,
          onPageChanged: (value) {
            setState(() {
              pageIndicate = value;
            });
          },
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 289.w,
              height: 132.h,
              padding: EdgeInsets.only(right: 0.w, left: 20.w, top: 20.h),
              margin: EdgeInsets.only(
                right: 16.w,
              ),
              decoration: BoxDecoration(
                color: isLight
                    ? const Color.fromRGBO(255, 236, 233, 1)
                    : ColorUtil.surfaceDark,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '30% Discount \nfor Medicines',
                        style: FontStyleUtilities.h5(
                            fontColor: isLight
                                ? const Color.fromRGBO(17, 41, 80, 1)
                                : const Color.fromRGBO(255, 236, 233, 1),
                            fontWeight: FWT.semiBold),
                      ),
                      Text(
                        '15 - 18, Mar ',
                        style: FontStyleUtilities.t4(
                            fontWeight: FWT.semiBold,
                            fontColor: isLight
                                ? ColorUtil.mediumTextColor
                                : ColorUtil.scaffoldLight.withOpacity(0.8)),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Order Now',
                            style: FontStyleUtilities.t3(
                                fontWeight: FWT.semiBold,
                                fontColor: ColorUtil.primaryColor),
                          ))
                    ],
                  ),
                  Image.asset(
                    'assets/Images/Temp/image138.png',
                  )
                ],
              ),
            );
          }),
    );
  }

  SliverPadding category1(Size size2, {required List<Category> categories}) {
    return SliverPadding(
      padding: EdgeInsets.only(left: 24.w),
      sliver: SliverToBoxAdapter(
        child: Category1(
          category: categories,
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator(
      {Key? key,
      this.unhighlightcolor,
      this.radi = 8,
      this.color,
      this.isIndicate = false})
      : super(key: key);

  final bool isIndicate;
  final double radi;
  final Color? color, unhighlightcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radi.w,
      height: radi.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
          color: isIndicate
              ? color ?? Colors.white
              : unhighlightcolor ?? Colors.white.withOpacity(0.6),
          shape: BoxShape.circle),
    );
  }
}
