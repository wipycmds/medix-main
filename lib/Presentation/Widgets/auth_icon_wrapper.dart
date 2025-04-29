import 'package:flutter/material.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthIconWrapper extends StatelessWidget {
  const AuthIconWrapper({
    Key? key,
    required this.icon,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.iconColor,
  }) : super(key: key);
  final String icon;
  final EdgeInsetsGeometry? padding, margin;
  final double? height, width, borderRadius;
  final Color? color, iconColor;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 9.h, horizontal: 11.w),
      margin: margin ??
          EdgeInsets.only(left: 6.w, right: 10.w, top: 6.h, bottom: 6.h),
      height: height ?? 42.h,
      width: width ?? 46.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
        color: isLight
            ? const Color(0xffCAF6FF).withOpacity(.35)
            : const Color(0xffCAF6FF).withOpacity(.05),
      ),
      child: SvgIcon(
        icon,
        color: iconColor,
      ),
    );
  }
}
