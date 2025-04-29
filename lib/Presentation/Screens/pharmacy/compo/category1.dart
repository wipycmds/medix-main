import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/category.dart';
import 'package:medix/Presentation/Widgets/pharmacyscaffold.dart';
import 'package:medix/Utils/navigation_util.dart';
import '../prescriptiondrugs.dart';
import 'cardwrapper.dart';

class Category1 extends StatelessWidget {
  const Category1(
      {Key? key,
      required this.category,
      this.isReversed = false,
      this.height = 160,
      this.onTap})
      : super(key: key);

  final bool isReversed;
  final VoidCallback? onTap;
  final double height;
  final List<Category> category;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffkey = GlobalKey<ScaffoldState>();
    var size2 = MediaQuery.of(context).size;
    return SizedBox(
      height: height.h,
      width: size2.width,
      child: ListView.builder(
        itemCount: category.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 3.h),
        itemBuilder: (context, index) {
          return CardWrapper(
            onTap: onTap ??
                () {
                  NavigationUtil.to(
                    context,
                    PharmacyScaffold(
                        scaffkey: scaffkey, child: const PrescriptionDrugs()),
                  );
                },
            image: category[index].image,
            text: category[index].text,
          );
        },
      ),
    );
  }
}
