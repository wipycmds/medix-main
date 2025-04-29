import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Widgets/svg_icon.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';

class RowWrapper extends StatelessWidget {
  const RowWrapper(
      {Key? key,
      this.text = 'Pharmacy',
      this.textright,
      this.textRightStyle,
      this.leading = const SizedBox(),
      this.isleading = false,
      this.isTimer = false,
      this.textStyle,
      this.onTap,
      this.horizontalpad,
      this.child})
      : super(key: key);

  final String? text, textright;
  final double? horizontalpad;
  final Widget? child;
  final VoidCallback? onTap;
  final Widget leading;
  final bool isleading, isTimer;
  final TextStyle? textStyle, textRightStyle;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalpad ?? 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isleading ? leading : const SizedBox(),
          Text(
            text ?? '',
            style: textStyle ??
                FontStyleUtilities.h4(fontWeight: FWT.semiBold).copyWith(
                    fontSize: 19.sp,
                    color: isLight ? Colors.black : Colors.white),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap ?? () {},
            child: Text(
              textright ?? 'View all  ',
              style: textRightStyle ??
                  FontStyleUtilities.h6(
                      fontWeight: FWT.semiBold,
                      fontColor: ColorUtil.primaryColor),
            ),
          ),
          isTimer
              ? Container(
                  width: 70.w,
                  height: 35.h,
                  padding: EdgeInsets.only(top: 4.h, left: 10.w),
                  child: child)
              : Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: child ??
                      const SvgIcon(
                        'assets/Icons/arrow_right.svg',
                        color: ColorUtil.primaryColor,
                      ),
                ),
        ],
      ),
    );
  }
}
