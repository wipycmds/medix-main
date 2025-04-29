import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/shopping/compo/textwrapper.dart';

import 'package:medix/Presentation/Widgets/svg_icon.dart';
import 'package:medix/Utils/font_style.dart';

import '../../../../Utils/color_utils.dart';

class SpecializeWidget extends StatelessWidget {
  const SpecializeWidget(
      {Key? key,
      required this.icon,
      this.text = '',
      this.color,
      this.isIcon = true,
      this.subColor,
      this.height = 65,
      this.subTextsize,
      this.iconHeight,
      this.iconWidth,
      this.textsize,
      this.isVerticalCenter = true,
      this.isAligntext = false,
      this.subText = '',
      this.time = const []})
      : super(key: key);

  final String icon, text, subText;
  final Color? color, subColor;
  final double height;
  final double? iconHeight, iconWidth;
  final double? textsize, subTextsize;
  final bool isIcon, isVerticalCenter, isAligntext;
  final List<String>? time;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var isLight = Theme.of(context).brightness == Brightness.light;
      return Container(
        constraints: BoxConstraints(
          minWidth: 50.w,
          maxWidth: 220.w,
          minHeight: 20.h,
          maxHeight: text == 'Support Time' ? 126.h : height.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: isVerticalCenter
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                isIcon
                    ? SvgIcon(
                        icon,
                        width: iconWidth ?? 12.5.w,
                        height: iconHeight ?? 12.5.h,
                        color: ColorUtil.primaryColor,
                      )
                    : const SizedBox(),
                SizedBox(
                  width: 5.w,
                ),
                isAligntext
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.end,
                            style: FontStyleUtilities.t2(
                                    height: 1.h,
                                    fontWeight: FWT.semiBold,
                                    fontColor: isLight
                                        ? color ?? Colors.black
                                        : color ?? Colors.white)
                                .copyWith(
                              fontSize: textsize ?? 14.sp,
                            ),
                          ),
                          Text(
                            subText,
                            textAlign: TextAlign.start,
                            style: FontStyleUtilities.t2(
                                    fontWeight:
                                        subColor == ColorUtil.lightTextColor
                                            ? FWT.medium
                                            : FWT.semiBold,
                                    fontColor: isLight
                                        ? subColor ?? Colors.black38
                                        : subColor ??
                                            Colors.white.withOpacity(0.75))
                                .copyWith(fontSize: subTextsize ?? 14.sp),
                          )
                        ],
                      )
                    : Text(
                        text,
                        textAlign: TextAlign.end,
                        style: FontStyleUtilities.t2(
                                height: 1.3,
                                fontWeight: FWT.semiBold,
                                fontColor: isLight
                                    ? color ?? ColorUtil.blue
                                    : color ?? Colors.white)
                            .copyWith(fontSize: textsize ?? 14.sp),
                      ),
              ],
            ),
            isAligntext == true
                ? const SizedBox()
                : Text(
                    subText,
                    textAlign: TextAlign.end,
                    style: FontStyleUtilities.t2(
                            fontWeight: FWT.medium,
                            fontColor: isLight
                                ? subColor ?? const Color.fromRGBO(94, 111, 136, 1)
                                : subColor ?? Colors.white.withOpacity(0.75))
                        .copyWith(fontSize: subTextsize ?? 14.sp),
                  ),
            text == 'Support Time'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWrapper(
                        dotRadius: 5,
                        text: time![0],
                        isLight: isLight,
                      ),
                      Text(
                        'Sat - Sun:',
                        style: FontStyleUtilities.t2(
                            fontWeight: FWT.medium,
                            fontColor: isLight
                                ? const Color.fromRGBO(94, 111, 136, 1)
                                : Colors.white.withOpacity(0.75)),
                      ),
                      TextWrapper(
                        dotRadius: 5,
                        text: time![1],
                        isLight: isLight,
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      );
    });
  }
}
