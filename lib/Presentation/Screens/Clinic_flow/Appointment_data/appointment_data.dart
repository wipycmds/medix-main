import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Choose_patient/choose_patient.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Flow_widgets/select_blood_group.dart';
import '../../Flow_widgets/select_gender.dart';

class AppointmentData extends StatefulWidget {
  const AppointmentData({Key? key}) : super(key: key);

  @override
  State<AppointmentData> createState() => _AppointmentDataState();
}

class _AppointmentDataState extends State<AppointmentData> {
  late String data = '';
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: true,
                elevation: 4,
                leading: MyBackButton(),
                title: Text('Appointment'),
              ),
              SliverSizedBox(
                height: 5.h,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  AppointmentTextField(
                      icon: 'assets/Icons/user.svg',
                      hint: 'Enter your Name',
                      onTap: () {},
                      tittle: 'Name'),
                  5.height(),
                  AppointmentTextField(
                      icon: 'assets/Icons/Calendar.svg',
                      hint: data != '' ? data : 'dd/mm/yyyy',
                      tittle: 'Date of Birth',
                      onTap: () async {
                        DateTime? pickDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.utc(
                              DateTime.now().year.toInt() - 18,
                              DateTime.now().month,
                              DateTime.now().day,
                            ),
                            firstDate: DateTime(
                                1950), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.utc(
                              DateTime.now().year.toInt() - 18,
                              DateTime.now().month,
                              DateTime.now().day,
                            ),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: ColorUtil
                                          .primaryColor, textStyle: TextStyle(fontSize: 12.sp), // button text color
                                    ),
                                  ), dialogTheme: DialogThemeData(backgroundColor: isLight
                                      ? Colors.white
                                      : ColorUtil.scaffoldDark),
                                ),
                                child: child!,
                              );
                            });
                        setState(() {
                          data =
                              '${pickDate?.day}/${pickDate?.month}/${pickDate?.year}';
                        });
                                            },
                      enabled: false),
                  5.height(),
                  AppointmentTextField(
                    icon: 'assets/Icons/call.svg',
                    hint: 'Enter your Number',
                    tittle: 'Mobile Number',
                    onTap: () {},
                  ),
                ])),
              ),
              SliverSizedBox(
                child: SelectBloodGroup(onChanged: (v) {}, bloodGroups: const [
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'O+',
                  'O-',
                  'AB+',
                  'AB-'
                ]),
              ),
              SliverSizedBox(
                child: SelectGender(
                  onChanged: (int value) {},
                ),
              ),
              const SliverSizedBox(
                child: WriteYourProblem(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                  child: Button(
                      isArrowButton: true,
                      tittle: 'Continue',
                      onTap: () {
                        NavigationUtil.to(context, const ChoosePatient());
                      }),
                ),
              )
            ],
          ),
          // 110.h,
        ],
      ),
    );
  }
}

class WriteYourProblem extends StatelessWidget {
  const WriteYourProblem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height(),
          Text(
            'Write Your Problem ',
            style: FontStyleUtilities.h4(
              fontWeight: FWT.medium,
              fontColor:
                  isLight ? Colors.black : Colors.white.withOpacity(0.80),
            ).copyWith(fontSize: 19.sp),
          ),
          16.height(),
          const MyTextField(
              maxHeight: 4,
              obscureText: false,
              hint:
                  'I am a Cardio Patinet. Feel sick last 2 weeks.I need\nto talk about cardio problem.')
        ],
      ),
    );
  }
}

class AppointmentTextField extends StatelessWidget {
  const AppointmentTextField(
      {Key? key,
      required this.icon,
      required this.onTap,
      required this.hint,
      this.enabled = true,
      required this.tittle})
      : super(key: key);
  final String icon, hint, tittle;
  final bool enabled;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: FontStyleUtilities.h4(
                  fontWeight: FWT.medium,
                  fontColor:
                      isLight ? Colors.black : Colors.white.withOpacity(0.80))
              .copyWith(fontSize: 19.sp),
        ),
        7.height(),
        GestureDetector(
          onTap: onTap,
          child: MyTextField(
            hint: hint,
            obscureText: false,
            enabled: enabled,
            prefix: AuthIconWrapper(
              icon: icon,
            ),
          ),
        ),
      ],
    );
  }
}
