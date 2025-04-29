import 'package:flutter/material.dart';
import 'package:medix/Extensions/white_space_extension.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Shared/app_bar.dart' as bar;
import '../../Flow_widgets/confirmation_detail_widget.dart';

class ConfirmConsultation extends StatelessWidget {
  const ConfirmConsultation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            const bar.ConsultationAppBar(
              step: bar.ConsultationStep.confirm,
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),
            SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confirm Appointment',
                            style: FontStyleUtilities.h2(
                                fontWeight: FWT.medium,
                                fontColor:
                                    isLight ? Colors.black : Colors.white),
                          ),
                          Text(
                            'Find the service you are ',
                            style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: isLight
                                    ? const Color(0xffB9B9B9)
                                    : Colors.white.withOpacity(0.70)),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ]))),
            SliverSizedBox(height: 10.h),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: isLight ? Colors.white : ColorUtil.surfaceDark,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 160.h,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/Images/Temp/hospital_2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          21.height(),
                          Text(
                            'Massachusetts Hospital',
                            style: FontStyleUtilities.h4(
                              fontWeight: FWT.medium,
                              fontColor: isLight ? Colors.black : Colors.white,
                            ).copyWith(fontSize: 19.sp),
                          ),
                        ],
                      ),
                    ),
                    14.height(),
                    Divider(
                      thickness: 1,
                      height: 1,
                      color: const Color(0xffd1d1d1).withOpacity(.30),
                    ),
                    23.height(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        children: [
                          const ConfirmationDetail(
                              icon: 'assets/Icons/Discovery.svg',
                              tittle: 'Location',
                              subtitle: 'New York, USA'),
                          22.height(),
                          const ConfirmationDetail(
                              icon: 'assets/Icons/service.svg',
                              tittle: 'Service',
                              subtitle: 'Neurology - \$350'),
                          22.height(),
                          const ConfirmationDetail(
                              icon: 'assets/Icons/Doctor.svg',
                              tittle: 'Doctor',
                              subtitle: 'New York, USA'),
                          22.height(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
            bottom: 0,
            width: 375.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child:
                  Button(isArrowButton: true, tittle: 'Continue', onTap: () {}),
            )),
      ],
    ));
  }
}
