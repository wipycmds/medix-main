import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioWrapper extends StatelessWidget {
  const RadioWrapper({Key? key, required this.isSelected, required this.text})
      : super(key: key);
  final bool isSelected;
  final String text;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        RadioButton(isSelected: isSelected),
        16.width(),
        Text(
          text,
          style: FontStyleUtilities.h6(
              fontWeight: FWT.medium,
              fontColor: isLight
                  ? const Color(0xff7a7a7a)
                  : Colors.white.withOpacity(0.60)),
        ),
      ],
    );
  }
}

class RadioButton extends StatefulWidget {
  const RadioButton({Key? key, required this.isSelected}) : super(key: key);
  final bool isSelected;
  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      width: 16.h,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorUtil.primaryColor)),
      child: AnimatedContainer(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isSelected
                ? ColorUtil.primaryColor
                : Colors.transparent),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
