import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IllnessTag extends StatelessWidget {
  const IllnessTag({Key? key, required this.value, this.onTap})
      : super(key: key);
  final String value;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
            color: ColorUtil.primaryColor.withOpacity(.10),
            borderRadius: BorderRadius.circular(4.r)),
        height: 20.h,
        child: Text(
          value,
          style: FontStyleUtilities.t5(
              fontWeight: FWT.medium, fontColor: ColorUtil.primaryColor),
        ),
      ),
    );
  }
}
