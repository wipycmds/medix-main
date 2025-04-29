import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppShadows {
  static final BoxShadow shadow = BoxShadow(
      color: const Color(0xff2D2D2D).withOpacity(.10),
      offset: Offset(5.w, 4.h),
      blurRadius: 20);
}
