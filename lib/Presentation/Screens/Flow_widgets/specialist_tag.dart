import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialistTag extends StatelessWidget {
  const SpecialistTag({Key? key, required this.tag}) : super(key: key);
  final String tag;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 39.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isLight ? const Color(0xffEDFCFF) : ColorUtil.onDarkSurface),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: FontStyleUtilities.h6(
                height: 1,
                fontWeight: FWT.medium,
                fontColor: ColorUtil.primaryColor),
          ),
        ],
      ),
    );
  }
}

class TagIconWrapper extends StatelessWidget {
  const TagIconWrapper(
      {Key? key,
      this.padding,
      required this.icon,
      this.iconColor,
      required this.param,
      required this.value,
      this.scale})
      : super(key: key);
  final String icon, param, value;
  final double? padding, scale;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        TagIconBox(
          iconColor: iconColor,
          scale: scale,
          icon: icon,
          padding: padding,
        ),
        16.width(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              param,
              style: FontStyleUtilities.h6(
                  fontWeight: FWT.regular,
                  fontColor: isLight
                      ? Colors.black.withOpacity(.50)
                      : Colors.white.withOpacity(.70)),
            ),
            Text(
              value,
              style: FontStyleUtilities.h6(
                  fontWeight: FWT.semiBold,
                  fontColor: isLight ? Colors.black : Colors.white),
            ),
          ],
        )
      ],
    );
  }
}

class TagIconBox extends StatelessWidget {
  const TagIconBox({
    Key? key,
    required this.icon,
    this.padding,
    this.scale,
    this.iconColor,
  }) : super(key: key);
  final String icon;
  final Color? iconColor;
  final double? padding, scale;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      height: 41.h,
      width: 45.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: isLight
                  ? Colors.black.withOpacity(.10)
                  : Colors.white.withOpacity(.10)),
          borderRadius: BorderRadius.circular(10.r)),
      child: Transform.scale(
        scale: scale ?? 1,
        child: SvgIcon(
          icon,
          color: iconColor,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
