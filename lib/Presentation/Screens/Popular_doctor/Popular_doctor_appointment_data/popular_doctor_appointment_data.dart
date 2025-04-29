import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Add_voucher/add_voucher.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularDoctorAppointmentData extends StatelessWidget {
  const PopularDoctorAppointmentData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 4,
                leading: MyBackButton(
                  color: isLight ? Colors.black : Colors.white,
                ),
                title: const Text('Appointment'),
              ),
              SliverSizedBox(
                height: 30.h,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  const AppointmentTextField(
                      icon: 'assets/Icons/user.svg',
                      hint: 'Enter your Name',
                      tittle: 'Name'),
                  20.height(),
                  const AppointmentTextField(
                      icon: 'assets/Icons/Calendar.svg',
                      hint: 'dd/mm/yyyy',
                      tittle: 'Date of Birth'),
                  20.height(),
                  const AppointmentTextField(
                      icon: 'assets/Icons/call.svg',
                      hint: 'Enter your Number',
                      tittle: 'Mobile Number'),
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
              SliverSizedBox(height: 110.h),
            ],
          ),
          // 110.h,
          Positioned(
              bottom: 0,
              width: 375.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Button(
                    isArrowButton: true,
                    tittle: 'Continue',
                    onTap: () {
                      NavigationUtil.to(context, const AddVoucher());
                    }),
              )),
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
          20.height(),
          Text(
            'Write Your Problem ',
            style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium,
                    fontColor:
                        isLight ? Colors.black : Colors.white.withOpacity(0.70))
                .copyWith(fontSize: 19.sp),
          ),
          20.height(),
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

class SelectBloodGroup extends StatefulWidget {
  const SelectBloodGroup(
      {Key? key, required this.onChanged, required this.bloodGroups})
      : super(key: key);
  final ValueChanged<String> onChanged;
  final List<String> bloodGroups;

  @override
  State<SelectBloodGroup> createState() => _SelectBloodGroupState();
}

class _SelectBloodGroupState extends State<SelectBloodGroup> {
  int _selectedIndex = -1;

  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(widget.bloodGroups[_selectedIndex]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.height(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Blood Group',
            style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium,
                    fontColor:
                        isLight ? Colors.black : Colors.white.withOpacity(0.70))
                .copyWith(fontSize: 19.sp),
          ),
        ),
        22.height(),
        SizedBox(
          height: 60.h,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: ListView.builder(
                itemCount: widget.bloodGroups.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) => GestureDetector(
                      onTap: () {
                        _setIndex(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 16.w,
                            right: index == widget.bloodGroups.length - 1
                                ? 16.w
                                : 0),
                        height: 60.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? ColorUtil.primaryColor
                                : isLight
                                    ? Colors.white
                                    : ColorUtil.surfaceDark,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                          child: Text(
                            widget.bloodGroups[index],
                            style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: _selectedIndex == index
                                    ? Colors.white
                                    : const Color(0xff7a7a7a)),
                          ),
                        ),
                      ),
                    )),
          ),
        )
      ],
    );
  }
}

class SelectGender extends StatefulWidget {
  const SelectGender({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  int _selectedIndex = 0;
  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(_selectedIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          23.height(),
          Text(
            'Gender',
            style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium,
                    fontColor:
                        isLight ? Colors.black : Colors.white.withOpacity(0.70))
                .copyWith(fontSize: 19.sp),
          ),
          22.height(),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    _setIndex(0);
                  },
                  child: RadioWrapper(
                      isSelected: _selectedIndex == 0, text: 'Male')),
              30.width(),
              GestureDetector(
                  onTap: () {
                    _setIndex(1);
                  },
                  child: RadioWrapper(
                      isSelected: _selectedIndex == 1, text: 'Female')),
            ],
          )
        ],
      ),
    );
  }
}

class RadioWrapper extends StatelessWidget {
  const RadioWrapper({Key? key, required this.isSelected, required this.text})
      : super(key: key);
  final bool isSelected;
  final String text;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        RadioButton(isSelected: isSelected),
        16.width(),
        Text(
          text,
          style: FontStyleUtilities.h6(
              fontWeight: FWT.medium,
              fontColor: isLight
                  ? const Color(0xff7a7a7a)
                  : Colors.white.withOpacity(0.50)),
        ),
      ],
    );
  }
}

class RadioButton extends StatefulWidget {
  const RadioButton({Key? key, required this.isSelected}) : super(key: key);
  final bool isSelected;
  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      width: 16.h,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorUtil.primaryColor)),
      child: AnimatedContainer(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isSelected
                ? ColorUtil.primaryColor
                : Colors.transparent),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class AppointmentTextField extends StatelessWidget {
  const AppointmentTextField(
      {Key? key, required this.icon, required this.hint, required this.tittle})
      : super(key: key);
  final String icon, hint, tittle;
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
                      isLight ? Colors.black : Colors.white.withOpacity(0.70))
              .copyWith(fontSize: 19.sp),
        ),
        7.height(),
        MyTextField(
          hint: hint,
          obscureText: false,
          prefix: AuthIconWrapper(
            icon: icon,
          ),
        ),
      ],
    );
  }
}
