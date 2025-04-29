import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'appointment_data_radio_wrapper.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  int _selectedIndex = 0;
  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(_selectedIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          23.height(),
          Text(
            'Gender',
            style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium,
                    fontColor:
                        isLight ? Colors.black : Colors.white.withOpacity(0.80))
                .copyWith(fontSize: 19.sp),
          ),
          22.height(),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    _setIndex(0);
                  },
                  child: RadioWrapper(
                      isSelected: _selectedIndex == 0, text: 'Male')),
              30.width(),
              GestureDetector(
                  onTap: () {
                    _setIndex(1);
                  },
                  child: RadioWrapper(
                      isSelected: _selectedIndex == 1, text: 'Female')),
            ],
          )
        ],
      ),
    );
  }
}
