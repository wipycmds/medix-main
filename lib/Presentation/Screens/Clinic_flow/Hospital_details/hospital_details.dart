import 'package:flutter/material.dart';
import '../Appointment_booking_dialog/appointment_booking_dialog.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Flow_widgets/doctor_specification_block.dart';

class HospitalDetails extends StatelessWidget {
  const HospitalDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    MediaQueryData data = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
              children: [
                SizedBox(
                  height: data.padding.top + 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          height: 420.h,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/Images/Temp/hospital_details.png',
                            fit: BoxFit.cover,
                            height: 493.h,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 27.h,
                          right: 24.w,
                          child: GlassContainer(
                              padding: EdgeInsets.all(15.h),
                              borderRadius: BorderRadius.circular((55 / 2).h),
                              height: 55.h,
                              width: 55.h,
                              color: const Color(0xffB6B6B6).withOpacity(.16),
                              child: AnimIcon(
                                  activeIcon: 'assets/Icons/Heart.svg',
                                  deactivateIcon: 'assets/Icons/Heart.svg',
                                  deactivateColor: ColorUtil.mediumTextColor,
                                  onChanged: (value) {})))
                    ],
                  ),
                ),
                19.height(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Massachusetts  Hospital',
                        style: FontStyleUtilities.h2(
                                fontWeight: FWT.medium,
                                fontColor:
                                    isLight ? Colors.black : Colors.white)
                            .copyWith(fontSize: 28.sp),
                      ),
                      9.height(),
                      Row(children: [
                        const SvgIcon('assets/Icons/Star.svg'),
                        SizedBox(
                          width: 6.33.w,
                        ),
                        Text(
                          '4.8 (472 Reviews)',
                          style: FontStyleUtilities.h5(
                                  fontWeight: FWT.medium,
                                  fontColor: isLight
                                      ? Colors.black.withOpacity(.35)
                                      : Colors.white.withOpacity(.75))
                              .copyWith(fontSize: 18.sp),
                        ),
                        const Spacer(),
                      ]),
                      25.height(),
                      Text(
                        'Specification',
                        style: FontStyleUtilities.h5(
                                fontWeight: FWT.medium,
                                fontColor: isLight
                                    ? const Color(0xff200E32)
                                    : Colors.white)
                            .copyWith(fontSize: 18.sp),
                      ),
                      15.height(),
                      Row(
                        children: [
                          const SpecificationBlock(
                              icon: 'assets/Icons/Home.svg',
                              func: 'Rooms',
                              count: '34'),
                          64.width(),
                          const SpecificationBlock(
                              icon: 'assets/Icons/Profile.svg',
                              func: 'Doctors',
                              count: '134'),
                          57.width(),
                          const SpecificationBlock(
                              icon: 'assets/Icons/Graph.svg',
                              func: 'Acreage',
                              count: '3300 m'),
                        ],
                      )
                    ],
                  ),
                ),
                28.height(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Button(
                      tittle: 'Continue',
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const AppointmentBookingDialog());
                      }),
                ),
                31.height(),
              ],
            ),
          ),
          Positioned(
            top: 26.h + data.padding.top,
            right: 37.w,
            child: IconWrapper(
              onTap: () {
                Navigator.pop(context);
              },
              icon: 'assets/Icons/close.svg',
              padding: 12.h,
            ),
          ),
        ],
      ),
    );
  }
}
