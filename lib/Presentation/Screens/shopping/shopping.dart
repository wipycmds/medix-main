import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Add_voucher/add_voucher.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Payment_method/payment_method.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/specialization.dart';
import 'package:medix/Presentation/Screens/shopping/compo/listwrapper.dart';
import 'package:medix/Presentation/Widgets/animate_color.dart';
import 'package:medix/Presentation/Widgets/rowwrapper.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';
import 'package:medix/Utils/navigation_util.dart';

import '../success/success.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen(
      {Key? key, this.text = 'Shopping Cart', this.isCheckout = false})
      : super(key: key);

  final String text;
  final bool isCheckout;

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  double totalCount = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        totalCounting.value = 0;
        count.value = productlist3.length;
        total();
      }
    });

    super.initState();
  }

  void total() {
    for (var element in productlist) {
      totalCounting.value += element.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var size2 = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: isLight ? Colors.white : ColorUtil.scaffoldDark,
        body: Stack(children: [
          CustomScrollView(slivers: [
            const SliverAppBar(
              backgroundColor: ColorUtil.primaryColor,
              automaticallyImplyLeading: false,
              pinned: true,
            ),
            SliverPadding(
                padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 0.h),
                sliver: SliverToBoxAdapter(
                    child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Address Shipping',
                              style:
                                  FontStyleUtilities.h4(fontWeight: FWT.medium)
                                      .copyWith(
                                fontSize: 17.sp,
                                color: isLight ? Colors.black : Colors.white,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Text('Change',
                                  style: FontStyleUtilities.t2(
                                    fontWeight: FWT.semiBold,
                                    fontColor: ColorUtil.primaryColor,
                                  )),
                            )
                          ]),
                      Row(
                        children: [
                          const SvgIcon('assets/Icons/Location.svg'),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            '23 Estean, New York City, USA ',
                            style: FontStyleUtilities.t2(
                                fontColor:
                                    isLight ? ColorUtil.blue : Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ))),
            SliverToBoxAdapter(
              child: Divider(
                height: widget.isCheckout ? 1.5.h : 1.5.h,
                color: isLight ? Colors.black12 : Colors.white12,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.isCheckout
                            ? isLight
                                ? Colors.black12
                                : Colors.white12
                            : Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                margin: EdgeInsets.only(
                  left: widget.isCheckout ? 24.w : 0,
                  right: widget.isCheckout ? 24.w : 0,
                  top: widget.isCheckout ? 20.h : 4.h,
                  bottom: widget.isCheckout ? 12.h : 4.h,
                ),
                child: Column(
                  children: [
                    widget.isCheckout
                        ? Container(
                            width: size2.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: isLight
                                          ? Colors.black12
                                          : Colors.white12)),
                            ),
                            padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Orders will be delivered by ',
                                  style: FontStyleUtilities.t2(
                                      fontColor: isLight
                                          ? ColorUtil.blue
                                          : Colors.white),
                                  children: [
                                    TextSpan(
                                        text: '18:00 Tomorrow',
                                        style: FontStyleUtilities.t2(
                                            fontColor: ColorUtil.primaryColor))
                                  ]),
                            ),
                          )
                        : const SizedBox(),
                    ...productlist3
                        .asMap()
                        .entries
                        .map((e) => ListWrapper(
                              image: e.value.image,
                              totalCounter: (double value) {},
                              total: totalCount,
                              key: ValueKey(e),
                              length: count.value,
                              text: e.value.name,
                              isLast: productlist3.length - 1 == e.key,
                              model: e.value,
                              price: e.value.price,
                              isCheckout: widget.isCheckout,
                            ))
                        ,
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: widget.isCheckout ? 0 : 90.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: widget.isCheckout ? 12.h : 0,
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: widget.isCheckout ? 24.w : 8.w),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: widget.isCheckout
                              ? isLight
                                  ? Colors.black12
                                  : Colors.white12
                              : Colors.transparent),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: widget.isCheckout
                      ? Column(
                          children: [
                            voucher(context, isLight),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              child: Divider(
                                color:
                                    isLight ? Colors.black12 : Colors.white12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigationUtil.to(context, SelectPaymentMethod(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ));
                              },
                              child: RowWrapper(
                                leading: const SvgIcon('assets/Icons/Plus.svg'),
                                text: '  Payment',
                                textStyle: FontStyleUtilities.t1(
                                    fontWeight: FWT.regular,
                                    height: 1.2.h,
                                    fontColor: isLight
                                        ? ColorUtil.blue
                                        : Colors.white),
                                isleading: true,
                                onTap: () {
                                  NavigationUtil.to(context,
                                      SelectPaymentMethod(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ));
                                },
                                textRightStyle: FontStyleUtilities.t2(
                                    fontWeight: FWT.semiBold,
                                    fontColor: ColorUtil.primaryColor),
                                textright: 'Payment on Delivery code ',
                              ),
                            ),
                          ],
                        )
                      : voucher(context, isLight),
                ),
              ),
            ),
            widget.isCheckout
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notes for Medix',
                            style: FontStyleUtilities.t2(
                                fontWeight: FWT.semiBold,
                                fontColor:
                                    isLight ? ColorUtil.blue : Colors.white),
                          ),
                          Container(
                            height: 137.h,
                            margin: EdgeInsets.only(top: 10.h),
                            child: const MyTextField(
                                maxLines: 5,
                                obscureText: false,
                                isBorder: true,
                                hint: 'Take some notes for the shipper'),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SliverSizedBox(
                    height: 0,
                    width: 0,
                  ),
            SliverToBoxAdapter(
              child: widget.isCheckout
                  ? Divider(
                      thickness: 8,
                      color: isLight ? Colors.grey[200] : Colors.white12,
                    )
                  : const SizedBox(),
            ),
            widget.isCheckout
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          RowWrapper(
                            text: 'Total deal',
                            textRightStyle: fontstyle(
                                isLight ? ColorUtil.blue : Colors.white),
                            textStyle: fontstyle(
                                isLight ? ColorUtil.blue : Colors.white),
                            textright: '\$200',
                            child: const SizedBox(),
                          ),
                          RowWrapper(
                            text: 'Voucher',
                            textright: '-\$50',
                            textRightStyle: fontstyle(ColorUtil.primaryColor),
                            textStyle: fontstyle(
                                isLight ? ColorUtil.blue : Colors.white),
                            child: const SizedBox(),
                          ),
                          RowWrapper(
                            text: 'Total',
                            textStyle: fontstyle(
                                isLight ? ColorUtil.blue : Colors.white),
                            textRightStyle: fontstyle(ColorUtil.primaryColor),
                            textright: '\$150',
                            child: const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SliverSizedBox(),
            SliverPadding(
              padding: const EdgeInsets.only(
                bottom: 0,
              ),
              sliver: widget.isCheckout
                  ? SliverToBoxAdapter(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90.h,
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color:
                              isLight ? Colors.white : ColorUtil.scaffoldDark,
                        ),
                        child: Button(
                            tittle: 'Confirm',
                            horizontalGap: 40.w,
                            color: ColorUtil.primaryColor,
                            onTap: () {
                              NavigationUtil.to(context, const SuccessOrder());
                            }),
                      ),
                    )
                  : const SliverToBoxAdapter(),
            ),
          ]),
          Positioned(
              top: MediaQuery.of(context).padding.top,
              child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(20)),
                  child: Container(
                    width: 375.w,
                    height: 80.h,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.w),
                    decoration: BoxDecoration(
                        color: isLight ? Colors.white : ColorUtil.scaffoldDark,
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: isLight
                                    ? const Color.fromRGBO(242, 244, 245, 1)
                                    : Colors.white12))),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgIcon(
                            'assets/Icons/arrow_back.svg',
                            color: isLight ? Colors.black : Colors.white,
                          ),
                        ),
                        Text(
                          widget.text,
                          style: FontStyleUtilities.h3(
                              fontWeight: FWT.semiBold,
                              fontColor:
                                  isLight ? ColorUtil.blue : Colors.white),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        widget.isCheckout
                            ? const SizedBox()
                            : ValueListenableBuilder(
                                valueListenable: count,
                                builder: (context, value, child) {
                                  return CircleAvatar(
                                      radius: 12.r,
                                      backgroundColor: ColorUtil.primaryColor,
                                      child: Text(count.value.toString(),
                                          style: FontStyleUtilities.t2(
                                            fontColor: Colors.white,
                                          )));
                                })
                      ],
                    ),
                  ))),
          Positioned(
            bottom: 0.h,
            child: widget.isCheckout
                ? const SizedBox()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90.h,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: isLight ? Colors.white : ColorUtil.scaffoldDark,
                        border: Border(
                            top: BorderSide(
                                color: isLight
                                    ? Colors.black12
                                    : Colors.white12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: FontStyleUtilities.t2(
                                  fontWeight: FWT.semiBold,
                                  fontColor: isLight
                                      ? ColorUtil.lightTextColor
                                      : Colors.white.withOpacity(0.8)),
                            ),
                            ValueListenableBuilder(
                                valueListenable: totalCounting,
                                builder: (context, double value, child) {
                                  return AnimateColor(
                                    key: UniqueKey(),
                                    counting:
                                        '\$${totalCounting.value.toStringAsFixed(2)}',
                                    textStyle: FontStyleUtilities.t4(
                                        fontWeight: FWT.semiBold),
                                    size: 16,
                                    startcolor: ColorUtil.pendingYellow,
                                    endcolor:
                                        isLight ? ColorUtil.blue : Colors.white,
                                  );
                                })
                          ],
                        ),
                        Button(
                            tittle: 'Checkout',
                            horizontalGap: 70.w,
                            color: ColorUtil.primaryColor,
                            onTap: () {
                              NavigationUtil.to(
                                  context,
                                  const ShoppingScreen(
                                    text: 'Checkout',
                                    isCheckout: true,
                                  ));
                            })
                      ],
                    ),
                  ),
          )
        ]));
  }

  GestureDetector voucher(BuildContext context, bool isLight) {
    return GestureDetector(
      child: RowWrapper(
        leading: SvgIcon(
          'assets/Icons/Discovery.svg',
          width: 15.w,
          height: 15.h,
          color: ColorUtil.primaryColor,
        ),
        text: '  Medix Voucher',
        onTap: () {
          NavigationUtil.to(context, AddVoucher(
            onTap: () {
              Navigator.pop(context);
            },
          ));
        },
        textStyle: FontStyleUtilities.t1(
            height: 1.2.h,
            fontWeight: FWT.regular,
            fontColor: isLight ? ColorUtil.blue : Colors.white),
        isleading: true,
        textRightStyle: FontStyleUtilities.t2(
            fontWeight: FWT.semiBold, fontColor: ColorUtil.primaryColor),
        textright: 'MEDIX  ',
      ),
    );
  }

  TextStyle fontstyle(Color color) => FontStyleUtilities.t2(
      fontWeight: FWT.semiBold, fontColor: color, height: 2);
}
