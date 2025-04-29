import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Utils/font_style.dart';

import '../../../../../Utils/color_utils.dart';

class DetailTag extends StatelessWidget {
  const DetailTag({
    Key? key,
    required this.isLight,
  }) : super(key: key);

  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      height: 25.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isLight
              ? const Color(0xffF2FCFF)
              : Colors.black.withOpacity(0.30),
          borderRadius: BorderRadius.circular(19.r)),
      child: Text(
        'Details',
        style: FontStyleUtilities.t4(
            height: 1,
            fontWeight: FWT.medium,
            fontColor: ColorUtil.primaryColor),
      ),
    );
  }
}
