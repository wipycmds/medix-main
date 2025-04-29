import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Widgets/icons_wrapper.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';
import '../product detail/compo/paragraph.dart';
import 'compo/textwrapper.dart';

class ProductViewDetail extends StatefulWidget {
  const ProductViewDetail({Key? key}) : super(key: key);

  @override
  State<ProductViewDetail> createState() => _ProductViewDetailState();
}

class _ProductViewDetailState extends State<ProductViewDetail>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  int currentIndex = 0;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (controller.indexIsChanging) {
          setState(() {
            currentIndex == controller.index;
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var size2 = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      initialIndex: currentIndex,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(slivers: [
              const SliverAppBar(
                backgroundColor: ColorUtil.primaryColor,
                automaticallyImplyLeading: false,
                pinned: true,
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(0.w, 66.h, 0.w, 24.h),
                sliver: SliverToBoxAdapter(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Container(
                      height: 800.h,
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight,
                      ),
                      child: TabBarView(controller: controller, children: const [
                        DetailWidget(heading: 'Detail', paragraph: paragraph),
                        DetailWidget(
                            heading: 'How to Use',
                            image: 'assets/Images/Temp/use.png',
                            isTextIndexed: false,
                            paragraph: []),
                      ]),
                    );
                  }),
                ),
              ),
            ]),
            Positioned(
                top: 50.h,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    width: 375.w,
                    height: 110.h,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: isLight ? Colors.white : ColorUtil.scaffoldDark,
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: isLight
                                    ? const Color.fromRGBO(242, 244, 245, 1)
                                    : Colors.white12))),
                    child: TabBar(
                        isScrollable: true,
                        controller: controller,
                        padding: const EdgeInsets.all(01),
                        indicator: UnderlineTabIndicator(
                            borderSide: const BorderSide(
                                width: 2, color: ColorUtil.primaryColor),
                            insets: EdgeInsets.symmetric(horizontal: 12.w)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 22.w),
                        labelColor: ColorUtil.primaryColor,
                        indicatorColor: ColorUtil.primaryColor,
                        unselectedLabelColor: isLight
                            ? ColorUtil.lightTextColor
                            : const Color.fromRGBO(242, 244, 245, 1),
                        labelStyle:
                            FontStyleUtilities.h5(fontWeight: FWT.semiBold),
                        indicatorSize: TabBarIndicatorSize.label,
                        onTap: (value) {
                          controller.index == value;
                          setState(() {});
                        },
                        tabs: const [
                          Tab(
                            text: 'Detail',
                          ),
                          Tab(
                            text: 'How to Use',
                          ),
                          Tab(text: 'Review')
                        ]),
                  ),
                )),
            Positioned(
              right: 0,
              top: 50.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconWrapper(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: isLight ? Colors.black : Colors.white,
                  padding: 10,
                  icon: 'assets/Icons/close.svg',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    required this.heading,
    required this.paragraph,
    this.isTextIndexed = true,
    this.isSubHead = false,
    this.headsize = 17,
    this.image,
  }) : super(key: key);

  final String? image;
  final double headsize;
  final bool isTextIndexed;
  final bool isSubHead;

  final String heading;
  final List paragraph;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var size2 = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading != ''
              ? Text(
                  heading,
                  style: FontStyleUtilities.h5(
                          fontColor: isLight ? ColorUtil.blue : Colors.white,
                          fontWeight: FWT.semiBold)
                      .copyWith(fontSize: headsize),
                )
              : SizedBox(
                  height: 6.h,
                ),
          heading != ''
              ? const SizedBox()
              : SizedBox(
                  height: 6.h,
                ),
          isSubHead
              ? Text(
                  'Read the instructions carefully',
                  style: FontStyleUtilities.h5(
                      fontColor: isLight ? ColorUtil.blue : Colors.white,
                      fontWeight: FWT.semiBold),
                )
              : const SizedBox(),
          isSubHead
              ? SizedBox(
                  height: 16.h,
                )
              : const SizedBox(),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 184.h,
              width: size2.width,
              color: Colors.lightBlueAccent.withOpacity(0.4),
              child: Image.asset(
                image ?? 'assets/Images/Temp/BG.png',
                fit: isTextIndexed ? BoxFit.fitHeight : BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          isTextIndexed
              ? Text(
                  'Description',
                  style: FontStyleUtilities.h5(
                      fontColor: isLight ? ColorUtil.blue : Colors.white,
                      fontWeight: FWT.semiBold),
                )
              : const SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          Column(
            children: isTextIndexed
                ? [
                    ...paragraph
                        .map((e) => TextWrapper(text: e, isLight: isLight))
                        
                  ]
                : [
                    ...paragraph
                        .map((e) => TextWrapper(
                            text: e, isLight: isLight, isDot: false))
                        
                  ],
          ),
        ],
      ),
    );
  }
}
