import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/Main/Home/Compo/bottomnav.dart';
import 'package:medix/Presentation/Screens/order/ordertrack.dart';
import 'package:medix/Presentation/Widgets/sliver_bar.dart';
import 'package:medix/Presentation/Widgets/svg_icon.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';

import '../../../Utils/navigation_util.dart';
import '../../Widgets/button.dart';
import '../../Widgets/textbutton.dart';
import '../product detail/compo/paragraph.dart';
import '../product detail/compo/specializewidget.dart';

class SuccessOrder extends StatelessWidget {
  const SuccessOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverBar(
            isbackVisible: false,
            expandedHeight: 310.h,
            widget: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 90.h),
              child: Image.asset('assets/Images/Temp/success.png'),
            ),
            bottomHeight: 44.h,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
            mainChild: Positioned(
                bottom: 50.h,
                child: Row(
                  children: [
                    Text(
                      'Order Success',
                      style: FontStyleUtilities.h3(
                          fontWeight: FWT.semiBold, fontColor: Colors.white),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const SvgIcon('assets/Icons/tick.svg')
                  ],
                )),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Please prepare the amount to be paid',
                    style: FontStyleUtilities.t2(fontColor: Colors.grey[400]),
                  ),
                  Text(
                    '\$250.00',
                    style: FontStyleUtilities.h5(
                        fontColor: isLight ? ColorUtil.blue : Colors.white,
                        fontWeight: FWT.semiBold),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: MyTextButton(
                        text: 'Track My Order',
                        onTap: () {
                          NavigationUtil.to(context, const OrderTrack());
                        },
                        icon: Icons.arrow_forward_ios),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Delivered by',
                        style: FontStyleUtilities.t2(
                            fontColor: isLight ? ColorUtil.blue : Colors.white),
                        children: [
                          TextSpan(
                              text: ' Medix',
                              style: FontStyleUtilities.t2(
                                  fontWeight: FWT.semiBold,
                                  fontColor: ColorUtil.primaryColor))
                        ]),
                  ),
                  Container(
                    height: 250.h,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ...order.map((e) => SpecializeWidget(
                              icon: e.icon,
                              isVerticalCenter: false,
                              text: e.text,
                              textsize: 15.sp,
                              subTextsize: 17.sp,
                              isAligntext: true,
                              subColor: ColorUtil.primaryColor,
                              subText: e.subText,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 0.h),
                    child: Button(
                        tittle: 'Start a new order',
                        color: ColorUtil.primaryColor,
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomNav(
                                        index: 1,
                                      )),
                              (route) => false);
                          // NavigationUtil.to(
                          //     context,
                          //     const BottomNav(
                          //       index: 1,
                          //     ));
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
