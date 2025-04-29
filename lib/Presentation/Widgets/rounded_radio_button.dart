import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedRadioButton extends StatelessWidget {
  const RoundedRadioButton({Key? key, required this.isActive, this.scale})
      : super(key: key);
  final bool isActive;

  final double? scale;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale ?? 1,
      child: Container(
        height: 20.h,
        width: 20.h,
        padding: EdgeInsets.all(5.5.h),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive ? AppGradients.blueGradient : null,
            color: isActive ? null : const Color(0xffEEEEEE)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      ),
    );
  }
}
