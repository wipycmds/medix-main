import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      height: 71.14.h,
      width: 83.w,
      child: Image.asset(
        isLight ? 'assets/Logo/luvmedLogos.png' : 'assets/Logo/luvmedLogos.png',
        // color:  null : ColorUtil.primaryColor,
      ),
    );
  }
}
