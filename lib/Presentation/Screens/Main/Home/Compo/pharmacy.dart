import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Home/pharmacies.dart';
import 'package:medix/Data/Model/Home/pharmacy.dart';
import 'package:medix/Presentation/Screens/Main/Home/Compo/bottomnav.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Widgets/rowwrapper.dart';
import '../../../pharmacy/compo/product.dart';
import '../../../product detail/productdetail.dart';

class Pharmacy extends StatelessWidget {
  const Pharmacy({Key? key, required this.onTap}) : super(key: key);
  final ValueChanged<PharmacyModel> onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          RowWrapper(
            onTap: () {
              NavigationUtil.to(
                  context,
                  const BottomNav(
                    index: 1,
                  ));
            },
            textStyle: FontStyleUtilities.h5(fontWeight: FWT.medium).copyWith(
                fontSize: 19.sp, color: isLight ? Colors.black : Colors.white),
            textRightStyle: FontStyleUtilities.h5(
                fontColor:
                    isLight ? Colors.black.withOpacity(0.5) : Colors.white),
          ),
          SizedBox(
            height: 250.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 20.w),
                PharmacyCard(
                    onTap: () {
                      onTap(pharmacies[0]);
                    },
                    pharmacyModel: pharmacies[0]),
                PharmacyCard(
                    onTap: () {
                      onTap(pharmacies[1]);
                    },
                    pharmacyModel: pharmacies[1]),
                PharmacyCard(
                    onTap: () {
                      onTap(pharmacies[0]);
                    },
                    pharmacyModel: pharmacies[0]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PharmacyCard extends StatelessWidget {
  const PharmacyCard(
      {Key? key, required this.pharmacyModel, required this.onTap})
      : super(key: key);
  final PharmacyModel pharmacyModel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () {
        NavigationUtil.to(
            context,
            ProductDetail(
              productModel: productlist2[2],
            ));
      },
      child: Container(
        height: 213.h,
        width: 150.w,
        margin: EdgeInsets.only(right: 16.w, top: 18.h, bottom: 18.h),
        padding: EdgeInsets.all(6.h),
        decoration: BoxDecoration(
            color: isLight ? Colors.white : ColorUtil.surfaceDark,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                  color: isLight
                      ? const Color(0xff6E9ECE).withOpacity(.25)
                      : const Color(0xff6E9ECE).withOpacity(.1),
                  blurRadius: 10,
                  offset: const Offset(4, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Stack(
                children: [
                  Image.asset(
                    pharmacyModel.image,
                    width: double.infinity,
                    height: 116.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10.h,
                    left: 6.w,
                    child: GlassContainer(
                      color: isLight
                          ? Colors.white.withOpacity(.35)
                          : ColorUtil.onDarkSurface,
                      height: 20.h,
                      padding: EdgeInsets.symmetric(horizontal: 9.w),
                      borderRadius: BorderRadius.circular(4.r),
                      child: Text(
                        pharmacyModel.tag,
                        style: FontStyleUtilities.t5(
                            fontWeight: FWT.medium,
                            fontColor: isLight ? Colors.black : Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 11.57.h),
            Text(
              pharmacyModel.name,
              style: FontStyleUtilities.h6(
                  fontWeight: FWT.medium,
                  fontColor: isLight ? Colors.black : Colors.white),
            ),
            Row(
              children: [
                Text(
                  pharmacyModel.cityName,
                  style: FontStyleUtilities.t1(
                      fontWeight: FWT.medium,
                      fontColor: isLight
                          ? Colors.black.withOpacity(.50)
                          : Colors.white.withOpacity(.90)),
                ),
                SizedBox(width: 8.w),
                Text(
                  '(${pharmacyModel.distance} km)',
                  style: FontStyleUtilities.t1(
                      fontWeight: FWT.regular,
                      fontColor: isLight
                          ? Colors.black.withOpacity(.50)
                          : Colors.white.withOpacity(.90)),
                ),
              ],
            ),
            Text(
              pharmacyModel.subtitle,
              style: FontStyleUtilities.t1(
                  fontWeight: FWT.regular,
                  fontColor: isLight
                      ? Colors.black.withOpacity(.30)
                      : Colors.white.withOpacity(.70)),
            ),
          ],
        ),
      ),
    );
  }
}
