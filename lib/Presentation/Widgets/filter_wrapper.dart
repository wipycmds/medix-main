import 'package:flutter/material.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/package/packages.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'filter_tile.dart';

class FilterWrapper<T> extends StatelessWidget {
  const FilterWrapper(
      {Key? key,
      required this.filterList,
      required this.filterController,
      required this.onTap,
      this.radio = false})
      : super(key: key);
  final List<String> filterList;
  final FilterController filterController;
  final ValueChanged<int> onTap;
  final bool? radio;
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filterList.length,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 10.w,
        shrinkWrap: true,
        crossAxisCount: 2,
        itemBuilder: (context, int index) => AnimatedBuilder(
              animation: filterController,
              builder: (context, child) => FilterTile(
                  onTap: () {
                    !radio!
                        ? filterController.addAsGroup(filterList[index])
                        : filterController.addAsRadio(filterList[index]);
                    onTap(index);
                  },
                  isSelected:
                      filterController.filters.contains(filterList[index]),
                  filterText: filterList[index]),
            ),
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1));
  }
}
