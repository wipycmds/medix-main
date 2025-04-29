import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:medix/Presentation/Screens/product%20detail/productdetail.dart';

import 'package:medix/Utils/color_utils.dart';

import '../../../../Utils/font_style.dart';
import '../../../../Utils/navigation_util.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      required this.index,
      required this.productModel,
      required this.onTap})
      : super(key: key);
  final ProductModel productModel;
  final int index;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap ??
          () {
            NavigationUtil.to(
                context,
                ProductDetail(
                  productModel: productModel,
                ));
          },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isLight ? Colors.white : ColorUtil.surfaceDark,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            width: 1,
            color: isLight
                ? const Color.fromRGBO(242, 244, 245, 1)
                : ColorUtil.lightTextColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Stack(
                  children: [
                    Image.asset(
                      productModel.image,
                      width: double.infinity,
                      height: 97.h,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 5.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: productModel.discount == 'New'
                                ? Colors.green
                                : ColorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text(
                            productModel.discount,
                            style: FontStyleUtilities.t4(
                                fontWeight: FWT.semiBold,
                                fontColor: Colors.white),
                          ),
                        ))
                  ],
                )),
            SizedBox(height: 10.h),
            Review(
                text: productModel.rating.toString(),
                subText: productModel.review.toString(),
                isLight: isLight),

            SizedBox(height: 5.h),
            Text(
              productModel.name,
              style: FontStyleUtilities.t2(
                  letterSpacing: 0.4,
                  fontWeight: FWT.semiBold,
                  height: 1.3,
                  fontColor: isLight ? Colors.black : Colors.white),
            ),

            Text(
              productModel.quantity,
              style: FontStyleUtilities.t1(
                  fontWeight: FWT.medium,
                  fontColor: isLight
                      ? Colors.black.withOpacity(.50)
                      : Colors.white.withOpacity(.90)),
            ),
            SizedBox(height: 4.6.h),
            PriceWidget(
                text: productModel.price.toStringAsFixed(2),
                subText: productModel.discount,
                isLight: isLight),
          ],
        ),
      ),
    );
  }
}

class Review extends StatelessWidget {
  const Review(
      {Key? key,
      required this.text,
      required this.subText,
      required this.isLight,
      this.textStyle})
      : super(key: key);

  final String text, subText;
  final bool isLight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Color.fromRGBO(255, 210, 17, 1),
          size: 16,
        ),
        Text('  $text',
            style: textStyle ??
                FontStyleUtilities.t5(
                  fontWeight: FWT.medium,
                  fontColor:
                      isLight ? Colors.black.withOpacity(.50) : Colors.white,
                )),
        Text(
          ' ($subText)',
          style: textStyle ??
              FontStyleUtilities.t5(
                  fontWeight: FWT.medium,
                  fontColor:
                      isLight ? Colors.black.withOpacity(.50) : Colors.white),
        ),
      ],
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    this.textStyle,
    this.subTextStyle,
    required this.text,
    required this.subText,
    required this.isLight,
  }) : super(key: key);

  final String text, subText;
  final bool isLight;
  final TextStyle? textStyle, subTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$$text  ',
          style: textStyle ??
              FontStyleUtilities.t4(
                  fontWeight: FWT.semiBold,
                  fontColor:
                      isLight ? Colors.black : Colors.white.withOpacity(.90)),
        ),
        Text(
          '\$110.00',
          style: subTextStyle ??
              FontStyleUtilities.t5(
                  isLineThrough: true,
                  fontWeight: FWT.semiBold,
                  fontColor: isLight
                      ? Colors.black.withOpacity(.50)
                      : Colors.white.withOpacity(.90)),
        ),
      ],
    );
  }
}
