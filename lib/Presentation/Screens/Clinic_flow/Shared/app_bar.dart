import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

enum Step { service, hospital, doctor, patient, confirm }

class TopBarData {
  final String name;
  final int index;
  TopBarData({required this.index, required this.name});
}

class TopAppBar extends StatelessWidget {
  final Step step;
  const TopAppBar({Key? key, required this.step}) : super(key: key);
  TopBarData getProper(Step stepEnum) {
    switch (stepEnum) {
      case Step.service:
        return TopBarData(index: 1, name: 'Select Services');
      case Step.hospital:
        return TopBarData(index: 2, name: 'Chose Hospital');
      case Step.doctor:
        return TopBarData(index: 3, name: 'Chose Doctor');
      case Step.patient:
        return TopBarData(index: 4, name: 'Chose Patient');
      case Step.confirm:
        return TopBarData(index: 5, name: 'Confirm Appointment');
      default:
        return TopBarData(index: 0, name: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    MediaQueryData data = MediaQuery.of(context);
    return MyStickyHeader(
      pinned: true,
      elevation: 4,
      height: data.padding.top + kToolbarHeight + 12.h,
      child: Column(
        children: [
          SizedBox(
            height: data.padding.top,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        height: 28.h,
                        width: 30.w,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 8.w, top: 6.h, bottom: 6.h),
                          child: SvgIcon(
                            'assets/Icons/arrow_back.svg',
                            color: isLight
                                ? Colors.black.withOpacity(.30)
                                : Colors.white,
                          ),
                        ))),
                const Spacer(),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Step ${getProper(step).index} of 5:  ',
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: ColorUtil.primaryColor)),
                  TextSpan(
                      text: getProper(step).name,
                      style: FontStyleUtilities.h6(
                        fontWeight: FWT.medium,
                        fontColor: isLight
                            ? const Color(0xff898989)
                            : Colors.white.withOpacity(0.70),
                      )),
                ])),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(height: 25.h),
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
                  percent: 1 / 5 * getProper(step).index,
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
