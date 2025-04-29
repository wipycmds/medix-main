import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Select_Appoinment_Date/appointment_date.dart';
import '../Select_doctor/doctor_list.dart';

class AppointmentBookingDialog extends StatelessWidget {
  const AppointmentBookingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 12.h),
          width: 328.w,
          decoration: BoxDecoration(
              color: isLight ? Colors.white : ColorUtil.surfaceDark,
              borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconWrapper(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    icon: 'assets/Icons/close.svg',
                    padding: 12.h,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                height: 139.h,
                width: 139.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isLight ? const Color(0xffF2FCFF) : Colors.black),
                child: const SvgIcon('assets/Illustration/book.svg'),
              ),
              27.height(),
              Text(
                'Book an Appointment',
                style: FontStyleUtilities.h2(
                  fontWeight: FWT.medium,
                  fontColor: isLight ? Colors.black : Colors.white,
                ).copyWith(fontSize: 28.sp),
              ),
              11.height(),
              Text(
                'Please indicate whether you’d like to book\na time or a specific doctor.',
                textAlign: TextAlign.center,
                style: FontStyleUtilities.h6(
                    fontWeight: FWT.regular,
                    fontColor: const Color(0xffABA9A9)),
              ),
              18.height(),
              Button(
                leading: Padding(
                  padding: EdgeInsets.only(right: 9.23.w),
                  child: const SvgIcon(
                    'assets/Icons/box_calendar.svg',
                    color: ColorUtil.primaryColor,
                  ),
                ),
                tittle: 'Book a time',
                onTap: () {
                  Navigator.pop(context);
                  NavigationUtil.to(context, const SelectAppointmentDate());
                },
                height: 50.h,
                style: FontStyleUtilities.h4(
                    height: 1, fontWeight: FWT.medium, fontColor: Colors.white),
              ),
              5.height(),
              TextDivider(
                symmetricPadding: 5.w,
                textDivider: 'OR',
                style: FontStyleUtilities.h6(
                    fontWeight: FWT.medium, fontColor: const Color(0xffB9B9B9)),
              ),
              5.height(),
              MyOutlinedButton(
                  style: FontStyleUtilities.h4(
                      height: 1,
                      fontWeight: FWT.medium,
                      fontColor: ColorUtil.primaryColor),
                  leading: Padding(
                    padding: EdgeInsets.only(right: 9.23.w),
                    child: const SvgIcon(
                      'assets/Icons/specific.svg',
                      color: ColorUtil.primaryColor,
                    ),
                  ),
                  tittle: 'Book a Specific Doctor',
                  onTap: () {
                    Navigator.pop(context);
                    NavigationUtil.to(context, const SelectDoctor());
                  }),
              12.height()
            ],
          ),
        ));
  }
}
