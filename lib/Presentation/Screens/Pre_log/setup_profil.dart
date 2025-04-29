import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Screens/Pre_log/profile_painter.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Main/Home/Compo/bottomnav.dart';
import '../Main/Home/home.dart';

class SetupProfile extends StatelessWidget {
  const SetupProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Profile'),
        leading: const MyBackButton(),
        leadingWidth: 44.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 14.h),
            child: GestureDetector(
              onTap: () {
                NavigationUtil.to(context, const Home());
              },
              child: Text(
                'Skip',
                style: FontStyleUtilities.t2(
                  fontWeight: FWT.regular,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ProfileLogo()],
              ),
              SizedBox(height: 20.h),
              Text('Personal Information',
                  style: FontStyleUtilities.h4(
                    fontColor: isLight ? Colors.black : Colors.white,
                  ).copyWith(fontSize: 19, fontWeight: FontWeight.w600)),
              SizedBox(height: 9.h),
              Divider(
                thickness: 1,
                height: 1,
                color: const Color(0xffC4C4C4).withOpacity(.25),
              ),
              SizedBox(height: 10.h),
              Text('Full Name',
                  style: FontStyleUtilities.h4(
                    fontColor: isLight ? Colors.black : Colors.white,
                  ).copyWith(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 10.h),
              const MyTextField(
                hint: 'Zack Foster',
                obscureText: false,
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
              SizedBox(height: 16.h),
              Text('Contact Number',
                  style: FontStyleUtilities.h4(
                    fontColor: isLight ? Colors.black : Colors.white,
                  ).copyWith(fontSize: 19, fontWeight: FontWeight.w500)),
              SizedBox(height: 10.h),
              const MyTextField(
                hint: '+1 505-4059-1251',
                obscureText: false,
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/call.svg',
                ),
              ),
              SizedBox(height: 16.h),
              Text('Date of Birth',
                  style: FontStyleUtilities.h4(
                    fontColor: isLight ? Colors.black : Colors.white,
                  ).copyWith(fontSize: 19, fontWeight: FontWeight.w500)),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: MyDropDown(dropDowns: [
                      'Date',
                      ...List.generate(
                          31, (int index) => (index + 1).toString())
                    ], onChange: (v) {}),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MyDropDown(dropDowns: const [
                      'Month',
                      "Jan",
                      "Feb",
                      "Mar",
                      "Apr",
                      "May",
                      "Jun",
                      "Jul",
                      "Aug",
                      "Sep",
                      "Oct",
                      "Nov",
                      "Dec"
                    ], onChange: (v) {}),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: MyDropDown(dropDowns: [
                      'Year',
                      ...List.generate(11, (int index) => "19${index + 88}"),
                      '2000',
                      '2001',
                      '2002',
                      '2003',
                      '2004',
                      '2005',
                      '2006',
                      '2007',
                      '2008',
                      '2009',
                      '2010',
                      '2012',
                      '2013',
                      '2014',
                      '2015',
                      '2016',
                      '2017',
                      '2018',
                      '2019',
                      '2020',
                      '2021',
                    ], onChange: (v) {}),
                  ),
                  SizedBox(width: 10.w)
                ],
              ),
              SizedBox(height: 16.h),
              Text('Gender',
                  style: FontStyleUtilities.h4(
                    fontColor: isLight ? Colors.black : Colors.white,
                  ).copyWith(fontSize: 19, fontWeight: FontWeight.w500)),
              SizedBox(height: 10.h),
              ToggleWrapper(onChanged: (v) {}),
              SizedBox(height: 30.h),
              Button(
                  tittle: 'Save',
                  onTap: () {
                    NavigationUtil.to(context, const BottomNav());
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleWrapper extends StatefulWidget {
  const ToggleWrapper({Key? key, required this.onChanged}) : super(key: key);
  final ValueChanged<int> onChanged;

  @override
  State<ToggleWrapper> createState() => _ToggleWrapperState();
}

class _ToggleWrapperState extends State<ToggleWrapper> {
  int _selectedIndex = 0;
  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(_selectedIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        Expanded(
            child: Button(
                elevation: 0,
                textColor: _selectedIndex == 0 ? null : const Color(0xffABABAB),
                color: _selectedIndex == 0
                    ? null
                    : isLight
                        ? Colors.white
                        : ColorUtil.surfaceDark,
                tittle: "Male",
                onTap: () {
                  _setIndex(0);
                })),
        SizedBox(width: 23.w),
        Expanded(
            child: Button(
                elevation: 0,
                textColor: _selectedIndex == 1 ? null : const Color(0xffABABAB),
                color: _selectedIndex == 1
                    ? null
                    : isLight
                        ? Colors.white
                        : ColorUtil.surfaceDark,
                tittle: "Female",
                onTap: () {
                  _setIndex(1);
                })),
      ],
    );
  }
}

class MyDropDown extends StatefulWidget {
  const MyDropDown({
    Key? key,
    required this.dropDowns,
    required this.onChange,
  }) : super(key: key);
  final ValueChanged<String> onChange;
  final List<String> dropDowns;

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String selectedValue = '';
  @override
  void initState() {
    selectedValue = widget.dropDowns.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 50,
      padding:
          EdgeInsets.only(left: 12.w, right: 10.w, top: 13.h, bottom: 13.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: isLight ? Colors.white : ColorUtil.surfaceDark,
      ),
      child: DropdownButton<String>(
          icon: Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: const SvgIcon('assets/Icons/drop_down.svg')),
          value: selectedValue,
          underline: Container(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.r),
          alignment: Alignment.centerRight,
          style: FontStyleUtilities.t1(
              fontWeight: FWT.bold, fontColor: const Color(0xffABABAB)),
          items: widget.dropDowns
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) {
            selectedValue = value ?? widget.dropDowns.first;
            setState(() {});
          }),
    );
  }
}

class ProfileLogo extends StatelessWidget {
  const ProfileLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28.5.h, vertical: 24.25.h),
          height: 91.h,
          width: 91.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45.5.h),
              color: const Color(0xff3FACC7).withOpacity(.10)),
          child: CustomPaint(
            painter: ProfilePainter(),
          ),
        ),
        Positioned(
          bottom: 7.071.h,
          right: 2.071.h,
          child: Container(
            padding: EdgeInsets.all(3.h),
            height: 20.h,
            width: 20.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle,
                gradient: AppGradients.blueGradient),
            child: const SvgIcon('assets/Icons/Camera.svg'),
          ),
        )
      ],
    );
  }
}
