import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDependent extends StatefulWidget {
  const AddDependent({Key? key}) : super(key: key);

  @override
  State<AddDependent> createState() => _AddDependentState();
}

class _AddDependentState extends State<AddDependent> {
  final ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  TextEditingController dateController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void scrollToEnd() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void initState() {
    focusNode3.addListener(() {
      scrollToEnd();
    });
    // focusNode3.addListener(() {
    //   scrollToEnd();
    // });

    super.initState();
  }

  late String data = '';
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    MediaQueryData data = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              MyStickyHeader(
                  height: data.padding.top + kToolbarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: data.size.width,
                      ),
                      SizedBox(height: data.padding.top),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgIcon('assets/Icons/arrow_back.svg',
                                color: isLight ? null : Colors.white)),
                      )
                    ],
                  )),
              SliverSizedBox(height: 23.h),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Text(
                    'Add A Dependent',
                    style: FontStyleUtilities.h2(
                            fontWeight: FWT.medium,
                            fontColor: isLight ? null : Colors.white)
                        .copyWith(fontSize: 28),
                  ),
                  24.height(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 375.w),
                      Container(
                          padding: EdgeInsets.all(20.h),
                          height: 63.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isLight
                                ? const Color(0xffD7F2F9).withOpacity(.50)
                                : ColorUtil.surfaceDark,
                          ),
                          child: SvgIcon(
                            'assets/Icons/Camera.svg',
                            height: 30.h,
                            color: ColorUtil.primaryColor,
                          )),
                    ],
                  ),
                  36.height(),
                  BuildTextField(
                      tittle: 'First Name*',
                      hint: 'Enter your first name...',
                      isLight: isLight,
                      controller: nameController,
                      onTap: () {},
                      focusNode: focusNode),
                  BuildTextField(
                      tittle: 'Last Name*',
                      hint: 'Enter your Last name...',
                      isLight: isLight,
                      controller: lastNameController,
                      onTap: () {},
                      focusNode: focusNode2),
                  BuildTextField(
                    tittle: 'Date Of Birth*',
                    hint: 'DD/MM/YYYY...',
                    isLight: isLight,
                    controller: dateController,
                    // initialValue: data,
                    readOnly: true,
                    enabled: false,
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
                            '${pickDate?.day}/${pickDate?.month}/${pickDate?.year}' as MediaQueryData;
                      });
                                        },
                    focusNode: focusNode4,
                  ),
                  BuildTextField(
                      tittle: 'Phone Number*',
                      hint: 'Enter your phone number...',
                      isLight: isLight,
                      focusNode: focusNode3,
                      controller: phoneController,
                      onTap: () {}),
                  Row(
                    children: [
                      Expanded(
                        child: DependentDropDownField(
                            tittle: 'Gender',
                            onChanged: (v) {},
                            values: const ['Male', 'Female', 'Other']),
                      ),
                      24.width(),
                      Expanded(
                        child: DependentDropDownField(
                            tittle: 'Blood Group',
                            onChanged: (v) {},
                            values: const [
                              'A+',
                              'A-',
                              'B+',
                              'B-',
                              'O+',
                              'O-',
                              'AB+',
                              'AB-',
                            ]),
                      ),
                    ],
                  )
                ])),
              ),
              SliverSizedBox(
                height: 15.h,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                  child: Button(
                      tittle: 'Add',
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
}

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.tittle,
    required this.hint,
    this.readOnly = false,
    required this.controller,
    required this.isLight,
    this.enabled = true,
    this.initialValue = '',
    required this.focusNode,
    required this.onTap,
  }) : super(key: key);

  final String tittle;
  final String hint;
  final bool enabled;
  final bool isLight;
  final String initialValue;
  final bool readOnly;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    controller.text = initialValue;
    UnderlineInputBorder border = UnderlineInputBorder(
        borderSide: BorderSide(
            width: 2.h, color: const Color(0xffD1D1D1).withOpacity(.32)));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: FontStyleUtilities.h6(
              fontWeight: FWT.medium,
              fontColor:
                  isLight ? Colors.black : Colors.white.withOpacity(0.8)),
        ),
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            onTap: onTap,
            focusNode: focusNode,
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              hintStyle: FontStyleUtilities.h6(
                  fontColor: const Color(0xffB9B9B9).withOpacity(.80)),
              hintText: hint,
              border: border,
              enabledBorder: border,
              disabledBorder: border,
            ),
          ),
        ),
        24.height()
      ],
    );
  }
}

class DependentDropDownField extends StatefulWidget {
  const DependentDropDownField({
    Key? key,
    required this.tittle,
    required this.onChanged,
    required this.values,
  }) : super(key: key);
  final String tittle;
  final ValueChanged<String?> onChanged;
  final List<String> values;

  @override
  State<DependentDropDownField> createState() => _DependentDropDownFieldState();
}

class _DependentDropDownFieldState extends State<DependentDropDownField> {
  String value = '';
  @override
  void initState() {
    value = widget.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.tittle,
          style: FontStyleUtilities.h6(
              fontWeight: FWT.medium,
              fontColor:
                  isLight ? Colors.black : Colors.white.withOpacity(0.8)),
        ),
        DropdownButton<String>(
            dropdownColor: isLight ? Colors.white : ColorUtil.surfaceDark,
            icon: Transform.scale(
              scale: 1.4,
              child: const RotatedBox(
                quarterTurns: 1,
                child: SvgIcon(
                  'assets/Icons/arrow_right.svg',
                  color: ColorUtil.primaryColor,
                ),
              ),
            ),
            underline: Divider(
              height: 1,
              thickness: 1,
              color: const Color(0xffD1D1D1).withOpacity(.32),
            ),
            value: value,
            style: FontStyleUtilities.h6(
                fontWeight: FWT.medium,
                fontColor: isLight
                    ? ColorUtil.baseTextColor
                    : Colors.white.withOpacity(0.8)),
            isExpanded: true,
            items: widget.values
                .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: const Color(0xffB9B9B9).withOpacity(.80)),
                    )))
                .toList(),
            onChanged: (v) {
              value = v ?? widget.values.first;
              widget.onChanged(v);
              setState(() {});
            })
      ],
    );
  }
}
