import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Screens/Auth/Otp/signup_otp_verification.dart';
import 'package:medix/Presentation/Screens/Main/Home/Compo/bottomnav.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool agreement = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(width: size.width),
              SizedBox(height: 200.h),
              const AppLogo(),
              SizedBox(height: 24.86.h),
              Text(
                'Welcome to LuvMED',
                style: FontStyleUtilities.h4(
                  fontWeight: FWT.medium,
                  fontColor: isLight ? Colors.black : Colors.white,
                ),
              ),
              SizedBox(height: 36.h),
              SizedBox(height: 20.h),
              Text(
                'Enter your mobile number to get started',
                style: FontStyleUtilities.t4(
                  fontWeight: FWT.medium,
                  fontColor: isLight ? Colors.black : Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              MyTextField(
                hint: '9876543210',
                obscureText: false,
                controller: mobileController,
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/call.svg',
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(height: 11.h),
              Button(
                tittle: 'Continue',
                onTap: () {
                  NavigationUtil.to(context, const BottomNav());
                  // String mobile = mobileController.text;

                  // var data = {
                  //   'type': 'mobile_no',
                  //   'contact_value': mobile,
                  // };

                  // if (mobile.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text(
                  //         'Mobile must not be empty',
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   );
                  //   return;
                  // }

                  // sendVerificationCode(data, context);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendVerificationCode(Map<String, String> data, BuildContext context) async {
    final apiClient = ApiClient(http.Client());
   
    try {
      final response = await apiClient.post('auth/patient/send-verification', params: data);     

      if (response.statusCode == 201) {
        NavigationUtil.to(
          context,
          SignupOtpVerification(
            type: 'mobile',
            value: data['contact_value'].toString(),
          ),
        );
      }else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid mobile number.', textAlign: TextAlign.center)),
        );
      } 
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please check your credentials.', textAlign: TextAlign.center)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.', textAlign: TextAlign.center)),
      );
    } finally {
      apiClient.client.close();
    }
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool value = true;

  void toggle() {
    value = !value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return MyTextField(
      controller: widget.controller,
      isObs: value,
      hint: 'Password',
      obscureText: false,
      suffix: GestureDetector(
        onTap: toggle,
        child: Padding(
          padding: EdgeInsets.only(right: 19, top: 16.h, bottom: 16.h),
          child: const SvgIcon('assets/Icons/Hide.svg'),
        ),
      ),
      prefix: AuthIconWrapper(
        icon: 'assets/Icons/password.svg',
        color: isLight
            ? const Color(0xffCAF6FF).withOpacity(.35)
            : const Color(0xffCAF6FF).withOpacity(.05),
      ),
    );
  }
}
