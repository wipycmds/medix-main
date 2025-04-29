import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/clinic_visits.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/clinic_visit/clinic_view_model.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/hospital_list/hospital_list.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import '../../Main/Home/Compo/end_drawer.dart';
import '../Shared/app_bar.dart' as bar;

import '../../Flow_widgets/clinic_card.dart';

class ClinicVisit extends StatelessWidget {
  ClinicVisit({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<ClinicViewModel>.reactive(
      viewModelBuilder: () => ClinicViewModel(),
      builder: (context, model, child) => Scaffold(
          key: scaffKey,
          endDrawer: const HomeFilter(),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const bar.TopAppBar(
                    step: bar.Step.service,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 16.h),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Clinic Visit',
                                  style: FontStyleUtilities.h2(
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? Colors.black
                                          : Colors.white),
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
                            SizedBox(width: 16.w),
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
                          (context, index) => ClinicVisitCard(
                                selected: model.checkIfSelected(clinics[index]),
                                onTap: () {
                                  model.chooseClinic(clinics[index]);
                                },
                                info: clinics[index],
                              ),
                          childCount: clinics.length)),
                  SliverSizedBox(height: 85.h)
                ],
              ),
              Positioned(
                  bottom: 0,
                  width: 375.w,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
                    child: Button(
                        isArrowButton: true,
                        tittle: 'Continue',
                        onTap: () {
                          NavigationUtil.to(context, const HospitalList());
                        }),
                  )),
            ],
          )),
    );
  }
}
