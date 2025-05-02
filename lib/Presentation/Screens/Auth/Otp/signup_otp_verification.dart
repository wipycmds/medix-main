import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Screens/Auth/Sign_up/sign_up.dart';
import 'package:medix/Presentation/Screens/Main/Home/Compo/bottomnav.dart';
import 'package:medix/Presentation/Screens/Pre_log/setup_profil.dart';
import 'dart:async';
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
                  var data = {
                    'contact_value': widget.value,
                    'security_code': _otpController.text,
                  };

                  verifyCode(data, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> verifyCode(Map<String, String> data, BuildContext context) async {
  final apiClient = ApiClient(http.Client());

 
  try {
    final response = await apiClient.post('auth/patient/verify-code', params: data);
  
  
      if (response.statusCode == 201) {  
      
       NavigationUtil.to(context, const BottomNav());

      } else if (response.statusCode == 400) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid verification code.')),
        );
      }else if (response.statusCode == 410) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification code has expired.')),
        );
      }
      else if (response.statusCode == 404) {
         NavigationUtil.to(context, const SignUp());
      }
      
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please check your credentials.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      apiClient.client.close();
    }
  } 
}

