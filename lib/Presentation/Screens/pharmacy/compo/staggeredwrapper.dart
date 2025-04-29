import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/onlinepharmacycard.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../../Utils/navigation_util.dart';
import '../../product detail/productdetail.dart';

class StaggeredWrapper extends StatelessWidget {
  const StaggeredWrapper(
      {Key? key,
      this.crossCount = 3,
      this.isScrollable = false,
      this.mainAxisCell = 1.85,
      this.mainAxisOtherCell = 1.72,
      this.maxHeight = 570,
      required this.productList})
      : super(key: key);

  final List<ProductModel> productList;
  final bool isScrollable;
  final double maxHeight;
  final double mainAxisCell, mainAxisOtherCell;
  final int crossCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: 240.h,
          maxHeight: maxHeight.h,
          minWidth: 370.w,
          maxWidth: 388.w),
      child: StaggeredGridView.count(
        crossAxisCount: crossCount,
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        physics: isScrollable
            ? const ScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        staggeredTiles: [
          StaggeredTile.count(1, mainAxisCell),
          StaggeredTile.count(1, mainAxisOtherCell),
          StaggeredTile.count(1, mainAxisCell),
          StaggeredTile.count(1, mainAxisCell),
          StaggeredTile.count(1, mainAxisOtherCell),
          StaggeredTile.count(1, mainAxisOtherCell)
        ],
        children: [
          for (int i = 0; i < productList.length; i++)
            ProductCard(
              index: i,
              productModel: productList[i],
              onTap: () {
                NavigationUtil.to(
                    context,
                    ProductDetail(
                      productModel: productList[i],
                    ));
              },
            )
        ],
      ),
    );
  }
}
