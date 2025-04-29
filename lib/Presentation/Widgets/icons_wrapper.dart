import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWrapper extends StatelessWidget {
  const IconWrapper(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.color,
      this.padding})
      : super(key: key);
  final VoidCallback onTap;
  final String icon;
  final Color? color;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      height: 40.h,
      width: 40.h,
      child: InkResponse(
        onTap: onTap,
        splashColor: isLight ? Colors.grey[200] : Colors.white12,
        overlayColor: WidgetStateProperty.all(
          isLight ? Colors.grey[200] : Colors.white12,
        ),
        child: Container(
          padding: EdgeInsets.all(padding ?? 8.h),
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
              color: isLight ? Colors.white : ColorUtil.surfaceDark,
              shape: BoxShape.circle,
              border:
                  Border.all(color: const Color(0xffE2E2E2).withOpacity(.30))),
          child: Material(
            color: Colors.transparent,
            child: SvgIcon(
              icon,
              color: color ?? ColorUtil.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
