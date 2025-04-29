import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/specializewidget.dart';
import 'package:medix/Presentation/Screens/shopping/compo/listwrapper.dart';
import 'package:medix/Presentation/Widgets/animate_color.dart';

import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';

class OrderTracker extends StatefulWidget {
  const OrderTracker({Key? key}) : super(key: key);

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  List<int> delay = [400, 800, 1200, 1600, 2000];
  @override
  Widget build(BuildContext context) {
    var size2 = MediaQuery.of(context).size;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      width: size2.width / 1.5,
      height: 590.h,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 0.w, right: 10.w, top: 6.h, bottom: 16.h),
      child: Stack(
        children: [
          Container(
            width: 250.w,
            height: 450.h,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 14.w),
            child: SizedBox(
              width: 2.w,
              height: 370.h,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 2000),
                builder: (_, double value, child) {
                  return RotatedBox(
                    quarterTurns: 1,
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 2,
                      backgroundColor: Colors.transparent,
                      color: isLight ? Colors.grey[200] : Colors.white54,
                    ),
                  );
                },
                tween: Tween<double>(begin: 0, end: 1),
              ),
            ),
          ),
          Trackwidget(
            top: 0,
            delay: delay[0],
            status: 'Order Placed',
            description: 'Your order #21091995 was placed for delivery',
          ),
          Trackwidget(
            top: 80.h,
            status: 'Pending',
            delay: delay[1],
            description:
                'Your order is pending for confirmation. Will confirmed within 5 minutes.',
          ),
          Trackwidget(
            delay: delay[2],
            top: 183.h,
            status: 'Confirmed',
            description:
                'Your order is confirmed. Will delivery soon with 2 days.',
          ),
          Trackwidget(
            delay: delay[3],
            top: 263.h,
            status: 'Processing',
            description: 'Your order #21091995 was placed for delivery',
          ),
          Trackwidget(
            delay: delay[4],
            top: 343.h,
            status: 'Delivered',
            isEmpty: true,
            description:
                'Product delivery to you and marked as deliverd by customers',
          )
        ],
      ),
    );
  }
}

class Trackwidget extends StatelessWidget {
  const Trackwidget({
    Key? key,
    this.top = 0,
    this.delay = 0,
    this.status = '',
    this.description = '',
    this.isEmpty = false,
  }) : super(key: key);
  final double top;
  final int delay;
  final bool isEmpty;
  final String status, description;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;

    return Positioned(
      top: top,
      left: 0.w,
      child: SizedBox(
        width: 230.w,
        height: 200.h,
        child: Stack(
          children: [
            Colorbox(
              counting: '',
              padding: const EdgeInsets.all(0),
              isIcon: true,
              border: isEmpty,
              width: 25.h,
              backheight: 25.h,
              backwidth: 25.h,
              backColor: isLight ? Colors.white : ColorUtil.scaffoldDark,
              color: isEmpty
                  ? isLight
                      ? Colors.white
                      : Colors.white70
                  : null,
              height: 25.h,
              duration: delay,
              borderRadius: 10.r,
              icon: isEmpty ? null : Icons.done,
            ),
            Positioned(
                top: 0.h,
                left: 45.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimateColor(
                      key: UniqueKey(),
                      counting: status,
                      startcolor:
                          isLight ? Colors.white : ColorUtil.scaffoldDark,
                      endcolor: isLight ? ColorUtil.blue : Colors.white,
                      size: 20,
                      milliduration: delay,
                      textStyle: FontStyleUtilities.h4(
                          fontColor: isLight ? ColorUtil.blue : Colors.white,
                          fontWeight: FWT.semiBold),
                    ),
                    Container(
                      height: 60.h,
                      width: 180.w,
                      padding: EdgeInsets.only(right: 5.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AnimateColor(
                              key: UniqueKey(),
                              counting: description,
                              startcolor: isLight
                                  ? Colors.white
                                  : ColorUtil.scaffoldDark,
                              endcolor: isLight
                                  ? const Color.fromRGBO(142, 154, 171, 1)
                                  : Colors.white.withOpacity(.7),
                              size: 15,
                              milliduration: delay,
                              textStyle: FontStyleUtilities.t1(
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class OrderDate extends StatelessWidget {
  const OrderDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    List timing = [
      [' 27 sep', '9:30 AM', 0.0],
      [' 27 sep', '16:30 PM', 80.0],
      [' 27 sep', '12:30 PM', 173.0],
      ['Today', '17:30 PM', 250.0],
    ];
    return Container(
      width: 90.w,
      height: 330.h,
      margin: EdgeInsets.only(left: 32.w, top: 10.h),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          ...timing
              .asMap()
              .entries
              .map((e) => Positioned(
                    top: e.value[2],
                    child: SpecializeWidget(
                      isIcon: false,
                      text: e.value[0],
                      subText: e.value[1],
                      textsize: 15.sp,
                      subTextsize: 15.sp,
                      subColor: isLight ? ColorUtil.blue : Colors.white,
                      icon: '',
                    ),
                  ))
              ,
        ],
      ),
    );
  }
}
