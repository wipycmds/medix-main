import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/order/ordertrack.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';
import 'package:medix/Utils/navigation_util.dart';

import '../Clinic_flow/hospital_list/Compo/detail.dart';
import '../pharmacy/compo/product.dart';
import '../product detail/compo/specialization.dart';
import '../shopping/compo/listwrapper.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          OrderDetail(
            isLight: isLight,
            text: '8 September, 2022',
            list: productlist4,
            status: 'Pending',
          ),
          SizedBox(
            height: 20.h,
          ),
          OrderDetail(
            isLight: isLight,
            text: '6 September, 2022',
            list: productlist4,
            status: 'Processing',
          ),
        ],
      ),
    );
  }
}

class OrderDetail extends StatefulWidget {
  const OrderDetail({
    Key? key,
    required this.isLight,
    required this.list,
    this.status = '',
    this.text = '',
  }) : super(key: key);

  final bool isLight;
  final List list;
  final String text, status;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int visibleItems = 2;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var t2 = FontStyleUtilities.t2(
        fontWeight: FWT.semiBold, fontColor: ColorUtil.primaryColor);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: FontStyleUtilities.t2(
                  fontWeight: FWT.semiBold,
                  fontColor: widget.isLight ? ColorUtil.blue : Colors.white),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.isLight ? Colors.black12 : Colors.white12),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.list
                      .asMap()
                      .entries
                      .map((e) => ListWrapper(
                            image: e.value.image,
                            totalCounter: (double value) {
                              // setState(() {
                              //   totalCount = value;
                              // });
                            },
                            total: 0,
                            key: ValueKey(e.key),
                            length: productlist4.length,
                            text: e.value.name,
                            isLast: widget.list.length - 1 == e.key,
                            model: e.value,
                            price: e.value.price,
                            isCheckout: true,
                          ))
                      .toList()
                      .take(visibleItems),
                  visibleItems == 4
                      ? const SizedBox()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 16.w),
                          child: SizedBox(
                            width: 120.w,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  visibleItems = 4;
                                });
                              },
                              child: Text(
                                '2 Items order',
                                style: t2,
                              ),
                            ),
                          )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: widget.isLight
                                  ? Colors.black12
                                  : Colors.white12)),
                    ),
                    padding: EdgeInsets.only(
                      top: 12.h,
                      bottom: 10.h,
                      right: 16.w,
                      left: 16.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Total: ',
                              style: FontStyleUtilities.t2(
                                  fontWeight: FWT.semiBold,
                                  fontColor: widget.isLight
                                      ? ColorUtil.blue
                                      : Colors.white),
                              children: [
                                TextSpan(
                                    text: '\$ ${totalCounting.value}',
                                    style: t2)
                              ]),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkResponse(
                            onTap: () {
                              NavigationUtil.to(context, const OrderTrack());
                            },
                            child: DetailTag(isLight: widget.isLight),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
            right: 20.w,
            child: Colorbox(
              counting: widget.status,
              width: 90.w,
              backwidth: 70.w,
              height: 22.h,
              backColor: isLight ? Colors.white : ColorUtil.scaffoldDark,
              color: widget.status == 'Pending'
                  ? ColorUtil.pendingYellow
                  : ColorUtil.primaryColor,
            ))
      ],
    );
  }
}
