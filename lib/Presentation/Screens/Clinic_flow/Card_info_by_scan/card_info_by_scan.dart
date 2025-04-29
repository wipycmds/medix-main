import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Add_card/add_card.dart';
import '../Add_card/card_theme.dart';

class CardInfoByScan extends StatelessWidget {
  const CardInfoByScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            elevation: 4,
            title: Text('Add A Payment'),
            leading: MyBackButton(),
          ),
          SliverSizedBox(height: 20.h),
          SliverSizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scan Completed.Now verify your data.',
                    style: FontStyleUtilities.h5(
                            fontWeight: FWT.medium,
                            fontColor: isLight ? Colors.black : Colors.white)
                        .copyWith(fontSize: 18.sp),
                  ),
                  15.height(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PaymentCard(
                        style: cardStyles[0],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverSizedBox(
            height: 16.h,
          ),
          SliverSizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Information',
                    style: FontStyleUtilities.h4(
                            fontWeight: FWT.semiBold,
                            fontColor: isLight
                                ? Colors.black
                                : Colors.white.withOpacity(0.80))
                        .copyWith(fontSize: 19.sp),
                  ),
                  21.height(),
                  const FilledDetailsTextField(
                      trailing: SvgIcon(
                        'assets/Icons/visa.svg',
                        color: Color(0xffC8C9CA),
                      ),
                      tittle: 'Card Number',
                      value: '5282 3456 7890 1289'),
                  16.height(),
                  const FilledDetailsTextField(
                      tittle: 'Card Holder name', value: 'Zack Foster'),
                  16.height(),
                  Row(
                    children: [
                      const Expanded(
                        child: FilledDetailsTextField(
                            tittle: 'Expiry Date', value: '03/25'),
                      ),
                      21.width(),
                      const Expanded(
                        child: FilledDetailsTextField(
                            mainAxisAlignment: MainAxisAlignment.center,
                            tittle: 'CVV',
                            value: '980'),
                      ),
                    ],
                  ),
                  58.height(),
                  Button(
                      tittle: 'Continue',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                  28.height(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FilledDetailsTextField extends StatelessWidget {
  const FilledDetailsTextField(
      {Key? key,
      required this.tittle,
      required this.value,
      this.trailing,
      this.mainAxisAlignment})
      : super(key: key);
  final MainAxisAlignment? mainAxisAlignment;
  final Widget? trailing;
  final String tittle, value;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: FontStyleUtilities.h5(
                  fontWeight: FWT.regular,
                  fontColor:
                      isLight ? Colors.black : Colors.white.withOpacity(0.80))
              .copyWith(fontSize: 18),
        ),
        16.height(),
        Container(
          padding: EdgeInsets.only(left: 20.w),
          height: 54.h,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: isLight ? const Color(0xffE8E8E8) : ColorUtil.surfaceDark),
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              Text(
                value,
                style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium, fontColor: const Color(0xffC4C4C4)),
              ),
              if (trailing != null) const Spacer(),
              if (trailing != null) trailing!,
              SizedBox(
                width: trailing != null ? 10.35.w : 20.w,
              )
            ],
          ),
        )
      ],
    );
  }
}
