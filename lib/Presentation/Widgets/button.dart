import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Widgets/svg_icon.dart';

import '../../Utils/utils.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.tittle,
    required this.onTap,
    this.color,
    this.isBusy = false,
    this.isDisable = false,
    this.textColor,
    this.horizontalGap = 0,
    this.height,
    this.style,
    this.isArrowButton = false,
    this.leading,
    this.trailing,
    this.elevation,
  }) : super(key: key);
  final Widget? leading, trailing;
  final String tittle;
  final VoidCallback onTap;
  final double horizontalGap;
  final Color? color, textColor;
  final bool? isBusy, isDisable, isArrowButton;
  final double? height, elevation;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisable! ? .5 : 1,
      child: Material(
        borderRadius: BorderRadius.circular(10.r),
        elevation: elevation ?? 5,
        child: Container(
          height: height ?? 54.48.h,
          padding: EdgeInsets.symmetric(horizontal: horizontalGap),
          decoration: BoxDecoration(
            gradient: color != null
                ? LinearGradient(colors: [color!, color!])
                : AppGradients.blueGradient,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: InkWell(
            highlightColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onTap: isDisable! ? () {} : onTap,
            child: isBusy!
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                : isArrowButton!
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (leading != null) leading!,
                          Text(
                            tittle,
                            style: style ??
                                FontStyleUtilities.h5(
                                        height: 1,
                                        fontColor: textColor ?? Colors.white)
                                    .copyWith(fontSize: 18),
                          ),
                          SizedBox(width: 9.w),
                          SvgIcon(
                            'assets/Icons/Arrow - Right 2.svg',
                            height: 10.67.h,
                            width: 6.w,
                            color: Colors.white,
                          ),
                          if (trailing != null) trailing!,
                        ],
                      )
                    : Center(
                        child: Text(
                          tittle,
                          style: style ??
                              FontStyleUtilities.h5(
                                      height: 1,
                                      fontColor: textColor ?? Colors.white)
                                  .copyWith(fontSize: 18),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
