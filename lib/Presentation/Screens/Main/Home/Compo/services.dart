import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/clinic_visit/clinic_vist.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/BookAppointment_consultation/book_appointment.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Consultation_flow/BookAppointment_consultation/book_appointment_consultation.dart';
import 'bottomnav.dart';

class Services extends StatelessWidget {
  const Services({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Services',
                  style: FontStyleUtilities.h4(
                          fontWeight: FWT.medium,
                          fontColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white)
                      .copyWith(fontSize: 19.sp),
                ),
                const Spacer(),
                Text(
                  'View all  ',
                  style: FontStyleUtilities.h6(
                      fontWeight: FWT.regular,
                      fontColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black.withOpacity(.50)
                              : Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: SvgIcon(
                    'assets/Icons/arrow_right.svg',
                    color: isLight ? null : ColorUtil.surfaceLight,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 64.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 20.w),
                // GestureDetector(
                //   onTap: () {
                //     NavigationUtil.to(context, ClinicVisit());
                //   },
                //   child: const ServiceCard(
                //       icon: 'assets/Icons/visit.svg', text: 'Clinic visit'),
                // ),
                GestureDetector(
                  onTap: () {
                    // NavigationUtil.to(
                    //     context, const ConsultationBookAppointment());
                    NavigationUtil.to(
                        context, const BookAppointment());
                  },
                  child: const ServiceCard(
                      icon: 'assets/Icons/consultation.svg',
                      text: 'Consultation'),
                ),
                // GestureDetector(
                //   onTap: () {
                //     NavigationUtil.to(
                //         context,
                //         const BottomNav(
                //           index: 1,
                //         ));
                //   },
                //   child: const ServiceCard(
                //       icon: 'assets/Icons/pharmacy.svg', text: 'Pharmacy'),
                // ),
                SizedBox(width: 4.w)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key, required this.icon, required this.text})
      : super(key: key);
  final String icon, text;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      height: 53.h,
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, top: 15.h, bottom: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isLight ? Colors.white : ColorUtil.surfaceDark),
      child: Row(
        children: [
          SvgIcon(icon),
          SizedBox(width: 15.w),
          Text(
            text,
            style: FontStyleUtilities.t1(
                fontWeight: FWT.medium,
                fontColor: isLight ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }
}
