import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/pay_methods.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Add_card/add_card.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Appointment_Confirm_Dialog/appointment_confirm_dialog.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);

    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
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
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgIcon(
                                  'assets/Icons/arrow_back.svg',
                                  color: isLight
                                      ? Colors.black
                                      : Colors.white.withOpacity(0.90),
                                )),
                            const Spacer(),
                          ],
                        ),
                      )
                    ],
                  )),
              SliverSizedBox(height: 23.h),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Text(
                    'Add A Payment',
                    style: FontStyleUtilities.h2(
                            fontWeight: FWT.medium,
                            fontColor: isLight
                                ? Colors.black
                                : Colors.white.withOpacity(0.90))
                        .copyWith(fontSize: 28),
                  ),
                  2.height(),
                  Text(
                    'Choose your payment method for hospital\nclinic visits',
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.regular,
                        fontColor: isLight
                            ? Colors.black.withOpacity(.50)
                            : Colors.white.withOpacity(0.70)),
                  ),
                ])),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                sliver: SliverList(
                    delegate: SliverChildListDelegate(
                        [PaymentMethodWrapper(onChanged: (int index) {})])),
              ),
              SliverSizedBox(
                child: Container(
                  height: 54.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                      color: isLight ? Colors.white : ColorUtil.onDarkSurface,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: InkWell(
                    onTap: () {
                      NavigationUtil.to(context, const AddCard());
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add New Card',
                            style: FontStyleUtilities.h6(
                                height: 1.5.h,
                                fontWeight: FWT.medium,
                                fontColor: ColorUtil.primaryColor),
                          ),
                          8.width(),
                          const SvgIcon('assets/Icons/Plus.svg')
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              width: 375.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Button(
                    tittle: 'Save',
                    onTap: onTap ??
                        () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  AppointmentConfirmDialog(isLight: isLight));
                        }),
              )),
        ],
      ),
    );
  }
}

class PaymentMethodWrapper extends StatefulWidget {
  const PaymentMethodWrapper({Key? key, required this.onChanged})
      : super(key: key);

  final ValueChanged<int> onChanged;
  @override
  _PaymentMethodWrapperState createState() => _PaymentMethodWrapperState();
}

class _PaymentMethodWrapperState extends State<PaymentMethodWrapper> {
  int _selectedIndex = 0;
  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(_selectedIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: methods.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                _setIndex(index);
              },
              child: PaymentMethodCard(
                method: methods[index].name,
                icon: methods[index].icon,
                isSelected: _selectedIndex == index,
                color: index == 0
                    ? isLight
                        ? Colors.black
                        : Colors.white.withOpacity(0.90)
                    : null,
              ),
            ));
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard(
      {Key? key,
      required this.isSelected,
      required this.icon,
      this.color,
      required this.method})
      : super(key: key);

  final String icon, method;
  final bool isSelected;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: isSelected ? ColorUtil.primaryColor : Colors.transparent),
          color: isSelected
              ? isLight
                  ? const Color(0xffF5FDFF).withOpacity(1)
                  : ColorUtil.surfaceDark
              : isLight
                  ? Colors.white
                  : ColorUtil.surfaceDark,
          borderRadius: BorderRadius.circular(15.r)),
      child: Row(
        children: [
          SizedBox(
            height: 20.h,
            width: 20.h,
            child: SvgIcon(
              icon,
              color: color,
            ),
          ),
          13.width(),
          Text(
            method,
            style: isSelected
                ? FontStyleUtilities.h6(
                    fontWeight: FWT.medium,
                    height: 1,
                    fontColor:
                        isLight ? Colors.black : Colors.white.withOpacity(0.80))
                : FontStyleUtilities.t1(
                    height: 1,
                    fontWeight: FWT.regular,
                    fontColor: isLight
                        ? Colors.black
                        : Colors.white.withOpacity(0.70)),
          ),
          const Spacer(),
          RoundedRadioButton(
            isActive: isSelected,
            scale: .8,
          )
        ],
      ),
    );
  }
}
