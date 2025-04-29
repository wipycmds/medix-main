import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/staggeredwrapper.dart';
import 'package:medix/Presentation/Widgets/rowwrapper.dart';
import 'package:medix/Utils/font_style.dart';

import '../../Widgets/icons_wrapper.dart';
import 'compo/product.dart';

class Analgesic extends StatelessWidget {
  const Analgesic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text('Analgesic',
              style: FontStyleUtilities.h3(
                  height: 1.6.h,
                  fontWeight: FWT.semiBold,
                  fontColor: isLight
                      ? const Color.fromRGBO(17, 41, 80, 1)
                      : Colors.white)),
        ),
        RowWrapper(
          text: 'Products (34)',
          textright: '',
          child: IconWrapper(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: 'assets/Icons/Filter.svg',
              padding: 9),
        ),
        LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: StaggeredWrapper(
                crossCount: 2,
                maxHeight: constraints.maxHeight.h,
                mainAxisCell: 1.45,
                mainAxisOtherCell: 1.4,
                productList: productlist),
          );
        })
      ],
    );
  }
}
