import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Choose_patient/choose_patient.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 4,
                  pinned: true,
                  expandedHeight: 100.h,
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
                          bottom: -0,
                          child: Container(
                            height: 40.h,
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
                                    isLight ? Colors.black : Colors.white,
                              ),
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
                                        : Colors.white.withOpacity(0.8),
                                  ).copyWith(fontSize: 18.sp),
                                ),
                                9.width(),
                                Text(
                                  '(4 years Experience)',
                                  style: FontStyleUtilities.t2(
                                      fontWeight: FWT.regular,
                                      fontColor: isLight
                                          ? Colors.black.withOpacity(.30)
                                          : Colors.white.withOpacity(0.6)),
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
                                          : Colors.white.withOpacity(0.8))
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
                                      fontColor: isLight
                                          ? Colors.black.withOpacity(.50)
                                          : Colors.white.withOpacity(0.8))
                                  .copyWith(fontSize: 22.sp),
                            ),
                            2.height(),
                            Text(
                              'Sat - Mon 10:30 AM - 06:00PM',
                              style: FontStyleUtilities.h6(
                                  fontWeight: FWT.regular,
                                  fontColor: isLight
                                      ? Colors.black.withOpacity(.50)
                                      : Colors.white.withOpacity(0.8)),
                            ),
                            25.height(),
                            Text(
                              'About',
                              style: FontStyleUtilities.h3(
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? Colors.black.withOpacity(.50)
                                          : Colors.white)
                                  .copyWith(fontSize: 22.sp),
                            ),
                            9.height(),
                            Divider(
                                thickness: 1.h,
                                height: 1.h,
                                color: isLight
                                    ? Colors.black.withOpacity(.1)
                                    : Colors.white.withOpacity(0.1)),
                            14.height(),
                            Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing',
                                style: FontStyleUtilities.h6(
                                    fontWeight: FWT.medium,
                                    fontColor: isLight
                                        ? Colors.black.withOpacity(.50)
                                        : Colors.white.withOpacity(0.7))),
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
                        NavigationUtil.to(context, const ChoosePatient());
                      }),
                )),
          ],
        ),
      ),
    );
  }
}

class SpecialistTag extends StatelessWidget {
  const SpecialistTag({Key? key, required this.tag}) : super(key: key);
  final String tag;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 39.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isLight ? const Color(0xffEDFCFF) : ColorUtil.surfaceDark),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: FontStyleUtilities.h6(
                height: 1,
                fontWeight: FWT.medium,
                fontColor: ColorUtil.primaryColor),
          ),
        ],
      ),
    );
  }
}

class TagIconWrapper extends StatelessWidget {
  const TagIconWrapper(
      {Key? key,
      this.padding,
      required this.icon,
      this.iconColor,
      required this.param,
      required this.value,
      this.scale})
      : super(key: key);
  final String icon, param, value;
  final double? padding, scale;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        TagIconBox(
          iconColor: iconColor,
          scale: scale,
          icon: icon,
          padding: padding,
        ),
        16.width(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              param,
              style: FontStyleUtilities.h6(
                  fontWeight: FWT.regular,
                  fontColor: isLight
                      ? Colors.black.withOpacity(.50)
                      : Colors.white.withOpacity(0.6)),
            ),
            Text(
              value,
              style: FontStyleUtilities.h6(
                  fontWeight: FWT.semiBold,
                  fontColor:
                      isLight ? Colors.black : Colors.white.withOpacity(0.8)),
            ),
          ],
        )
      ],
    );
  }
}

class TagIconBox extends StatelessWidget {
  const TagIconBox({
    Key? key,
    required this.icon,
    this.padding,
    this.scale,
    this.iconColor,
  }) : super(key: key);
  final String icon;
  final Color? iconColor;
  final double? padding, scale;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      height: 41.h,
      width: 45.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: isLight
                  ? Colors.black.withOpacity(0.1)
                  : Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10.r)),
      child: Transform.scale(
        scale: scale ?? 1,
        child: SvgIcon(
          icon,
          color: iconColor,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
