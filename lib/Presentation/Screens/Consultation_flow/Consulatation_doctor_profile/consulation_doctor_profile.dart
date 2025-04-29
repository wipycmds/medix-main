import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consultation_appointment_data/consulation_appointment_data.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Flow_widgets/specialist_tag.dart';

class ConsultationDoctorProfile extends StatelessWidget {
  const ConsultationDoctorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    MediaQueryData data = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 4,
                  pinned: true,
                  expandedHeight: 293.h,
                  collapsedHeight: kToolbarHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          'assets/Images/Temp/doctor_details.png',
                          height: double.infinity,
                          width: 375.w,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: -20,
                          child: Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(50.r))),
                          ),
                        )
                      ],
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  leading: const MyBackButton(),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. Leslie Alexander',
                              style: FontStyleUtilities.h3(
                                  fontWeight: FWT.semiBold,
                                  fontColor:
                                      isLight ? Colors.black : Colors.white),
                            ),
                            2.height(),
                            Row(
                              children: [
                                Text(
                                  'Neurology ',
                                  style: FontStyleUtilities.h5(
                                          fontWeight: FWT.medium,
                                          fontColor: isLight
                                              ? Colors.black.withOpacity(.50)
                                              : Colors.white)
                                      .copyWith(fontSize: 18.sp),
                                ),
                                9.width(),
                                Text(
                                  '(4 years Experience)',
                                  style: FontStyleUtilities.t2(
                                      fontWeight: FWT.regular,
                                      fontColor: isLight
                                          ? Colors.black.withOpacity(.30)
                                          : Colors.white.withOpacity(.80)),
                                ),
                              ],
                            ),
                            9.height(),
                            Row(
                              children: [
                                const TagIconWrapper(
                                    padding: 9,
                                    icon: 'assets/Icons/3 Friends.svg',
                                    param: 'Patient',
                                    value: '1000+'),
                                24.width(),
                                const TagIconWrapper(
                                    iconColor: Color(0xffF6A936),
                                    scale: .5,
                                    icon: 'assets/Icons/Star.svg',
                                    param: 'Rating',
                                    value: '4.05'),
                              ],
                            ),
                            24.height(),
                            Text(
                              'Specialist',
                              style: FontStyleUtilities.h3(
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? Colors.black.withOpacity(.50)
                                          : Colors.white.withOpacity(.70))
                                  .copyWith(fontSize: 22.sp),
                            ),
                            7.height(),
                            TheMultiChildAnimationWrapper(
                                spacing: 12.w,
                                runSpacing: 12.w,
                                animationParentType: AnimationParentType.wrap,
                                size: data.size,
                                children: ['Skin Hair', 'Allergy', 'STD']
                                    .map((e) => SpecialistTag(tag: e))
                                    .toList()),
                            24.height(),
                            Text(
                              'Working time',
                              style: FontStyleUtilities.h3(
                                      fontWeight: FWT.medium,
                                      fontColor:
                                          isLight ? Colors.black : Colors.white)
                                  .copyWith(fontSize: 22.sp),
                            ),
                            2.height(),
                            Text(
                              'Sat - Mon 10:30 AM - 06:00PM',
                              style: FontStyleUtilities.h6(
                                  fontWeight: FWT.regular,
                                  fontColor: isLight
                                      ? Colors.black.withOpacity(.50)
                                      : Colors.white.withOpacity(0.70)),
                            ),
                            25.height(),
                            Text(
                              'About',
                              style: FontStyleUtilities.h3(
                                      fontWeight: FWT.medium,
                                      fontColor:
                                          isLight ? Colors.black : Colors.white)
                                  .copyWith(fontSize: 22.sp),
                            ),
                            9.height(),
                            Divider(
                              thickness: 1.h,
                              height: 1.h,
                              color: isLight
                                  ? Colors.black.withOpacity(.10)
                                  : Colors.white.withOpacity(0.10),
                            ),
                            14.height(),
                            Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing',
                                style: FontStyleUtilities.h6(
                                    fontWeight: FWT.medium,
                                    fontColor: isLight
                                        ? Colors.black.withOpacity(.50)
                                        : Colors.white.withOpacity(0.70))),
                            110.height()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                width: 375.w,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                  child: Button(
                      tittle: 'Book Appointment',
                      onTap: () {
                        NavigationUtil.to(
                            context, const ConsultationAppointmentData());
                      }),
                )),
          ],
        ),
      ),
    );
  }
}
