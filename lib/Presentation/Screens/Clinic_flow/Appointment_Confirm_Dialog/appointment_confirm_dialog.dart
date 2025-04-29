import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Main/Home/Compo/bottomnav.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentConfirmDialog extends StatelessWidget {
  const AppointmentConfirmDialog({Key? key, required this.isLight})
      : super(key: key);
  final bool isLight;
  @override
  Widget build(BuildContext context) {
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
                    color: isLight ? null : Colors.white,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                height: 139.h,
                width: 139.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffF2FCFF)),
                child: const SvgIcon('assets/Illustration/book.svg'),
              ),
              27.height(),
              Text(
                'Appointment Booked',
                style: FontStyleUtilities.h2(
                  fontWeight: FWT.medium,
                  fontColor: isLight ? Colors.black : Colors.white,
                ).copyWith(fontSize: 28.sp),
              ),
              11.height(),
              Text(
                'Please Check the app carefully to keep your\nhealth better',
                textAlign: TextAlign.center,
                style: FontStyleUtilities.h6(
                    fontWeight: FWT.regular,
                    fontColor: const Color(0xffABA9A9)),
              ),
              18.height(),
              Button(
                trailing: Padding(
                  padding: EdgeInsets.only(left: 9.23.w),
                  child: const SvgIcon(
                    'assets/Icons/box_calendar.svg',
                    color: ColorUtil.primaryColor,
                  ),
                ),
                tittle: 'Add to Calendar',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (context) => const BottomNav()),
                      (route) => false);
                },
                height: 50.h,
                style: FontStyleUtilities.h4(
                    height: 1, fontWeight: FWT.medium, fontColor: Colors.white),
              ),
              36.height(),
            ],
          ),
        ));
  }
}
