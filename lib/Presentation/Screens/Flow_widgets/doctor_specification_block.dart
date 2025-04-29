import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';

class SpecificationBlock extends StatelessWidget {
  const SpecificationBlock({
    Key? key,
    required this.icon,
    required this.func,
    required this.count,
  }) : super(key: key);
  final String icon, func, count;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon,
              color: isLight ? null : Colors.white,
            ),
            10.width(),
            Text(
              count,
              style: FontStyleUtilities.h6(
                  fontWeight: FWT.medium,
                  fontColor: isLight ? Colors.black : Colors.white),
            ),
          ],
        ),
        4.height(),
        Text(
          func,
          style: FontStyleUtilities.h6(
              fontWeight: FWT.medium,
              fontColor:
                  isLight ? Colors.black.withOpacity(.35) : Colors.white),
        ),
      ],
    );
  }
}
