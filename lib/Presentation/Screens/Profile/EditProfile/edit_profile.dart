import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Shared/illness_tag.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String data = '';
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Edit Profile'),
        leading: const MyBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height(),
              Text(
                'Personal Info',
                style: FontStyleUtilities.h4(
                  fontWeight: FWT.bold,
                  fontColor:
                      isLight ? Colors.black : Colors.white.withOpacity(0.80),
                ),
              ),
              18.height(),
              CustomTextField(
                  prefix: Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: SizedBox(
                      width: 40.w,
                      child: NumberDropDown(onChanged: (int index) {}),
                    ),
                  ),
                  hint: '000-0000-0000',
                  onTap: () {},
                  tittle: 'Phone Number'),
              18.height(),
              CustomTextField(
                  hint: 'E.g. yourName@gmail.com',
                  tittle: 'Email',
                  onTap: () {}),
              18.height(),
              SetGender(onChanged: (value) {}),
              18.height(),
              CustomTextField(
                hint: data != '' ? data : 'dd/mm/yyyy',
                enabled: false,
                tittle: 'Date Of Birth',
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
                                foregroundColor: ColorUtil.primaryColor, textStyle: TextStyle(fontSize: 12.sp), // button text color
                              ),
                            ), dialogTheme: DialogThemeData(backgroundColor: isLight ? Colors.white : ColorUtil.scaffoldDark),
                          ),
                          child: child!,
                        );
                      });
                  setState(() {
                    data =
                        '${pickDate?.day}/${pickDate?.month}/${pickDate?.year}';
                  });
                                },
                suffix: Icon(
                  CupertinoIcons.calendar,
                  color: isLight
                      ? ColorUtil.baseTextColor
                      : Colors.white.withOpacity(0.80),
                ),
              ),
              20.height(),
              Text(
                'Medical Info',
                style: FontStyleUtilities.h4(
                  fontWeight: FWT.bold,
                  fontColor:
                      isLight ? Colors.black : Colors.white.withOpacity(0.60),
                ),
              ),
              18.height(),
              CustomTextField(
                hint: 'E.g.Asthma',
                tittle: 'Illness',
                bottom: Wrap(
                  spacing: 6.w,
                  runSpacing: 8.w,
                  children: [
                    'Migraine',
                    'Asthma',
                    'Low Blood Sugar',
                    'Diabetes',
                    'Kidney Stone',
                  ].map((e) => IllnessTag(value: e)).toList(),
                ),
                onTap: () {},
              ),
              18.height(),
              CustomTextField(
                  suffix: Icon(
                    Icons.attachment,
                    color: isLight
                        ? ColorUtil.baseTextColor
                        : Colors.white.withOpacity(0.60),
                  ),
                  hint: 'Pdf or Doc files are allowed',
                  onTap: () {},
                  tittle: 'Upload Your Medical Report'),
              18.height(),
              CustomTextField(
                prefix: Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: SizedBox(
                    width: 40.w,
                    child: NumberDropDown(onChanged: (int index) {}),
                  ),
                ),
                hint: '000-0000-0000',
                tittle: 'Emergency Number',
                onTap: () {},
              ),
              36.height()
            ],
          ),
        ),
      ),
    );
  }
}

class SetGender extends StatefulWidget {
  const SetGender({Key? key, required this.onChanged}) : super(key: key);
  final ValueChanged<String> onChanged;

  @override
  State<SetGender> createState() => _SetGenderState();
}

class _SetGenderState extends State<SetGender> {
  final List<String> _genders = ['Male', 'Female'];
  int _selectedIndex = 0;
  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(_genders[_selectedIndex]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gender',
              style: FontStyleUtilities.t1(
                fontWeight: FWT.medium,
                fontColor:
                    isLight ? Colors.black : Colors.white.withOpacity(0.80),
              ).copyWith(fontSize: 14.sp)),
          10.height(),
          Row(
            children: [
              ...List.generate(
                  2,
                  (index) => GestureDetector(
                        onTap: () {
                          _setIndex(index);
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: index == 0 ? 100.w : 0),
                          child: Row(
                            children: [
                              CustomRadioButton(
                                  isSelected: _selectedIndex == index,
                                  onTap: () {
                                    _setIndex(index);
                                  }),
                              10.width(),
                              Text(
                                _genders[index],
                                style: FontStyleUtilities.t2(
                                  fontWeight: FWT.medium,
                                  fontColor: isLight
                                      ? Colors.black
                                      : Colors.white.withOpacity(0.80),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
            ],
          ),
        ],
      ),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {Key? key, required this.isSelected, required this.onTap})
      : super(key: key);
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24.h,
        width: 24.h,
        padding: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: isSelected
                  ? ColorUtil.primaryColor
                  : ColorUtil.mediumTextColor),
          color: ColorUtil.primaryColor.withOpacity(.05),
        ),
        child: CircleAvatar(
          backgroundColor:
              isSelected ? ColorUtil.primaryColor : Colors.transparent,
        ),
      ),
    );
  }
}

class NumberDropDown extends StatefulWidget {
  
  const NumberDropDown({Key? key, required this.onChanged}) : super(key: key);
  final ValueChanged<int> onChanged;

  @override
  _NumberDropDownState createState() => _NumberDropDownState();
}

class _NumberDropDownState extends State<NumberDropDown> {
  int currentCode = 1;
  void onChanged(int? newCode) {
    currentCode = newCode ?? 1;
    widget.onChanged(currentCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return DropdownButton<int>(
        underline: const SizedBox.shrink(),
        isDense: true,
        icon: const Icon(Icons.expand_more_sharp),
        iconSize: 20,
        dropdownColor: isLight ? Colors.white : ColorUtil.surfaceDark,
        isExpanded: true,
        value: currentCode,
        items: List.generate(
            100,
            (index) => DropdownMenuItem<int>(
                value: index,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '+ ',
                    style: FontStyleUtilities.t4(
                        fontColor: ColorUtil.primaryColor,
                        fontWeight: FWT.medium),
                  ),
                  TextSpan(
                    text: (index + 1).toString(),
                    style: FontStyleUtilities.t4(
                        fontWeight: FWT.medium,
                        fontColor: isLight ? Colors.black : Colors.white),
                  )
                ])))),
        onChanged: onChanged);
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.prefix,
      this.suffix,
      this.bottom,
      this.enabled = true,
      this.controller,
      required this.onTap,
      required this.hint,
      required this.tittle})
      : super(key: key);
  final Widget? prefix, suffix, bottom;
  final String hint, tittle;
  final bool enabled;
  final TextEditingController? controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isLight
            ? ColorUtil.primaryColor.withOpacity(.05)
            : ColorUtil.primaryColor.withOpacity(.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tittle,
            style: FontStyleUtilities.t1(
              fontWeight: FWT.medium,
              fontColor:
                  isLight ? Colors.black : Colors.white.withOpacity(0.80),
            ).copyWith(fontSize: 14.sp),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                if (prefix != null) prefix!,
                Expanded(
                    child: TextField(
                  enabled: enabled,
                  controller: controller,
                  decoration: InputDecoration.collapsed(
                      hintText: hint,
                      hintStyle: FontStyleUtilities.t1(
                          fontWeight: FWT.medium,
                          fontColor: Colors.grey.shade600)),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                )),
                if (suffix != null) suffix!,
              ],
            ),
          ),
          8.height(),
          if (bottom != null) bottom!,
          if (bottom != null) 6.height()
        ],
      ),
    );
  }
}
