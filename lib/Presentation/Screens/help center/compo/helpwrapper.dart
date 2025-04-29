import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/help%20center/helpcenter.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';
import 'package:medix/Utils/navigation_util.dart';

import '../../../Widgets/svg_icon.dart';

class HelpWrapper extends StatelessWidget {
  const HelpWrapper({Key? key, this.headText = '', required this.icon})
      : super(key: key);

  final String headText;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Row(
            children: [
              SvgIcon(
                icon,
                width: 15.w,
                height: 15.h,
                color: ColorUtil.primaryColor,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                headText,
                style: FontStyleUtilities.h6(
                    fontColor: ColorUtil.primaryColor,
                    fontWeight: FWT.semiBold),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }
}

class HelpChild extends StatelessWidget {
  const HelpChild({Key? key, this.headText = '', this.onTap}) : super(key: key);

  final String headText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var size2 = MediaQuery.of(context).size;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Material(
      color: Colors.transparent,
      child: Container(
        width: size2.width,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: isLight ? Colors.black12 : Colors.white12,
        ))),
        child: InkWell(
          splashColor: isLight ? Colors.white12 : Colors.white12,
          highlightColor: isLight ? Colors.black12 : ColorUtil.surfaceDark,
          onTap: onTap ??
              () {
                NavigationUtil.to(
                    context,
                    HelpCenter(
                      headText: headText,
                      nodetails: false,
                    ));
              },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headText,
                  style: FontStyleUtilities.t2(
                      fontWeight: FWT.semiBold,
                      fontColor: isLight ? ColorUtil.blue : Colors.white),
                ),
                SvgIcon(
                  'assets/Icons/Arrow - Right 2.svg',
                  color: isLight ? ColorUtil.lightTextColor : Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
