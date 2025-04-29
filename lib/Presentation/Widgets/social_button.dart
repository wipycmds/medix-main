import 'package:flutter/material.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.icon}) : super(key: key);
  final String icon;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.all(17.h),
      height: 65.h,
      width: 65.h,
      decoration: BoxDecoration(
          color: isLight ? Colors.white : ColorUtil.surfaceDark,
          borderRadius: BorderRadius.circular((65 / 2).h),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff2D2D2D).withOpacity(.10),
                offset: Offset(5.w, 4.h),
                blurRadius: 20)
          ]),
      child: SvgIcon(icon),
    );
  }
}
