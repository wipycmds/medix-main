import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectBloodGroup extends StatefulWidget {
  const SelectBloodGroup(
      {Key? key, required this.onChanged, required this.bloodGroups})
      : super(key: key);
  final ValueChanged<String> onChanged;
  final List<String> bloodGroups;

  @override
  State<SelectBloodGroup> createState() => _SelectBloodGroupState();
}

class _SelectBloodGroupState extends State<SelectBloodGroup> {
  int _selectedIndex = -1;

  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(widget.bloodGroups[_selectedIndex]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.height(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Blood Group',
            style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium,
                    fontColor:
                        isLight ? Colors.black : Colors.white.withOpacity(0.80))
                .copyWith(fontSize: 19.sp),
          ),
        ),
        22.height(),
        SizedBox(
          height: 60.h,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: ListView.builder(
                itemCount: widget.bloodGroups.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) => GestureDetector(
                      onTap: () {
                        _setIndex(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 16.w,
                            right: index == widget.bloodGroups.length - 1
                                ? 16.w
                                : 0),
                        height: 60.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? ColorUtil.primaryColor
                                : isLight
                                    ? Colors.white
                                    : ColorUtil.surfaceDark,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                          child: Text(
                            widget.bloodGroups[index],
                            style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: _selectedIndex == index
                                    ? Colors.white
                                    : const Color(0xff7a7a7a)),
                          ),
                        ),
                      ),
                    )),
          ),
        )
      ],
    );
  }
}
