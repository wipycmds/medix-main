import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Auth/Otp/otp_verification.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _emailController;
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44.w,
        leading: const MyBackButton(),
        title: const Text('Forgot password'),
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
                        'assets/Illustration/forget_password.svg',
                        height: 245.79.h,
                        fit: BoxFit.cover,
                        width: 242.99.w,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Verify Email',
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
                'Enter your email or number then we will send\nyou a code to reset your password',
                style: FontStyleUtilities.h6(
                  fontWeight: FWT.regular,
                  fontColor: isLight
                      ? const Color(0xff2d2d2d)
                      : Colors.white.withOpacity(0.60),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22.h),
              MyTextField(
                controller: _emailController,
                obscureText: false,
                hint: 'Email address',
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/email.svg',
                  color: isLight
                      ? const Color(0xffCAF6FF).withOpacity(.35)
                      : const Color(0xffCAF6FF).withOpacity(.15),
                ),
              ),
              SizedBox(height: 36.h),
              Button(
                  tittle: 'Send',
                  onTap: () {
                    NavigationUtil.to(context, const OtpVerification());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
