import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterTile extends StatelessWidget {
  const FilterTile(
      {Key? key,
      required this.isSelected,
      required this.filterText,
      required this.onTap})
      : super(key: key);
  final bool isSelected;
  final String filterText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42.h,
        width: 139.w,
        decoration: BoxDecoration(
            gradient: isSelected ? AppGradients.blueGradient : null,
            color: isSelected
                ? ColorUtil.primaryColor
                : isLight
                    ? const Color(0xffF5FDFF)
                    : ColorUtil.surfaceDark,
            borderRadius: BorderRadius.circular(14.r)),
        child: Center(
          child: Text(
            filterText,
            style: FontStyleUtilities.h4(
                fontWeight: FWT.medium,
                height: 1,
                fontColor: isSelected ? Colors.white : ColorUtil.primaryColor),
          ),
        ),
      ),
    );
  }
}
