import 'package:flutter/material.dart';
import 'dart:async';

import 'package:medix/Presentation/Screens/Auth/New_password/add_new_password.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignupOtpVerification extends StatefulWidget {
  final String type; // 'email' or 'mobile'
  final String value;

  const SignupOtpVerification({Key? key, 
    // super.key,
    required this.type,
    required this.value,
  }) : super(key: key);

  @override
  State<SignupOtpVerification> createState() => _SignupOtpVerificationState();
}

class _SignupOtpVerificationState extends State<SignupOtpVerification> {
  late TextEditingController _otpController;
  // late ClockController _clockController;

  @override

  void initState() {
    _otpController = TextEditingController();
    // _clockController = ClockController();
    super.initState();
  }

  @override
  void dispose() {
    // _clockController.dispose();
    // _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44.w,
        leading: const MyBackButton(),
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              SvgIcon(
                'assets/Illustration/otp_verification.svg',
                height: 220.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 12.h),
              Text(
                'Enter the 6-digit code sent to your ${widget.type} address:\n${widget.value}',
                style: FontStyleUtilities.h6(
                  fontWeight: FWT.regular,
                  fontColor: isLight
                      ? Color(0xff2d2d2d)
                      : Colors.white.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22.h),
              PinCodeTextField(
                controller: _otpController,
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                cursorColor: ColorUtil.primaryColor,
                enableActiveFill: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 54.h,
                  fieldWidth: 50.w,
                  activeFillColor:
                      isLight ? Colors.white : ColorUtil.surfaceDark,
                  selectedFillColor:
                      isLight ? Colors.white : ColorUtil.surfaceDark,
                  inactiveFillColor:
                      isLight ? Colors.white : ColorUtil.surfaceDark,
                  inactiveColor: Colors.grey.shade300,
                  activeColor: Colors.transparent,
                  selectedColor: ColorUtil.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onChanged: (_) {},
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Text(
                    'Didn’t receive the code?',
                    style: FontStyleUtilities.h6(
                      fontWeight: FWT.regular,
                      fontColor: isLight
                          ? ColorUtil.baseTextColor.withOpacity(.60)
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    // onTap: _clockController.reset,
                    child: Text(
                      'Re-Send',
                      style: FontStyleUtilities.h6(
                        fontWeight: FWT.medium,
                        fontColor: ColorUtil.primaryColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // TimerWidget(clockController: _clockController),
                ],
              ),
              SizedBox(height: 150.h),
              Button(
                tittle: 'Verify',
                onTap: () {
                  print('object');
                  // TODO: Add OTP verification logic here
                  // NavigationUtil.to(context, const AddNewPassWord());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
