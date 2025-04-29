import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/specialization.dart';
import 'package:medix/Presentation/Widgets/textbutton.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({Key? key, required this.list}) : super(key: key);

  final List list;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    List list2 = [
      [
        'Mr. Gout Le',
        'You probably take vitamins and supplements with the goal of improving your health.'
      ],
      [
        'Mr. Tony Le',
        'I have food allergies and have done a lot of research on behalf of myself and my family when it comes to what is really important in the supplements we take'
      ],
      [
        'Mr. Tau Li',
        'I’m really torn because I like these prenatal vitamins and they don’t make me sick, which most prenatals do.',
      ]
    ];

    var map = list2.map((e) => Container(
          width: 375.w,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0, color: isLight ? Colors.black12 : Colors.white12),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              shape: BoxShape.rectangle),
          padding: EdgeInsets.only(bottom: 14.h, top: 8.h, right: 16.w),
          margin: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(
                    'assets/Images/Temp/profile.png',
                  ),
                ),
                horizontalTitleGap: 2,
                title: Container(
                  height: 47.h,
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e[0],
                        style: FontStyleUtilities.t2(
                            height: 1.3,
                            fontWeight: FWT.semiBold,
                            fontColor: isLight ? ColorUtil.blue : Colors.white),
                      ),
                      Text(
                        '⭐⭐⭐⭐⭐  4.8',
                        style: FontStyleUtilities.t2(
                            fontColor: isLight ? ColorUtil.blue : Colors.white),
                      ),
                    ],
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      '24 Oct, 2021',
                      style: FontStyleUtilities.t2(
                          fontColor: isLight
                              ? ColorUtil.lightTextColor
                              : Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Text(
                  e[1],
                  style: FontStyleUtilities.t2(
                      fontColor: isLight ? ColorUtil.blue : Colors.white),
                ),
              ),
            ],
          ),
        ));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews (234)',
            style: FontStyleUtilities.h5(
                fontColor: isLight ? ColorUtil.blue : Colors.white,
                fontWeight: FWT.semiBold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...map,
              SizedBox(
                height: 10.h,
              ),
              isVisible
                  ? MyTextButton(
                      text: 'View more reviews',
                      onTap: () {
                        setState(() {
                          isVisible = false;
                          height.value = 1170.h;
                        });
                      },
                      icon: Icons.arrow_forward_ios)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [...map])
            ],
          )
        ],
      ),
    );
  }
}
