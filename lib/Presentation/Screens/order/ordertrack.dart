import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/order/compo/ordertracker.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:medix/Presentation/Screens/shopping/compo/listwrapper.dart';
import 'package:medix/Presentation/Widgets/back_button.dart';
import 'package:medix/Presentation/Widgets/rowwrapper.dart';
import 'package:medix/Utils/font_style.dart';

import '../../../Utils/color_utils.dart';

class OrderTrack extends StatefulWidget {
  const OrderTrack({Key? key}) : super(key: key);

  @override
  State<OrderTrack> createState() => _OrderTrackState();
}

class _OrderTrackState extends State<OrderTrack> {
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? Colors.white : ColorUtil.scaffoldDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      const MyBackButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                      ),
                    ]),
                actions: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.report)),
                    SizedBox(
                      height: 15.h,
                    ),
                  ]),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Order Detail',
                        style: FontStyleUtilities.h3(
                            fontColor: Colors.white, fontWeight: FWT.semiBold),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ]),
                automaticallyImplyLeading: false,
                toolbarHeight: 90.h,
                titleSpacing: 2,
                collapsedHeight: 105.h,
                expandedHeight: 90.h,
                centerTitle: false,
                backgroundColor: ColorUtil.primaryColor,
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: 200.w,
                  height: 470.h,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color:
                                  isLight ? Colors.black12 : Colors.white12))),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderDate(),
                      OrderTracker(),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 16.h, left: 24.w, bottom: 6.h),
                sliver: SliverToBoxAdapter(
                    child: Text('Description',
                        style: FontStyleUtilities.h5(
                          fontWeight: FWT.semiBold,
                          fontColor: isLight ? ColorUtil.blue : Colors.white,
                        ))),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 16.h),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  ...productlist3
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 5.h),
                            child: ListWrapper(
                              image: e.value.image,
                              totalCounter: (double value) {
                                // setState(() {
                                //   totalCount = value;
                                // });
                              },
                              sideBorder: false,
                              total: 0,
                              key: ValueKey(e),
                              length: 0,
                              text: e.value.name,
                              isLast: productlist3.length - 1 == e.key,
                              model: e.value,
                              price: e.value.price,
                              isCheckout: true,
                            ),
                          ))
                      
                ])),
              ),
              SliverToBoxAdapter(
                  child: Divider(
                thickness: 8,
                color: isLight ? Colors.grey[200] : Colors.white12,
              )),
              SliverPadding(
                padding: EdgeInsets.only(
                    left: 8.w, right: 8.w, top: 16.h, bottom: 24.h),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      RowWrapper(
                        text: 'Total deal',
                        textRightStyle:
                            fontstyle(isLight ? ColorUtil.blue : Colors.white),
                        textStyle:
                            fontstyle(isLight ? ColorUtil.blue : Colors.white),
                        textright: '\$260',
                        child: const SizedBox(),
                      ),
                      RowWrapper(
                        text: 'Tax',
                        textright: '-\$40',
                        textRightStyle: fontstyle(ColorUtil.primaryColor),
                        textStyle:
                            fontstyle(isLight ? ColorUtil.blue : Colors.white),
                        child: const SizedBox(),
                      ),
                      RowWrapper(
                        text: 'Total',
                        textStyle:
                            fontstyle(isLight ? ColorUtil.blue : Colors.white),
                        textRightStyle: fontstyle(ColorUtil.primaryColor),
                        textright: '\$300',
                        child: const SizedBox(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 115.h,
            child: Container(
              height: 30.h,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: isLight ? Colors.white : ColorUtil.scaffoldDark,
                  border: Border.all(width: 0, color: Colors.transparent),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r))),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle fontstyle(Color color) => FontStyleUtilities.t1(
      fontWeight: FWT.semiBold, fontColor: color, height: 2);
}
