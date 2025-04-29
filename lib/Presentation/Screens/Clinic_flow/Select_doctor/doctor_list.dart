//
import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Doctor_profile/doctor_profile.dart';
import 'package:medix/Utils/utils.dart';
//
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
//
import 'package:medix/Data/Fake_data/Home/doctors.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Select_doctor/doctor_view_model.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/clinic_visits.dart';
//
import '../../Main/Home/Compo/end_drawer.dart';
import '../Shared/app_bar.dart' as bar;
import 'package:medix/Presentation/Widgets/widgets.dart';
import '../../Flow_widgets/doctor_card.dart';

class SelectDoctor extends StatelessWidget {
  const SelectDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffKey = GlobalKey();
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<SelectDoctorViewModel>.reactive(
      viewModelBuilder: () => SelectDoctorViewModel(),
      builder: (context, model, child) => Scaffold(
          key: scaffKey,
          endDrawer: const HomeFilter(),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const bar.TopAppBar(
                    step: bar.Step.doctor,
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
                                  'Doctors',
                                  style: FontStyleUtilities.h2(
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? Colors.black.withOpacity(.50)
                                          : Colors.white.withOpacity(0.8)),
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
                            SizedBox(width: 30.w),
                            IconWrapper(
                                onTap: () {
                                  scaffKey.currentState!.openEndDrawer();
                                },
                                icon: 'assets/Icons/Filter.svg',
                                padding: 9)
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                    child: Button(
                        isArrowButton: true,
                        tittle: 'Continue',
                        onTap: () {
                          NavigationUtil.to(context, const DoctorProfile());
                        }),
                  )),
            ],
          )),
    );
  }
}
