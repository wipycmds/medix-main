import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consultation_doctors/select_doctor_consultation.dart';
//
import 'package:medix/Utils/utils.dart';
//
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
//
import 'package:medix/Presentation/Widgets/widgets.dart';
import '../Shared/app_bar.dart' as bar;
import '../../Flow_widgets/clinic_card.dart';
//
import 'package:medix/Presentation/Screens/Consultation_flow/BookAppointment_consultation/book_appointment_consultation_view_model.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/clinic_visits.dart';

class ConsultationBookAppointment extends StatelessWidget {
  const ConsultationBookAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<ConsulTationAppointmentViewModel>.reactive(
      viewModelBuilder: () => ConsulTationAppointmentViewModel(),
      builder: (context, model, child) => Scaffold(
          body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const bar.ConsultationAppBar(
                step: bar.ConsultationStep.service,
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '24/7 Doctor Video\nConsultation',
                                  style: FontStyleUtilities.h2(
                                      height: 1.26,
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                Text(
                                  'Find the service you are ',
                                  style: FontStyleUtilities.h6(
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? const Color(0xffB9B9B9)
                                          : Colors.white),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: IconWrapper(
                                  onTap: () {},
                                  icon: 'assets/Icons/Search.svg'),
                            ),
                          ]))),
              SliverSizedBox(height: 10.h),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => ClinicVisitCard(
                            selected: model.checkIfSelected(clinics[index]),
                            onTap: () {
                              model.chooseClinic(clinics[index]);
                            },
                            info: clinics[index],
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
                          context, const ConsultationSelectDoctor());
                    }),
              )),
        ],
      )),
    );
  }
}
