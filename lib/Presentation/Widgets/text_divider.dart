import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({
    Key? key,
    required this.textDivider,
    this.style,
    this.symmetricPadding,
  }) : super(key: key);
  final String textDivider;
  final double? symmetricPadding;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: const Color(0xff2D2D2D).withOpacity(.20),
        )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: symmetricPadding ?? 22.w),
            child: Text(
              textDivider,
              style: style ??
                  FontStyleUtilities.h5(
                          fontWeight: FWT.medium,
                          fontColor: ColorUtil.mediumTextColor)
                      .copyWith(fontSize: 18),
            )),
        Expanded(
            child: Divider(
          color: const Color(0xff2D2D2D).withOpacity(.20),
        ))
      ],
    );
  }
}
