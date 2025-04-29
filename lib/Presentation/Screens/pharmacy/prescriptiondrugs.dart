import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/analgesic.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/staggeredwrapper.dart';
import 'package:medix/Utils/font_style.dart';
import 'package:medix/Utils/navigation_util.dart';

import '../../Widgets/icons_wrapper.dart';
import '../../Widgets/pharmacyscaffold.dart';
import '../../Widgets/rowwrapper.dart';
import 'compo/category.dart';
import 'compo/category1.dart';

class PrescriptionDrugs extends StatefulWidget {
  const PrescriptionDrugs({Key? key}) : super(key: key);

  @override
  State<PrescriptionDrugs> createState() => _PrescriptionDrugsState();
}

class _PrescriptionDrugsState extends State<PrescriptionDrugs> {
  final GlobalKey<ScaffoldState> scaffkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            'Prescription Drugs',
            style: FontStyleUtilities.h3(
                height: 1.6.h,
                fontWeight: FWT.semiBold,
                fontColor: isLight
                    ? const Color.fromRGBO(17, 41, 80, 1)
                    : Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.w, top: 16.h),
          child: Category1(
              height: 150.h,
              category: categories3,
              onTap: () {
                NavigationUtil.to(
                  context,
                  PharmacyScaffold(
                      nextText: 'Analgesic',
                      button: const ForwardButton(),
                      scaffkey: scaffkey,
                      child: const Analgesic()),
                );
              }),
        ),
        const Divider(
          height: 0,
          thickness: 0.7,
        ),
        SizedBox(
          height: 16.h,
        ),
        RowWrapper(
          text: 'Products',
          textright: '',
          child: IconWrapper(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: 'assets/Icons/Filter.svg',
              padding: 8.r),
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
