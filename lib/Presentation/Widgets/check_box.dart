import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Utils/color_utils.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({Key? key, required this.onChange}) : super(key: key);
  final ValueChanged<bool> onChange;
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool confirm = false;
  onChange(bool? b) {
    confirm = b ?? false;
    widget.onChange(confirm);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange(!confirm);
      },
      child: Container(
        height: 13.33.h,
        width: 13.33.h,
        decoration: BoxDecoration(
            color: confirm ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: confirm ? Colors.blue : ColorUtil.mediumTextColor,
            )),
        child: const Icon(
          Icons.done,
          size: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
