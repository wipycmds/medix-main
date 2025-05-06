import 'package:flutter/material.dart';
import 'package:medix/Data/Model/Clinic/clinic_visit_card.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClinicVisitCard extends StatelessWidget {
  const ClinicVisitCard({
    Key? key,
    required this.info,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);
  final bool? selected;
  final VoidCallback onTap;
  final ClinicVisitCardModel info;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        decoration: BoxDecoration(
            border: selected!
                ? Border.all(width: 2, color: ColorUtil.primaryColor)
                : Border.all(width: 2, color: Colors.transparent),
            borderRadius: BorderRadius.circular(15.r),
            color: isLight ? Colors.white : ColorUtil.surfaceDark),
        child: Row(
          children: [
            SizedBox(
              width: 129.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      bottomLeft: Radius.circular(15.r)),
                  child: Image.asset(
                    info.image,
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.w, top: 8.h, bottom: 10.h, right: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.name,
                          style: FontStyleUtilities.h4(
                                  fontWeight: FWT.medium,
                                  fontColor:
                                      isLight ? Colors.black : Colors.white)
                              .copyWith(fontSize: 20)),
                      Text(
                        "${info.hospitalCount} Doctors",
                        style: FontStyleUtilities.h6(
                            fontWeight: FWT.medium,
                            fontColor: isLight
                                ? Colors.black.withOpacity(.50)
                                : Colors.white),
                      ),
                      // SizedBox(height: 6.h),
                      // Text('\$${info.lowestCharge}-\$${info.highestCharge}',
                      //     style: FontStyleUtilities.h6(
                      //             fontWeight: FWT.medium,
                      //             fontColor: ColorUtil.primaryColor)
                      //         .copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SvgIcon('assets/Icons/Time.svg'),
                          SizedBox(width: 1.w),
                          Text(
                            'Available time',
                            style: FontStyleUtilities.t2(
                                height: 1,
                                fontWeight: FWT.regular,
                                fontColor: isLight
                                    ? Colors.black.withOpacity(.30)
                                    : Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            "Dec ${info.time}",
                            style: FontStyleUtilities.t4(
                                fontWeight: FWT.regular,
                                fontColor: isLight
                                    ? const Color(0xff454545).withOpacity(.80)
                                    : Colors.white.withOpacity(.70)),
                          ),
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
