import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key, this.onTap, this.padding, this.color})
      : super(key: key);
  final VoidCallback? onTap;

  final Color? color;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return IconButton(
      onPressed: onTap ??
          () {
            Navigator.pop(context);
          },
      icon: Padding(
        padding: padding ??
            EdgeInsets.only(left: 8.w, top: 12.h, bottom: 12.h, right: 10),
        child: SizedBox(
            height: 24.h,
            width: 24.h,
            child: SvgIcon(
              'assets/Icons/arrow_back.svg',
              color: isLight
                  ? color ?? Colors.black
                  : Colors.white.withOpacity(0.7),
            )),
      ),
    );
  }
}
