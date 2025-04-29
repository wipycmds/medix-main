import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Add_card/card_theme.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Card_info_by_scan/card_info_by_scan.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  late TextEditingController _cardNumberController,
      _dateController,
      _cvvController,
      _nameController;
  @override
  void initState() {
    _cardNumberController = TextEditingController(text: '5282 3456 7890 1289');
    _dateController = TextEditingController(text: '03/25');
    _cvvController = TextEditingController(text: '980');
    _nameController = TextEditingController(text: 'Zack Foster');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text('Add Card'),
            leading: MyBackButton(),
          ),
          SliverSizedBox(height: 20.h),
          SliverSizedBox(
            height: 170.h,
            child: ListView.builder(
              physics: const PageScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, int index) => Padding(
                padding: EdgeInsets.only(left: index == 0 ? 16.w : 0),
                child: PaymentCard(
                  style: cardStyles[index],
                ),
              ),
              itemCount: cardStyles.length,
            ),
          ),
          SliverSizedBox(height: 25.h),
          SliverSizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  CardTextField(
                    formatter: MaskedTextInputFormatter(
                        mask: 'xxxx-xxxx-xxxx-xxxx', separator: '_'),
                    tittle: 'Card Number',
                    keyBoardType: TextInputType.number,
                    controller: _cardNumberController,
                  ),
                  16.height(),
                  Row(
                    children: [
                      Expanded(
                          child: CardTextField(
                        tittle: 'Expiry Date',
                        keyBoardType: TextInputType.datetime,
                        controller: _dateController,
                      )),
                      21.width(),
                      Expanded(
                          child: CardTextField(
                        tittle: 'CVV',
                        keyBoardType: TextInputType.number,
                        align: TextAlign.center,
                        controller: _cvvController,
                      )),
                    ],
                  ),
                  16.height(),
                  CardTextField(
                    tittle: 'Name on Card',
                    controller: _nameController,
                  ),
                  31.height(),
                  Button(
                      tittle: 'Add Card',
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  22.height(),
                  MyOutlinedButton(
                      tittle: 'Scan',
                      onTap: () async {
                        // CardDetails? details = await CardScanner.scanCard(
                        //     scanOptions: const CardScanOptions(
                        //   scanCardHolderName: true,
                        // ));
                        // if (details != null) {
                        //   log(details.toString());
                        // }
                        NavigationUtil.to(context, const CardInfoByScan());
                      }),
                  30.height()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardTextField extends StatelessWidget {
  const CardTextField(
      {Key? key,
      required this.tittle,
      this.controller,
      this.align,
      this.keyBoardType,
      this.formatter})
      : super(key: key);
  final String tittle;
  final TextEditingController? controller;
  final TextAlign? align;
  final TextInputType? keyBoardType;
  final TextInputFormatter? formatter;
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: ColorUtil.primaryColor, width: 1.h));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: FontStyleUtilities.h5(
                  fontWeight: FWT.regular,
                  fontColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white.withOpacity(0.80))
              .copyWith(fontSize: 18),
        ),
        16.height(),
        TextField(
          inputFormatters: [if (formatter != null) formatter!],
          keyboardType: keyBoardType,
          textAlign: align ?? TextAlign.start,
          controller: controller,
          style: FontStyleUtilities.h4(
              fontColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white.withOpacity(0.80)),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.h),
              filled: true,
              border: border,
              enabledBorder: border,
              constraints: BoxConstraints(maxHeight: 54.h)),
        )
      ],
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({Key? key, required this.style}) : super(key: key);
  final CardStyle style;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      height: 159.h,
      width: 300.w,
      decoration: BoxDecoration(
          gradient: style.gradient, borderRadius: BorderRadius.circular(22.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Stack(
          children: [
            Positioned(
                child: SvgIcon(
              'assets/Icons/circles.svg',
              color: style.illustrationColor,
            )),
            Positioned(
              top: 22.h,
              right: 25.w,
              child: const SvgIcon('assets/Icons/chip.svg'),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: SvgIcon(
                  'assets/Icons/flower_card.svg',
                  color: style.illustrationColor,
                )),
            Positioned(
              top: 22.h,
              left: 23.75.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SvgIcon('assets/Icons/visa_card.svg'),
                  29.61.height(),
                  Text(
                    '****     ****     ****     1289',
                    style: FontStyleUtilities.h4(
                        fontWeight: FWT.regular, fontColor: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 14.h,
              left: 23.75.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Holder',
                    style: FontStyleUtilities.t4(
                        fontWeight: FWT.regular, fontColor: Colors.white),
                  ),
                  7.height(),
                  Text(
                    'Zack Foster',
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.medium, fontColor: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 19.h,
              right: 14.w,
              child: Text(
                'Debit Card',
                style: FontStyleUtilities.t4(
                    fontWeight: FWT.regular, fontColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
