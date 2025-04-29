import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/product.dart';
import 'package:medix/Presentation/Screens/pharmacy/compo/staggeredwrapper.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/paragraph.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/specialization.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/specializewidget.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/tablist.dart';
import 'package:medix/Presentation/Widgets/icons_wrapper.dart';
import 'package:medix/Presentation/Widgets/rowwrapper.dart';
import 'package:medix/Presentation/Widgets/sliver_bar.dart';
import 'package:medix/Presentation/Widgets/sliver_sized_box.dart';
import 'package:medix/Utils/utils.dart';

import '../../Widgets/button.dart';
import '../../Widgets/svg_icon.dart';
import '../pharmacy/compo/onlinepharmacycard.dart';
import '../pharmacy/onlinepharmacy.dart';
import '../shopping/productview.dart';
import 'compo/reviewwidget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.productModel}) : super(key: key);

  final ProductModel productModel;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  late PageController controller;

  int pageIndicate = 0;

  bool setColor = false;

  late TabController controller1;
  late ScrollController scontroller;

  String widgetSet = '';

  int index = 0;

  @override
  void initState() {
    controller1 = TabController(length: tabs.length, vsync: this);
    controller = PageController();
    height.value = 690.h;
    scontroller = ScrollController()
      ..addListener(() {
        if (scontroller.hasClients && scontroller.position.pixels > 285) {
          setState(() {
            widgetSet = widget.productModel.name;
          });
        } else {
          setState(() {
            widgetSet = '';
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();

    super.dispose();
  }

  List<Widget> tabs = [
    const DetailWidget(heading: 'Detail', paragraph: paragraph),
    DetailWidget(
        heading: 'How to Use',
        image: 'assets/Images/Temp/use.png',
        isTextIndexed: false,
        isSubHead: true,
        paragraph: paragraph2),
    const ReviewWidget(
      list: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var size2 = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        controller: scontroller,
        slivers: [
          SliverBar(
            backcolor: Colors.black,
            titleWidget: widgetSet != '' ? Text(widgetSet) : const SizedBox(),
            backgroundColor: isLight ? Colors.grey[100] : ColorUtil.surfaceDark,
            widget: PageView.builder(
                itemCount: 4,
                pageSnapping: true,
                controller: controller,
                padEnds: false,
                onPageChanged: (value) {
                  setState(() {
                    pageIndicate = value;
                  });
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Image.asset('assets/Images/Temp/BG.png');
                }),
            mainChild: Positioned(
              bottom: 48.h,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++)
                      DotIndicator(
                        color: isLight ? Colors.black87 : Colors.white,
                        unhighlightcolor:
                            isLight ? Colors.black26 : Colors.grey[700],
                        isIndicate: i == pageIndicate,
                      )
                  ],
                ),
              ),
            ),
            bottomHeight: 40.h,
            expandedHeight: 411.h,
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 10.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowWrapper(
                    horizontalpad: 24.w,
                    text: widget.productModel.name,
                    textStyle: FontStyleUtilities.h3(
                        fontWeight: FWT.semiBold,
                        fontColor: isLight ? ColorUtil.blue : Colors.white),
                    textright: '',
                    child: SizedBox(
                      height: 30.h,
                      child: IconWrapper(
                          onTap: () {
                            setState(() {
                              setColor = !setColor;
                            });
                          },
                          padding: 4,
                          color: setColor ? Colors.red : Colors.grey[200],
                          icon: 'assets/Icons/Heart.svg'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: TabletWrap(isLight: isLight),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, bottom: 6.h),
                    child: PriceWidget(
                        textStyle: FontStyleUtilities.h4(
                            fontWeight: FWT.semiBold,
                            fontColor: ColorUtil.primaryColor),
                        subTextStyle: FontStyleUtilities.t2(
                          fontWeight: FWT.semiBold,
                          isLineThrough: true,
                          height: 2,
                          fontColor: isLight ? Colors.grey[700] : Colors.white,
                        ),
                        text: widget.productModel.price.toStringAsFixed(2),
                        subText: widget.productModel.price.toStringAsFixed(2),
                        isLight: isLight),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, bottom: 16.h),
                    child: Row(
                      children: [
                        Review(
                            text: widget.productModel.rating.toString(),
                            subText: '${widget.productModel.review} reviews',
                            textStyle: FontStyleUtilities.t3(
                              fontWeight: FWT.semiBold,
                              fontColor: isLight
                                  ? Colors.black.withOpacity(.50)
                                  : Colors.white,
                            ),
                            isLight: isLight),
                        Text(
                          '     |    ',
                          style: FontStyleUtilities.t3(
                              fontWeight: FWT.bold,
                              fontColor: Colors.grey[800]),
                        ),
                        Text(
                          '10 in Stock',
                          style: FontStyleUtilities.t3(
                              fontWeight: FWT.semiBold,
                              fontColor:
                                  isLight ? ColorUtil.blue : Colors.white),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: SizedBox(
                            width: 98.w,
                            child: LinearProgressIndicator(
                              color: Colors.green,
                              value: 0.5,
                              valueColor: const AlwaysStoppedAnimation<Color?>(
                                  Colors.green),
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.6,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, bottom: 6.h),
                    child: Text(
                      'Specifications',
                      style: FontStyleUtilities.t2(
                          fontColor: isLight
                              ? ColorUtil.blue
                              : Colors.white.withOpacity(0.8),
                          fontWeight: FWT.semiBold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130.h,
                    padding: EdgeInsets.only(left: 24.w, top: 10.h),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: specializations.length,
                      itemBuilder: (context, index) {
                        return SpecializeWidget(
                          icon: specializations[index].icon,
                          subColor: isLight
                              ? ColorUtil.lightTextColor
                              : Colors.white.withOpacity(0.75),
                          text: specializations[index].text,
                          subText: specializations[index].subText,
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                              mainAxisExtent: 44,
                              crossAxisCount: 2),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  RowWrapper(
                    text: 'Medix Pharmacy',
                    textStyle: FontStyleUtilities.t1(
                        fontWeight: FWT.semiBold,
                        fontColor: isLight ? ColorUtil.blue : Colors.white),
                    textright: '',
                    child: const SizedBox(),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 293.h,
                      margin: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 10.h),
                      padding: EdgeInsets.only(
                          left: 25.w, right: 25.w, top: 27.h, bottom: 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: isLight ? Colors.black12 : Colors.white10),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...medixpharmacy
                              .map((e) => SpecializeWidget(
                                    icon: e.icon,
                                    text: e.text,
                                    subText: e.subText,
                                    color: ColorUtil.primaryColor,
                                    subColor: e.text == 'Hotline'
                                        ? Colors.red
                                        : isLight
                                            ? const Color.fromRGBO(94, 111, 136, 1)
                                            : Colors.white.withOpacity(0.75),
                                    time: e.time
                                        .map<String>((e) => e.toString())
                                        .toList(),
                                  ))
                              
                        ],
                      )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TabList(
              controller: controller1,
              onChanged: (int value) {
                setState(() {
                  index = value;
                });
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([tabs[index]]),
            ),
          ),
          const SliverToBoxAdapter(
            child: RowWrapper(
              text: 'Feature Products',
              textright: '',
              child: SizedBox(),
            ),
          ),
          SliverSizedBox(
            height: 16.h,
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 24.w),
            sliver: const SliverToBoxAdapter(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StaggeredWrapper(productList: productlist)),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            sliver: SliverToBoxAdapter(
              child: Button(
                  tittle: 'Add To Cart',
                  onTap: () async {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: ColorUtil.primaryColor,
                        content: SizedBox(
                          width: 300.w,
                          child: Row(
                            children: [
                              const SvgIcon('assets/Icons/tick.svg'),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                'Product Added to Cart',
                                style: FontStyleUtilities.t2(
                                    fontColor: Colors.white,
                                    fontWeight: FWT.semiBold),
                              ),
                            ],
                          ),
                        )));
                    await Future.delayed(const Duration(milliseconds: 1000),
                        () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class TabletWrap extends StatelessWidget {
  const TabletWrap({
    Key? key,
    required this.isLight,
    this.size = 14,
    this.text = '50/100/150 Pills',
  }) : super(key: key);

  final bool isLight;
  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Tablets',
          style: FontStyleUtilities.t2(
                  fontWeight: FWT.semiBold,
                  fontColor: isLight ? Colors.grey[500] : Colors.grey[400])
              .copyWith(fontSize: size.sp),
        ),
        SizedBox(
          width: 10.w,
        ),
        DotIndicator(
          radi: 6,
          isIndicate: true,
          color: isLight ? Colors.grey[500] : Colors.grey[400],
        ),
        Text(
          text,
          style: FontStyleUtilities.t2(
                  fontWeight: FWT.semiBold,
                  fontColor: isLight ? Colors.grey[500] : Colors.grey[400])
              .copyWith(fontSize: size.sp),
        ),
      ],
    );
  }
}
