import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Auth/New_password/add_new_password.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  late TextEditingController _emailController;
  late ClockController _clockController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _clockController = ClockController();
    super.initState();
  }

  @override
  void dispose() {
    _clockController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isLight = Theme.of(context).brightness == Brightness.light;
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
              SizedBox(width: size.width),
              SizedBox(
                  height: 242.79.h,
                  width: 242.99.w,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SvgIcon(
                        'assets/Illustration/otp_verification.svg',
                        height: 245.79.h,
                        fit: BoxFit.cover,
                        width: 242.99.w,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Verification',
                          style: FontStyleUtilities.h3(
                            fontWeight: FWT.medium,
                            fontColor: isLight
                                ? Colors.black
                                : Colors.white.withOpacity(0.80),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 11.h),
              Text(
                'Enter the 4-digit that we have sent via the\n email address ****x@gmail.com',
                style: FontStyleUtilities.h6(
                    fontWeight: FWT.regular,
                    fontColor: isLight
                        ? const Color(0xff2d2d2d)
                        : Colors.white.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22.h),
              const OtpField(),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Text(
                    'Don’t have a code?',
                    style: FontStyleUtilities.h6(
                      fontWeight: FWT.regular,
                      fontColor: isLight
                          ? ColorUtil.baseTextColor.withOpacity(.60)
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      _clockController.reset();
                    },
                    child: Text(
                      'Re-Send',
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: ColorUtil.primaryColor),
                    ),
                  ),
                  const Spacer(),
                  TimerWidget(
                    clockController: _clockController,
                  ),
                ],
              ),
              SizedBox(height: 153.h),
              Button(
                  tittle: 'Continue',
                  onTap: () {
                    NavigationUtil.to(context, const AddNewPassWord());
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  const OtpField({Key? key, this.controller}) : super(key: key);
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return PinCodeTextField(
      // validator: (value) {},
      backgroundColor: Colors.transparent,
      animationCurve: Curves.decelerate,
      animationType: AnimationType.scale,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      cursorColor: ColorUtil.primaryColor,
      pinTheme: PinTheme(
          disabledColor: isLight ? Colors.white : ColorUtil.surfaceDark,
          inactiveFillColor: isLight ? Colors.white : ColorUtil.surfaceDark,
          selectedColor: ColorUtil.primaryColor,
          selectedFillColor: isLight ? Colors.white : ColorUtil.surfaceDark,
          activeColor: isLight ? Colors.white : ColorUtil.surfaceDark,
          activeFillColor: isLight ? Colors.white : ColorUtil.surfaceDark,
          inactiveColor: isLight ? Colors.white : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
          shape: PinCodeFieldShape.box,
          fieldWidth: 70.w,
          fieldHeight: 54.h),
      appContext: context,
      length: 4,
      onChanged: (value) {},
    );
  }
}

class ClockController extends ChangeNotifier {
  late final Timer _timer;
  initTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _decreaseCount();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  reset() {
    _minutes = 1;
    _seconds = 60;
    notifyListeners();
  }

  _decreaseCount() {
    if (_seconds != 0) {
      _seconds--;
      notifyListeners();
    } else if (_seconds == 0 && _minutes != 0) {
      _minutes--;
      _seconds = 60;
      notifyListeners();
    }
  }

  int _minutes = 1;
  int _seconds = 60;

  int get minute => _minutes;
  int get second => _seconds;
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.clockController})
      : super(key: key);

  final ClockController clockController;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      widget.clockController.initTimer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.clockController,
      builder: (context, child) => Text(
          '${widget.clockController.minute}:${widget.clockController.second}',
          style: FontStyleUtilities.h6(
              fontWeight: FWT.regular, fontColor: ColorUtil.mediumTextColor)),
    );
  }
}
