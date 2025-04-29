import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/onlinepharmacy.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';

class TextWrapper extends StatelessWidget {
  const TextWrapper({
    Key? key,
    required this.text,
    required this.isLight,
    this.dotRadius = 8,
    this.isDot = true,
  }) : super(key: key);

  final String text;
  final double dotRadius;
  final bool isLight;
  final bool isDot;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isDot
            ? Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: DotIndicator(
                  isIndicate: true,
                  radi: dotRadius,
                  color: isLight
                      ? ColorUtil.blue.withOpacity(0.6)
                      : Colors.white70,
                ),
              )
            : const SizedBox(),
        Expanded(
          child: Text(
            text,
            style: FontStyleUtilities.t2(
                height: 1.3,
                fontColor: isLight
                    ? const Color.fromRGBO(94, 111, 136, 1)
                    : Colors.white.withOpacity(0.8),
                fontWeight: FWT.medium),
          ),
        ),
      ],
    );
  }
}
