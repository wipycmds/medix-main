//
import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consulatation_doctor_profile/consulation_doctor_profile.dart';
import 'package:medix/Utils/utils.dart';
//
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
//
import 'package:medix/Data/Fake_data/Home/doctors.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/clinic_visits.dart';
import 'select_doctor_consultation_view_model.dart';
//
import '../Shared/app_bar.dart' as bar;
import 'package:medix/Presentation/Widgets/widgets.dart';
import '../../Flow_widgets/doctor_card.dart';

class ConsultationSelectDoctor extends StatelessWidget {
  final List<dynamic> provider;
  const ConsultationSelectDoctor({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(provider);
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<ConsultationSelectDoctorViewModel>.reactive(
      viewModelBuilder: () => ConsultationSelectDoctorViewModel(),
      builder: (context, model, child) => Scaffold(
          body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const bar.ConsultationAppBar(
                step: bar.ConsultationStep.doctor,
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
                              'Find your Doctor',
                              style: FontStyleUtilities.h2(
                                  fontWeight: FWT.medium,
                                  fontColor:
                                      isLight ? Colors.black : Colors.white),
                            ),
                            Text(
                              'Find the service you are ',
                              style: FontStyleUtilities.h6(
                                  fontWeight: FWT.medium,
                                  fontColor: const Color(0xffB9B9B9)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconWrapper(
                            onTap: () {}, icon: 'assets/Icons/Search.svg'),
                      ]))),
              SliverSizedBox(height: 10.h),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => DoctorCard(
                            selected: model.checkIfSelected(doctors[index]),
                            onTap: () {
                              model.chooseClinic(doctors[index]);
                            },
                            info: doctors[index],
                          ),
                      childCount: clinics.length)),
              SliverSizedBox(height: 115.h)
            ],
          ),
          Positioned(
              bottom: 0,
              width: 375.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Button(
                    isArrowButton: true,
                    tittle: 'Continue',
                    onTap: () {
                      NavigationUtil.to(
                          context, const ConsultationDoctorProfile());
                    }),
              )),
        ],
      )),
    );
  }
}
