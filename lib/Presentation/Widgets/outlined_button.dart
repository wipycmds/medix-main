import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/utils.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    Key? key,
    required this.tittle,
    required this.onTap,
    this.textColor,
    this.height,
    this.style,
    this.leading,
    this.trailing,
  }) : super(key: key);
  //relative distance should be maintained by padding
  final Widget? leading, trailing;
  final String tittle;
  final VoidCallback onTap;
  final Color? textColor;
  final double? height;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.5.w,
            color: ColorUtil.primaryColor,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.transparent),
      child: SizedBox(
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) leading!,
              Text(
                tittle,
                style: style ??
                    FontStyleUtilities.h5(
                        height: 1,
                        fontWeight: FWT.semiBold,
                        fontColor: textColor ?? ColorUtil.primaryColor),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
