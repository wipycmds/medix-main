import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

enum ConsultationStep { service, doctor, confirm }

class TopBarData {
  final String name;
  final int index;
  TopBarData({required this.index, required this.name});
}

class ConsultationAppBar extends StatelessWidget {
  final ConsultationStep step;
  const ConsultationAppBar({Key? key, required this.step}) : super(key: key);
  TopBarData getProper(ConsultationStep stepEnum) {
    switch (stepEnum) {
      case ConsultationStep.service:
        return TopBarData(index: 1, name: 'Select Services');
      case ConsultationStep.doctor:
        return TopBarData(index: 2, name: 'Chose Doctor');
      case ConsultationStep.confirm:
        return TopBarData(index: 3, name: 'Confirm Appointment');
      default:
        return TopBarData(index: 0, name: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    var isLight = Theme.of(context).brightness == Brightness.light;
    return MyStickyHeader(
      pinned: true,
      elevation: 4,
      height: data.padding.top + kToolbarHeight + 12.h,
      child: Column(
        children: [
          SizedBox(
            height: data.padding.top,
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgIcon('assets/Icons/arrow_back.svg',
                        color: isLight ? Colors.black : Colors.white)),
                const Spacer(),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Step ${getProper(step).index} of 3:  ',
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: ColorUtil.primaryColor)),
                  TextSpan(
                      text: getProper(step).name,
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: isLight
                              ? const Color(0xff898989)
                              : Colors.white.withOpacity(0.80))),
                ])),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 8.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: const Color(0xffCCF5FF),
                ),
                LinearPercentIndicator(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  backgroundColor: Colors.transparent,
                  percent: 1 / 3 * getProper(step).index,
                  linearGradient: AppGradients.blueGradient,
                  lineHeight: 2.h,
                  animation: true,
                  animateFromLastPercent: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
