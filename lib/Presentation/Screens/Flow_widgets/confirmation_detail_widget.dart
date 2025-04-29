import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationDetail extends StatelessWidget {
  const ConfirmationDetail(
      {Key? key,
      required this.icon,
      required this.tittle,
      required this.subtitle})
      : super(key: key);
  final String icon, tittle, subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgIcon(
          icon,
          color: Theme.of(context).brightness == Brightness.light
              ? null
              : Colors.white,
        ),
        7.width(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tittle,
              style: FontStyleUtilities.t2(
                height: 1,
                fontWeight: FWT.regular,
                fontColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            6.height(),
            Text(
              subtitle,
              style: FontStyleUtilities.h5(
                      fontWeight: FWT.medium, fontColor: ColorUtil.primaryColor)
                  .copyWith(fontSize: 18.sp),
            ),
          ],
        )
      ],
    );
  }
}
