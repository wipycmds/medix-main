import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/package/filter_controller.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Schedules extends StatelessWidget {
  const Schedules(
      {Key? key, required this.morningTimes, required this.controller})
      : super(key: key);
  final List<String> morningTimes;
  final FilterController<String> controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: StaggeredGridView.countBuilder(
          itemCount: morningTimes.length,
          crossAxisSpacing: 30.w,
          mainAxisSpacing: 16.h,
          crossAxisCount: 2,
          itemBuilder: (context, int index) => AnimatedBuilder(
                animation: controller,
                builder: (context, child) => ScheduleTile(
                    isSelected:
                        controller.filters.contains(morningTimes[index]),
                    filterText: morningTimes[index],
                    onTap: () {
                      controller.addAsRadio(morningTimes[index]);
                    }),
              ),
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(1)),
    );
  }
}

class ScheduleTile extends StatelessWidget {
  const ScheduleTile(
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
        height: 58.h,
        width: 157.w,
        decoration: BoxDecoration(
            gradient: isSelected
                ? AppGradients.blueGradient
                : LinearGradient(
                    colors: isLight
                        ? [Colors.white, Colors.white]
                        : [ColorUtil.surfaceDark, ColorUtil.surfaceDark]),
            borderRadius: BorderRadius.circular(14.r)),
        child: Center(
          child: Text(
            filterText,
            style: FontStyleUtilities.h5(
                    height: 1,
                    fontWeight: FWT.regular,
                    fontColor: isSelected
                        ? Colors.white
                        : isLight
                            ? Colors.black
                            : Colors.white)
                .copyWith(fontSize: 18.sp),
          ),
        ),
      ),
    );
  }
}
