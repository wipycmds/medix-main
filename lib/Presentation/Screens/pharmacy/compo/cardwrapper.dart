import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medix/Utils/font_style.dart';

class CardWrapper extends StatelessWidget {
  const CardWrapper(
      {Key? key,
      required this.onTap,
      this.image = 'assets/Icons/drugs.svg',
      this.text = ''})
      : super(key: key);

  final String text;
  final String image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 100.w,
            height: 120.h,
            margin: EdgeInsets.only(right: 12.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: isLight
                                  ? const Color.fromRGBO(242, 244, 245, 1)
                                  : Colors.white.withOpacity(0.2))),
                      width: 90.w,
                      height: 90.h,
                      padding: EdgeInsets.all(20.r),
                      child: SvgPicture.asset(image,
                          width: 30.w, height: 48.h, fit: BoxFit.contain)),
                  SizedBox(height: 10.h),
                  Text(
                    text,
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.medium,
                        height: 1.2,
                        fontColor: isLight ? Colors.black : Colors.white),
                  ),
                ])));
  }
}
