import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Profile/Shared/icon_container.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            leading: MyBackButton(),
            title: Text('Details'),
          ),
          SliverSizedBox(height: 24.h),
          const DetailsTile()
        ],
      ),
    );
  }
}

class DetailsTile extends StatelessWidget {
  const DetailsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return SliverSizedBox(
      child: Container(
        margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: isLight ? Colors.white : ColorUtil.surfaceDark,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(2, 4), blurRadius: 30)
            ]),
        child: Column(
          children: [
            Row(
              children: [
                20.width(),
                SizedBox.square(
                  dimension: 75.w,
                  child: Image.asset('assets/Images/Temp/doctor_1.png'),
                ),
                16.width(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr.Anna Nicolas',
                      style: FontStyleUtilities.h5(
                        fontWeight: FWT.semiBold,
                        fontColor: isLight ? Colors.black : Colors.white,
                      ).copyWith(fontSize: 18.sp),
                    ),
                    Text(
                      'Neurologist | Metro Hospital',
                      style: FontStyleUtilities.t2(
                          fontWeight: FWT.medium,
                          fontColor: isLight
                              ? ColorUtil.lightTextColor
                              : Colors.white.withOpacity(0.6)),
                    ),
                    Row(
                      children: [
                        Text(
                          '20 January 2020',
                          style: FontStyleUtilities.t2(
                              fontWeight: FWT.medium,
                              fontColor: isLight
                                  ? Colors.black
                                  : Colors.white.withOpacity(0.8)),
                        ),
                        20.width(),
                        Text(
                          '11:30',
                          style: FontStyleUtilities.t2(
                              fontWeight: FWT.medium,
                              fontColor: isLight
                                  ? Colors.black
                                  : Colors.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    4.height()
                  ],
                )),
                20.width(),
              ],
            ),
            16.height(),
            const Divider(height: 1),
            16.height(),
            Row(
              children: [
                20.width(),
                const IconContainer(iconOption: IconOption.video),
                16.width(),
                Text(
                  'Video Call',
                  style: FontStyleUtilities.h5(
                      fontWeight: FWT.semiBold,
                      height: 1,
                      fontColor: isLight
                          ? Colors.black
                          : Colors.white.withOpacity(0.8)),
                ),
                const Spacer(),
                StartNowButton(onTap: () {}),
                20.width()
              ],
            ),
            16.height(),
            const Divider(height: 1),
            20.height(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consultation',
                      style: FontStyleUtilities.h4(
                          fontColor: isLight
                              ? Colors.black
                              : Colors.white.withOpacity(0.8),
                          fontWeight: FWT.semiBold),
                    ),
                    6.height(),
                    Text(
                      'Complaint',
                      style: FontStyleUtilities.t1(
                          fontColor: isLight
                              ? Colors.black
                              : Colors.white.withOpacity(0.8),
                          fontWeight: FWT.medium),
                    ),
                    4.height(),
                    Text(
                      'Headache and Nausea',
                      style: FontStyleUtilities.h6(
                          fontColor: isLight
                              ? Colors.black
                              : Colors.white.withOpacity(0.8),
                          fontWeight: FWT.semiBold),
                    ),
                    10.height(),
                    Text(
                      'Description',
                      style: FontStyleUtilities.t1(
                          fontColor: isLight
                              ? Colors.black
                              : Colors.white.withOpacity(0.8),
                          fontWeight: FWT.medium),
                    ),
                    2.height(),
                    Text(
                        'I am feeling pain in eyes when looking ar bright light also tightness sensation in the head',
                        style: FontStyleUtilities.t2(
                          fontWeight: FWT.bold,
                          fontColor: isLight
                              ? Colors.black
                              : Colors.white.withOpacity(0.8),
                        )),
                    16.height(),
                  ],
                )),
            const Divider(),
            const ConsultationDetails()
          ],
        ),
      ),
    );
  }
}

class ConsultationDetails extends StatelessWidget {
  const ConsultationDetails({
    Key? key,
  }) : super(key: key);

  Widget _buildConsultation(
      {required String param,
      required String value,
      required BuildContext context}) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          param,
          style: FontStyleUtilities.t1(
              fontColor: isLight ? Colors.black : Colors.white.withOpacity(0.7),
              fontWeight: FWT.medium,
              height: 1),
        ),
        6.height(),
        Text(value,
            style: FontStyleUtilities.t2(
              fontWeight: FWT.bold,
              fontColor: isLight ? Colors.black : Colors.white.withOpacity(0.7),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          4.height(),
          const SizedBox(width: double.infinity),
          Text(
            'Patient Details',
            style: FontStyleUtilities.h4(
              fontWeight: FWT.semiBold,
              fontColor: isLight ? Colors.black : Colors.white.withOpacity(0.8),
            ),
          ),
          16.height(),
          _buildConsultation(
              param: 'Name', value: 'Pascal Mendel', context: context),
          12.height(),
          _buildConsultation(
              param: 'Email', value: 'youza@gmail.com', context: context),
          12.height(),
          _buildConsultation(
              param: 'Name', value: 'Pascal Mendel', context: context),
        ],
      ),
    );
  }
}

class StartNowButton extends StatelessWidget {
  const StartNowButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorUtil.primaryColor.withOpacity(.16),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(36.r),
          color: ColorUtil.primaryColor,
        ),
        child: Row(
          children: [
            Text(
              'Start Now',
              style: FontStyleUtilities.t1(
                  height: 1, fontWeight: FWT.medium, fontColor: Colors.white),
            ),
            10.width(),
            Icon(
              Icons.arrow_forward,
              size: 20.h,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
