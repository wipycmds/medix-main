import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Data/Model/Home/doctor.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
    required this.info,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);
  final bool? selected;
  final VoidCallback onTap;
  final DoctorModel info;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 161.h,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        decoration: BoxDecoration(
            border: selected!
                ? Border.all(width: 2, color: ColorUtil.primaryColor)
                : Border.all(width: 2, color: Colors.transparent),
            borderRadius: BorderRadius.circular(15.r),
            color: isLight ? Colors.white : ColorUtil.surfaceDark),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: SizedBox(
                width: 120.w,
                height: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.asset(
                      info.image,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 8.w, top: 8.h, bottom: 10.h, right: 17.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(info.name.shrink(17),
                        style: FontStyleUtilities.h4(
                                fontWeight: FWT.medium,
                                fontColor:
                                    isLight ? Colors.black : Colors.white)
                            .copyWith(fontSize: 22)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            info.degree,
                            style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: isLight
                                    ? Colors.black.withOpacity(.50)
                                    : Colors.white.withOpacity(.70)),
                          ),
                          Text(
                            '(${info.reviews} Reviews)',
                            style: FontStyleUtilities.t2(
                                fontWeight: FWT.regular,
                                fontColor: isLight
                                    ? Colors.black.withOpacity(.30)
                                    : Colors.white.withOpacity(.60)),
                          ),
                        ]),
                    2.height(),
                    Text(
                      '${info.experience} years Experience',
                      style: FontStyleUtilities.t2(
                          fontWeight: FWT.regular,
                          fontColor: isLight
                              ? Colors.black.withOpacity(.30)
                              : Colors.white.withOpacity(.60)),
                    ),
                    10.height(),
                    Row(
                      children: [
                        TagIconWrapper(
                            padding: 9,
                            icon: 'assets/Icons/3 Friends.svg',
                            param: 'Patient',
                            value: '${info.patient}+'),
                        19.width(),
                        TagIconWrapper(
                            scale: .5,
                            icon: 'assets/Icons/Star.svg',
                            param: 'Rating',
                            value: '${info.averageRating}+'),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TagIconWrapper extends StatelessWidget {
  const TagIconWrapper(
      {Key? key,
      this.padding,
      required this.icon,
      required this.param,
      required this.value,
      this.scale})
      : super(key: key);
  final String icon, param, value;
  final double? padding, scale;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        TagIconBox(
          isLight: isLight,
          scale: scale,
          icon: icon,
          padding: padding,
        ),
        8.58.width(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              param,
              style: FontStyleUtilities.t4(
                  fontWeight: FWT.regular,
                  fontColor: isLight
                      ? Colors.black.withOpacity(.50)
                      : Colors.white.withOpacity(.70)),
            ),
            Text(
              value,
              style: FontStyleUtilities.t4(
                  fontWeight: FWT.semiBold,
                  fontColor: isLight
                      ? Colors.black.withOpacity(.50)
                      : Colors.white.withOpacity(.70)),
            ),
          ],
        )
      ],
    );
  }
}

class TagIconBox extends StatelessWidget {
  const TagIconBox({
    Key? key,
    required this.icon,
    this.padding,
    required this.isLight,
    this.scale,
  }) : super(key: key);
  final String icon;
  final bool isLight;
  final double? padding, scale;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      height: 34.h,
      width: 34.44.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: isLight
                  ? Colors.black.withOpacity(.10)
                  : Colors.white.withOpacity(.10)),
          borderRadius: BorderRadius.circular(8.r)),
      child: Transform.scale(
        scale: scale ?? 1,
        child: SvgIcon(
          icon,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
