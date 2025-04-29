import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/Main/Shared/home_text_field.dart';
import 'package:medix/Presentation/Screens/help%20center/compo/helpwrapper.dart';
import 'package:medix/Presentation/Widgets/sliver_sized_box.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';
import '../../Widgets/back_button.dart';
import '../../Widgets/sliver_app_bar_header.dart';
import '../../Widgets/svg_icon.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key, this.headText = '', this.nodetails = true})
      : super(key: key);
  final bool nodetails;
  final String headText;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    List popular = [
      'Change email Address',
      'How to Manage Notifications',
      'How to refund'
    ];

    List account = [
      'My Account has been Hijacked',
      'I want to close my account',
      'How to Manage Notifications',
      'I want to Change Mobile Number'
    ];

    List order = [
      'I want to cancel my Order',
      'How to Delete Products in Shopping Cart?',
      'I cannot Track Delivery Reciept',
      'My Order has not been sent by seller',
    ];
    return Scaffold(
        backgroundColor: isLight ? Colors.white : ColorUtil.scaffoldDark,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: ColorUtil.primaryColor,
            leading: const MyBackButton(
              color: Colors.white,
            ),
            title: Text(
              'Help Center',
              style: FontStyleUtilities.h3(
                  fontColor: Colors.white, fontWeight: FWT.semiBold),
            ),
          ),
          MyStickyHeader(
            pinned: true,
            backgroundColor: ColorUtil.primaryColor,
            expandedHeight: 130.h,
            height: 135.h,
            elevation: 3,
            child: Container(
                padding: EdgeInsets.only(
                    left: 20.w, right: 0.w, top: 16.h, bottom: 10.h),
                decoration: BoxDecoration(
                  color: isLight ? Colors.white : ColorUtil.scaffoldDark,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {},
                            child: HomeTextField(
                                prefix: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 11.42.w),
                                    child: SvgIcon(
                                      'assets/Icons/Search.svg',
                                      color: isLight
                                          ? Colors.black.withOpacity(.30)
                                          : ColorUtil.mediumTextColor,
                                    )),
                                hint: 'Describe your issue...'),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              'Recent :   ',
                              style: FontStyleUtilities.t2(
                                fontWeight: FWT.semiBold,
                                fontColor:
                                    isLight ? ColorUtil.blue : Colors.white,
                              ),
                            ),
                            ...order.map((e) => Recentwrap(
                                  text: e,
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
          nodetails
              ? SliverSizedBox(
                  height: 15.h,
                )
              : const SliverSizedBox(),
          SliverToBoxAdapter(
            child: nodetails
                ? const HelpWrapper(
                    icon: 'assets/Icons/Search.svg',
                    headText: 'Popular Search',
                  )
                : HelpDisplay(
                    headText: headText,
                    stepText: '1. Select the profile menu at the bottom menu.',
                    isHead: true,
                  ),
          ),
          nodetails
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  ...popular.map((e) => HelpChild(
                        headText: e,
                      ))
                ]))
              : const SliverToBoxAdapter(
                  child: HelpDisplay(
                      stepText:
                          '2. from the menu, scroll down and select the notification menu.'),
                ),
          nodetails
              ? SliverSizedBox(
                  height: 20.h,
                )
              : const SliverToBoxAdapter(
                  child: HelpDisplay(
                      stepText:
                          '3. click the toggle button to turn off or turn on notifications. If it is on, it means the toggle is green, and if it is off the toggle is gray.'),
                ),
          nodetails
              ? const SliverToBoxAdapter(
                  child: HelpWrapper(
                    icon: 'assets/Icons/3 Friends.svg',
                    headText: 'Account',
                  ),
                )
              : const SliverSizedBox(),
          nodetails
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  ...account.map((e) => HelpChild(
                        headText: e,
                      ))
                ]))
              : const SliverSizedBox(),
          nodetails
              ? SliverSizedBox(
                  height: 20.h,
                )
              : SliverSizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Divider(
                      thickness: 0.6,
                      height: 20.h,
                    ),
                  ),
                ),
          SliverToBoxAdapter(
            child: HelpWrapper(
                icon: nodetails
                    ? 'assets/Icons/bag.svg'
                    : 'assets/Icons/document.svg',
                headText: nodetails ? 'My Order' : 'Related Articles'),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            ...order.map((e) => HelpChild(
                  headText: e,
                ))
          ])),
          SliverSizedBox(
            height: 30.h,
          )
        ]));
  }
}

class HelpDisplay extends StatelessWidget {
  const HelpDisplay(
      {Key? key,
      this.headText = '',
      required this.stepText,
      this.isHead = false})
      : super(key: key);
  final String stepText;
  final bool isHead;
  final String headText;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isHead
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    headText,
                    style: FontStyleUtilities.h5(
                        fontWeight: FWT.semiBold,
                        fontColor: isLight ? ColorUtil.blue : Colors.white),
                  ),
                )
              : const SizedBox(),
          Text(
            stepText,
            style: FontStyleUtilities.t2(
                fontWeight: FWT.medium,
                fontColor: isLight
                    ? ColorUtil.lightTextColor
                    : Colors.white.withOpacity(0.8)),
          ),
          SizedBox(
            width: size.width,
            height: 240.h,
            child: Image.asset('assets/Images/Temp/aboutus.png'),
          )
        ],
      ),
    );
  }
}

class Recentwrap extends StatelessWidget {
  const Recentwrap({Key? key, this.text = ''}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: isLight ? Colors.grey[200] : ColorUtil.surfaceDark,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Material(
              color: Colors.transparent,
              child: InkResponse(
                // onTap: () {},
                child: SvgIcon(
                  'assets/Icons/close.svg',
                  width: 10.w,
                  height: 10.h,
                  color: isLight ? ColorUtil.blue : Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            text,
            style: FontStyleUtilities.t4(
                fontColor: isLight ? ColorUtil.blue : Colors.white,
                fontWeight: FWT.medium),
          )
        ],
      ),
    );
  }
}
