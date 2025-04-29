import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/shopping/productview.dart';

import '../../../../Utils/color_utils.dart';
import '../../../../Utils/font_style.dart';
import '../../../Widgets/back_button.dart';
import '../../../Widgets/sliver_bar.dart';
import '../../product detail/compo/paragraph.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: ColorUtil.primaryColor,
                leading: const MyBackButton(
                  color: Colors.white,
                ),
                collapsedHeight: 90.h,
                expandedHeight: 80.h,
                title: Text(
                  'About Us',
                  style: FontStyleUtilities.h3(
                      fontColor: Colors.white, fontWeight: FWT.semiBold),
                ),
              ),
              const SliverPadding(
                padding:
                    EdgeInsets.only(left: 24, top: 0, bottom: 20, right: 24),
                sliver: SliverToBoxAdapter(
                  child: DetailWidget(
                    heading: '',
                    headsize: 32,
                    paragraph: aboutus,
                    isTextIndexed: false,
                    image: 'assets/Images/Temp/aboutus.png',
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 100.h,
            child: RoundedContainer(
              bottomHeight: 35.h,
              borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
            ),
          ),
        ],
      ),
    );
  }
}
