import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:medix/Presentation/Widgets/animate_color.dart';
import 'package:medix/Presentation/Widgets/svg_icon.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';

import '../../product detail/compo/specialization.dart';
import '../../product detail/productdetail.dart';

class ListWrapper extends StatefulWidget {
  const ListWrapper({
    Key? key,
    required this.image,
    this.text = '',
    this.price = 0.0,
    required this.model,
    this.isLast = false,
    this.isCheckout = false,
    this.length = 0,
    this.sideBorder = true,
    this.total = 0.0,
    required this.totalCounter,
  }) : super(key: key);
  final String image, text;
  final bool isCheckout;
  final int length;
  final ValueChanged<double> totalCounter;
  final double total;
  final bool sideBorder;
  final double price;
  final bool isLast;
  final ProductModel model;

  @override
  State<ListWrapper> createState() => _ListWrapperState();
}

class _ListWrapperState extends State<ListWrapper> {
  int itemCount = 1;

  double priceSetter = 0;
  int lengthSetter = 0;

  @override
  void initState() {
    if (mounted) {
      priceSetter = widget.price;
      lengthSetter = widget.length;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var text2 = AnimateColor(
      key: UniqueKey(),
      counting: '\$${priceSetter.toStringAsFixed(2)}',
      size: 14,
      textStyle: FontStyleUtilities.h6(fontWeight: FWT.semiBold),
      endcolor: ColorUtil.primaryColor,
    );
    var bool =
        productlist3.lastIndexOf(widget.model) == productlist3.length - 1 ||
            productlist4.lastIndexOf(widget.model) == productlist4.length - 1;
    return itemCount == 0
        ? const SizedBox()
        : Stack(children: [
            Container(
              width: 375.w,
              decoration: BoxDecoration(
                  border: widget.sideBorder
                      ? Border(
                          bottom: widget.isCheckout
                              ? widget.isLast
                                  ? BorderSide.none
                                  : BorderSide(
                                      width: 1.0,
                                      color: isLight
                                          ? Colors.black12
                                          : Colors.white12)
                              : BorderSide(
                                  width: 1.0,
                                  color: isLight
                                      ? Colors.black12
                                      : Colors.white12))
                      : Border.all(
                          width: 1,
                          color: isLight ? Colors.black12 : Colors.white12),
                  borderRadius: widget.sideBorder
                      ? null
                      : const BorderRadius.all(Radius.circular(12)),
                  shape: BoxShape.rectangle),
              padding: EdgeInsets.only(
                  bottom: 16.h,
                  top: 10.h,
                  left: widget.isLast
                      ? widget.isCheckout
                          ? 0
                          : 24.w
                      : 0,
                  right: widget.isLast
                      ? widget.isCheckout
                          ? 0
                          : 24.w
                      : 0),
              margin: EdgeInsets.symmetric(
                  horizontal: widget.isCheckout
                      ? 0
                      : widget.isLast
                          ? 0
                          : 24.w),
              child: Column(
                children: [
                  ListTile(
                    leading: SizedBox(
                      width: 72.w,
                      height: 76.h,
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    horizontalTitleGap: 2,
                    dense: true,
                    isThreeLine: true,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          overflow: widget.isCheckout
                              ? TextOverflow.ellipsis
                              : TextOverflow.visible,
                          style: FontStyleUtilities.t2(
                              height: 1.3,
                              fontWeight: FWT.semiBold,
                              fontColor:
                                  isLight ? ColorUtil.blue : Colors.white),
                        ),
                        TabletWrap(
                          isLight: isLight,
                          size: 12,
                          text: '60 Gummies',
                        )
                      ],
                    ),
                    trailing: SizedBox(
                      width: 10.w,
                    ),
                    subtitle: widget.isCheckout
                        ? Container(
                            width: 100.w,
                            margin: EdgeInsets.only(top: 5.h),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: SvgIcon(
                                    'assets/Icons/bag.svg',
                                    color: ColorUtil.primaryColor,
                                    width: 16.w,
                                    height: 16.h,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Quantity:  ',
                                      style: FontStyleUtilities.t4(
                                          fontWeight: FWT.semiBold,
                                          fontColor: Colors.grey[400]),
                                      children: [
                                        TextSpan(
                                          text: '02',
                                          style: FontStyleUtilities.t4(
                                              fontWeight: FWT.semiBold,
                                              fontColor: isLight
                                                  ? ColorUtil.blue
                                                  : Colors.white),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          )
                        : text2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                      ),
                      widget.isCheckout
                          ? const SizedBox()
                          : CartIncrement(
                              isLight: isLight,
                              price: widget.price,
                              onChanged: (int value) {
                                if (value == 0) {
                                  setState(() {
                                    itemCount = value;
                                  });
                                }

                                setState(() {
                                  priceSetter = widget.price * value;
                                  updateTotal();
                                });
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 18.w,
              top: widget.isCheckout ? 55.h : 3.h,
              child: widget.isCheckout
                  ? text2
                  : IconButton(
                      splashRadius: 16,
                      onPressed: () {
                        setState(() {
                          itemCount = 0;
                          lengthSetter--;
                          count.value = widget.length - 1;
                          totalCounting.value -= priceSetter;
                        });
                      },
                      icon: const SvgIcon(
                        'assets/Icons/Delete.svg',
                        color: ColorUtil.primaryColor,
                      ),
                    ),
            )
          ]);
  }

  void updateTotal() {
    widget.totalCounter(priceSetter);

    setState(() {});
  }
}

class CartIncrement extends StatefulWidget {
  const CartIncrement({
    Key? key,
    required this.isLight,
    this.price = 0,
    required this.onChanged,
  }) : super(key: key);

  final bool isLight;
  final double price;
  final ValueChanged<int> onChanged;

  @override
  State<CartIncrement> createState() => _CartIncrementState();
}

class _CartIncrementState extends State<CartIncrement> {
  int counting = 1;
  double totaling = totalCounting.value;

  void updateState() {
    widget.onChanged(counting);

    setState(() {});
  }

  void inc() {
    setState(() {
      totalCounting.value += widget.price;
      counting++;
    });
    updateState();
  }

  void dec() {
    setState(() {
      if (counting < 1) {
        setState(() {
          count.value = count.value--;
        });
      } else {
        totalCounting.value -= widget.price;
        counting--;

        updateState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108.w,
      height: 30.h,
      decoration: BoxDecoration(
          color: widget.isLight ? Colors.white : ColorUtil.surfaceDark,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.black12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          inkIcon(Icons.add, inc),
          Colorbox(
            backColor: Colors.transparent,
            counting: counting.toString(),
          ),
          inkIcon(Icons.remove, dec),
        ],
      ),
    );
  }

  Material inkIcon(IconData icon, Function() setter) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 30.h,
        height: 30.h,
        child: InkResponse(
          onTap: setter,
          child: Icon(
            icon,
            size: 16.r,
          ),
        ),
      ),
    );
  }
}

class Colorbox extends StatelessWidget {
  const Colorbox({
    Key? key,
    required this.counting,
    this.isIcon = false,
    this.width = 20,
    this.height = 20,
    this.backColor = Colors.white,
    this.borderRadius = 4,
    this.icon,
    this.padding,
    this.duration,
    this.color,
    this.border = false,
    this.backwidth = 20,
    this.backheight = 10,
  }) : super(key: key);

  final String counting;
  final Color backColor;
  final bool border;
  final int? duration;
  final EdgeInsetsGeometry? padding;
  final bool isIcon;
  final Color? color;
  final double width, backheight, backwidth, height, borderRadius;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return AnimateColor(
      key: UniqueKey(),
      isTextAnimate: false,
      startcolor: isLight
          ? ColorUtil.primaryColor.withOpacity(0.2)
          : ColorUtil.primaryColor.withOpacity(0.6),
      endcolor: isLight ? Colors.white : ColorUtil.surfaceDark,
      milliduration: duration,
      child: Container(
        width: backwidth.h + 6.h,
        height: backheight.h + 15.h,
        alignment: Alignment.center,
        color: backColor,
        child: AnimateColor(
          key: UniqueKey(),
          startcolor: backColor,
          endcolor: color ?? ColorUtil.primaryColor,
          isTextAnimate: false,
          milliduration: duration,
          child: Container(
            width: width.h,
            height: height.h,
            alignment: Alignment.center,
            padding: padding ?? const EdgeInsets.all(0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                border: border
                    ? Border.all(color: Colors.black12)
                    : Border.all(width: 0, color: Colors.transparent)),
            child: isIcon
                ? Icon(
                    icon,
                    size: 16.r,
                    color: Colors.white,
                  )
                : Text(counting,
                    style: FontStyleUtilities.t4(fontColor: Colors.white)),
          ),
        ),
      ),
    );
  }
}
