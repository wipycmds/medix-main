import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Patients/patients.dart';
import 'package:medix/Data/Model/Add_patient/patient_model.dart';
import 'package:medix/Extensions/white_space_extension.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Add_dependent/add_dependent.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Confirm_appointment/confrim_appointment.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import '../Shared/app_bar.dart' as bar;
import 'choose_patient_view_model.dart';

class ChoosePatient extends StatelessWidget {
  const ChoosePatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<SelectPatientViewModel>.reactive(
      viewModelBuilder: () => SelectPatientViewModel(),
      builder: (context, model, child) => Scaffold(
          body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const bar.TopAppBar(
                step: bar.Step.patient,
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
                              'Chose Patient',
                              style: FontStyleUtilities.h2(
                                fontWeight: FWT.medium,
                                fontColor: isLight
                                    ? Colors.black
                                    : Colors.white.withOpacity(0.80),
                              ),
                            ),
                            Text(
                              'Find the service you are ',
                              style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: isLight
                                    ? const Color(0xffB9B9B9)
                                    : Colors.white.withOpacity(0.80),
                              ),
                            ),
                          ],
                        ),
                      ]))),
              SliverSizedBox(height: 10.h),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, int index) => PatientCard(
                            selected: model.checkIfSelected(patients[index]),
                            info: patients[index],
                            onTap: () {
                              model.choosePatient(patients[index]);
                            },
                          ),
                      childCount: patients.length)),
              SliverSizedBox(height: 25.h),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                sliver: SliverSizedBox(
                    child: MyOutlinedButton(
                        trailing: Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: const SvgIcon('assets/Icons/Plus.svg'),
                        ),
                        tittle: 'Add New Dependent',
                        onTap: () {
                          NavigationUtil.to(context, const AddDependent());
                        })),
              )
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
                      NavigationUtil.to(context, const ConfirmAppointMent());
                    }),
              )),
        ],
      )),
    );
  }
}

class PatientCard extends StatelessWidget {
  const PatientCard(
      {Key? key,
      this.selected = false,
      required this.info,
      required this.onTap})
      : super(key: key);
  final bool? selected;
  final PatientModel info;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 131.h,
        margin: EdgeInsets.only(left: 22.w, right: 22.w, top: 16.h),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
            color: isLight ? Colors.white : ColorUtil.surfaceDark,
            borderRadius: BorderRadius.circular(15.r),
            border: selected!
                ? Border.all(color: ColorUtil.primaryColor, width: 2)
                : Border.all(color: Colors.transparent, width: 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32.h),
                child: SizedBox.square(
                  dimension: 64.h,
                  child: Image.asset(
                    info.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            16.width(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.name,
                  style: FontStyleUtilities.h5(
                    fontWeight: FWT.medium,
                    fontColor: isLight ? Colors.black : Colors.white,
                  ).copyWith(fontSize: 18.sp),
                ),
                1.height(),
                Text(
                  info.date,
                  style: FontStyleUtilities.t2(
                    fontWeight: FWT.medium,
                    fontColor:
                        isLight ? Colors.black.withOpacity(.35) : Colors.white,
                  ),
                ),
                4.height(),
                TagWidget(relation: info.relation)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
    required this.relation,
  }) : super(key: key);
  final Relation relation;
  String getRelation() {
    switch (relation) {
      case Relation.brother:
        return 'Brother';
      case Relation.father:
        return 'Father';
      case Relation.sister:
        return 'Sister';
      case Relation.son:
        return 'Son';
      case Relation.uncle:
        return 'Uncle';
      case Relation.mother:
        return 'Mother';
      case Relation.self:
        return 'Self';
      default:
        return 'Self';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      height: 20.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: const Color(0xff2970F5)),
      child: Center(
        child: Text(
          getRelation(),
          style: FontStyleUtilities.t4(
              height: 1, fontWeight: FWT.medium, fontColor: Colors.white),
        ),
      ),
    );
  }
}
