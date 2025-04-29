import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/vouchers.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Payment_method/payment_method.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVoucher extends StatelessWidget {
  const AddVoucher({Key? key, this.onTap}) : super(key: key);

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
                              child: SvgIcon('assets/Icons/arrow_back.svg',
                                  color: isLight ? null : Colors.white),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: onTap ??
                                  () {
                                    NavigationUtil.to(
                                        context, const SelectPaymentMethod());
                                  },
                              child: Text(
                                'Skip',
                                style: FontStyleUtilities.h6(
                                    fontWeight: FWT.regular,
                                    fontColor: isLight
                                        ? const Color(0xff2D2D2D)
                                        : Colors.white.withOpacity(0.70)),
                              ),
                            ),
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
                    'Add Voucher',
                    style: FontStyleUtilities.h2(
                            fontWeight: FWT.medium,
                            fontColor: isLight ? Colors.black : Colors.white)
                        .copyWith(fontSize: 28),
                  ),
                  2.height(),
                  Text(
                    'Extra voucher received from Medical',
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
                    delegate: SliverChildListDelegate([
                  OfferCardWrapper(
                    onChanged: (int value) {},
                  )
                ])),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              width: 375.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Button(
                    tittle: 'Add Voucher',
                    onTap: onTap ??
                        () {
                          NavigationUtil.to(
                              context, const SelectPaymentMethod());
                        }),
              )),
        ],
      ),
    );
  }
}

class OfferCardWrapper extends StatefulWidget {
  const OfferCardWrapper({Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<int> onChanged;
  @override
  _OfferCardWrapperState createState() => _OfferCardWrapperState();
}

class _OfferCardWrapperState extends State<OfferCardWrapper> {
  int _selectedIndex = 0;
  void _setIndex(int index) {
    _selectedIndex = index;
    widget.onChanged(_selectedIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vouchers.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                _setIndex(index);
              },
              child: OfferCard(
                  icon: vouchers[index].icon,
                  offer: vouchers[index].offer,
                  expiryDate: vouchers[index].expiryData,
                  isSelected: _selectedIndex == index,
                  color: vouchers[index].color),
            ));
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard(
      {Key? key,
      required this.icon,
      required this.offer,
      required this.expiryDate,
      required this.isSelected,
      required this.color})
      : super(key: key);
  final bool isSelected;
  final int color;
  final String icon, offer, expiryDate;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: isSelected
                  ? ColorUtil.primaryColor
                  : isLight
                      ? Colors.black12
                      : Colors.white12),
          color: isSelected
              ? isLight
                  ? const Color(0xffF5FDFF)
                  : ColorUtil.surfaceDark
              : isLight
                  ? Colors.white
                  : ColorUtil.surfaceDark,
          borderRadius: BorderRadius.circular(15.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              height: 60.h,
              width: 60.h,
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(color: Color(color)),
              child: SvgIcon(
                icon,
                fit: BoxFit.cover,
              ),
            ),
          ),
          8.width(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer,
                  style: FontStyleUtilities.h6(
                      height: 1.2,
                      fontWeight: FWT.medium,
                      fontColor: isLight ? Colors.black : Colors.white),
                ),
                8.height(),
                Text(
                  expiryDate,
                  style: FontStyleUtilities.t4(
                      height: 1,
                      fontWeight: FWT.regular,
                      fontColor: isLight
                          ? const Color(0xffB9B9B9)
                          : Colors.white.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          25.width(),
          RoundedRadioButton(isActive: isSelected)
        ],
      ),
    );
  }
}
