import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Home/doctors.dart';
import 'package:medix/Data/Model/Home/doctor.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Popular_doctor/popular_doctor/popular_doctor.dart';

class PopularDoctor extends StatelessWidget {
  const PopularDoctor({Key? key, required this.onTap}) : super(key: key);
  final ValueChanged<DoctorModel> onTap;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
              onTap: () {
                NavigationUtil.to(context, const PopularDoctorScreen());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Popular Doctors',
                    style: FontStyleUtilities.h4(
                      fontWeight: FWT.medium,
                      fontColor: isLight ? Colors.black : Colors.white,
                    ).copyWith(fontSize: 19.sp),
                  ),
                  const Spacer(),
                  Text(
                    'View all  ',
                    style: FontStyleUtilities.h6(
                      fontWeight: FWT.regular,
                      fontColor: isLight
                          ? Colors.black.withOpacity(.50)
                          : Colors.white,
                    ),
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
          ),
          SizedBox(
            height: 281.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 20.w),
                DoctorCard(
                  info: doctors[0],
                  onTap: () {
                    onTap(doctors[0]);
                  },
                ),
                DoctorCard(
                  info: doctors[1],
                  onTap: () {
                    onTap(doctors[1]);
                  },
                ),
                DoctorCard(
                  info: doctors[0],
                  onTap: () {
                    onTap(doctors[0]);
                  },
                ),
                DoctorCard(
                  info: doctors[1],
                  onTap: () {
                    onTap(doctors[1]);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key, required this.info, required this.onTap})
      : super(key: key);
  final DoctorModel info;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        child: Container(
          width: 168.w,
          margin: EdgeInsets.only(right: 17.w, top: 16.h, bottom: 18.h),
          padding: EdgeInsets.fromLTRB(6.w, 6.h, 3.w, 6.h),
          decoration: BoxDecoration(
              color: isLight ? Colors.white : ColorUtil.surfaceDark,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    color: isLight
                        ? const Color(0xff6E9ECE).withOpacity(.25)
                        : const Color(0xff6E9ECE).withOpacity(.1),
                    blurRadius: 10,
                    offset: const Offset(4, 4))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: SizedBox(
                      width: double.infinity,
                      height: 153.h,
                      child: Image.asset(info.image, fit: BoxFit.cover))),
              SizedBox(height: 10.h),
              Text(
                info.name,
                style: FontStyleUtilities.h6(
                    fontWeight: FWT.medium,
                    fontColor: isLight ? Colors.black : Colors.white),
              ),
              Row(
                children: [
                  Text(
                    info.degree,
                    style: FontStyleUtilities.t1(
                        fontWeight: FWT.medium,
                        fontColor: isLight
                            ? Colors.black.withOpacity(.50)
                            : Colors.white.withOpacity(.90)),
                  ),
                  Text(
                    ' (${info.reviews} reviews)',
                    style: FontStyleUtilities.t2(
                        fontWeight: FWT.regular,
                        fontColor: isLight
                            ? Colors.black.withOpacity(.50)
                            : Colors.white.withOpacity(.90)),
                  ),
                ],
              ),
              Text(
                '${info.experience.toInt()} years Experience',
                style: FontStyleUtilities.t1(
                    fontWeight: FWT.regular,
                    fontColor: isLight
                        ? Colors.black.withOpacity(.30)
                        : Colors.white.withOpacity(.70)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
