
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Screens/Auth/Otp/otp_verification.dart';
import 'package:medix/Presentation/Screens/Auth/Otp/signup_otp_verification.dart';
import 'package:medix/Presentation/Widgets/check_box.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              SizedBox(height: 71.h),
              const AppLogo(),
              SizedBox(height: 24.86.h),
              Text(
                'Sign Up',
                style: FontStyleUtilities.h4(
                  fontWeight: FWT.medium,
                  fontColor: isLight ? Colors.black : Colors.white,
                ),
              ),
              SizedBox(height: 36.h),
              MyTextField(
                hint: 'Full Name',
                obscureText: false,
                controller: fullnameController,
                prefix: const AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
              SizedBox(height: 20.h),
              MyTextField(
                hint: 'Mobile Number',
                obscureText: false,
                controller: mobileController,
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/call.svg',
                ),
              ),
              SizedBox(height: 20.h),
              MyTextField(
                hint: 'Email Address',
                controller: emailController,
                obscureText: false,
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/email.svg',
                  color: isLight
                      ? const Color(0xffCAF6FF).withOpacity(.35)
                      : const Color(0xffCAF6FF).withOpacity(.05),
                ),
              ),
              SizedBox(height: 20.h),
              PasswordField(controller: passwordController),
              SizedBox(height: 11.h),
              Row(
                children: [
                  MyCheckBox(
                    onChange: (bool value) {
                      setState(() {
                        agreement = value;
                      });
                    },
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                      onTap: () {},
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'I accept all the ',
                            style: FontStyleUtilities.t4(
                              fontColor: isLight
                                  ? Colors.black
                                  : Colors.white.withOpacity(0.7),
                            )),
                        TextSpan(
                            text: 'Terms & Conditions',
                            style: FontStyleUtilities.t4(
                              fontWeight: FWT.medium,
                              fontColor: isLight ? Colors.black : Colors.white,
                            ))
                      ]))),
                ],
              ),
              SizedBox(height: 20.h),
              Button(
                  tittle: 'Sign Up',
                  onTap: () {
                    showVerificationDialog(
  context: context,
  email: emailController.text.trim(),
  mobile: mobileController.text.trim(),
);

                    // NavigationUtil.to(context, const OtpVerification());
                    // String email = emailController.text.trim();
                    // String password = passwordController.text;
                    // String mobile = mobileController.text;
                    // String fullname = fullnameController.text;

                    // var data = {
                    //   'email': email,
                    //   'password': password,
                    //   'mobile': mobile,
                    //   'fullname': fullname
                    // };

                    // if (email.isEmpty ||
                    //     password.isEmpty ||
                    //     mobile.isEmpty ||
                    //     fullname.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text('Fullname, mobile, email and password must not be empty')),
                    //   );
                    //   return;
                    // }

                    // if (!agreement) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text('You must accept the Terms & Conditions')),
                    //   );
                    //   return;
                    // }

                    // signupUser(data, context);
                  }),
              SizedBox(height: 20.h),
              //   const TextDivider(textDivider: 'Or'),
              // SizedBox(height: 20.h),
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   GestureDetector(
              //       onTap: () {
              //         NavigationUtil.to(context, const BottomNav());
              //       },
              //       child: const SocialButton(icon: 'assets/Icons/google.svg')),
              //   SizedBox(width: 30.w),
              //   GestureDetector(
              //       onTap: () {
              //         NavigationUtil.to(context, const BottomNav());
              //       },
              //       child:
              //           const SocialButton(icon: 'assets/Icons/facebook.svg'))
              // ]),
              // SizedBox(height: 32.9.h),
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   Text(
              //     'Have an Account?',
              //     style: FontStyleUtilities.h6(
              //         fontWeight: FWT.regular,
              //         fontColor: const Color(0xffABABAB)),
              //   ),
              //   SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sign In',
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.regular,
                        fontColor: ColorUtil.primaryColor),
                  ),
                ),
              // ])
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signupUser(Map<String, String> data, BuildContext context) async {
    final apiClient = ApiClient(http.Client());

    try {
      final response = await apiClient.post('auth/patient/signup', params: data);
      print(response.statusCode);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      apiClient.client.close();
    }
  }
  
  void showVerificationDialog({
  required BuildContext context,
  required String email,
  required String mobile,
}) {
  showDialog(
    context: context,
    builder: (context) {
      String? selectedMethod;
      bool isSending = false;
      bool codeSent = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Verify Your Contact'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please select a method to receive your 6-digit code:'),
                ),
                const SizedBox(height: 16),

                // Radio for Email
                RadioListTile<String>(
                  value: email,
                  groupValue: selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value;
                      codeSent = false;
                    });
                  },
                  title: Text(email),
                ),

                // Radio for Mobile
                RadioListTile<String>(
                  value: mobile,
                  groupValue: selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value;
                      codeSent = false;
                    });
                  },
                  title: Text(mobile),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: selectedMethod == null || isSending || codeSent
                      ? null
                      : () async {
                          setState(() => isSending = true);

                          // Simulate API call
                          await Future.delayed(const Duration(seconds: 2));

                          setState(() {
                            isSending = false;
                            codeSent = true;
                          });

                          // Navigator.pop(context);

                          // Detect type based on selected value
                          final selectedType =
                              selectedMethod == email ? 'email' : 'mobile';

                          var data = {
                            'type': selectedType!,
                            'contact_value': selectedMethod!
                          };

                    
                          sendVerificationCode(data, context);
                          // Navigate to OTP screen
                          // NavigationUtil.to(
                          //   context,
                          //   SignupOtpVerification(
                          //     type: selectedType,
                          //     value: selectedMethod!,
                          //   ),
                          // );
                        },
                  child: isSending
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(codeSent ? 'Sent' : 'Send Code'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  Future<void> sendVerificationCode(Map<String, String> data, BuildContext context) async {
  final apiClient = ApiClient(http.Client());

  try {
    final response = await apiClient.post('auth/patient/send-verification', params: data);


    if (response.statusCode == 201) {
 
 

      // // Navigate to BottomNav screen
      // NavigationUtil.to(context, const SignupOtpVerification(type: selectedType,));
    } else {
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



