import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Utils/color_utils.dart';
import 'dart:math' as math;
import '../../Utils/font_style.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          border: Border.all(color: ColorUtil.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: TextButton(
          onPressed: onTap ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: FontStyleUtilities.h5(
                    fontWeight: FWT.semiBold,
                    fontColor: ColorUtil.primaryColor),
              ),
              SizedBox(
                width: 5.w,
              ),
              Transform.rotate(
                  angle: text == 'View more reviews' ? math.pi / 2 : 0,
                  child: Icon(icon, size: 14, color: ColorUtil.primaryColor)),
            ],
          )),
    );
  }
}
