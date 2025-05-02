import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Screens/Auth/Forget_password/forget_password.dart';
import 'package:medix/Presentation/Screens/Auth/Sign_up/sign_up.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Main/Home/Compo/bottomnav.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    Size size = MediaQuery.of(context).size;

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
              ),
              SizedBox(height: 71.h),
              const AppLogo(),
              SizedBox(height: 24.86.h),
              Text(
                'Log In',
                style: FontStyleUtilities.h4(
                  fontWeight: FWT.medium,
                  fontColor:
                      isLight ? Colors.black : Colors.white.withOpacity(0.80),
                ),
              ),
              SizedBox(height: 36.h),
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
              SizedBox(height: 24.h),
              PasswordField(controller: passwordController),
              SizedBox(height: 11.h),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      NavigationUtil.to(context, const ForgetPassword());
                    },
                    child: Text(
                      'Forgot Password',
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.regular,
                          fontColor: isLight
                              ? ColorUtil.lightTextColor
                              : ColorUtil.mediumTextColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Button(
                tittle: 'Sign In',
                onTap: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text;

                  var data = {
                    'email': email,
                    'password': password,
                  };

                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email and password must not be empty')),
                    );
                    return;
                  }                 

                  loginUser(data, context);
                },
              ),

              SizedBox(height: 35.h),
              // const TextDivider(textDivider: 'Or'),
              // SizedBox(height: 42.h),
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
              SizedBox(height: 47.h),
              GestureDetector(
                onTap: () {
                  NavigationUtil.to(context, const SignUp());
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Don’t Have an Account?',
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.regular,
                        fontColor: const Color(0xffABABAB)),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Sign Up',
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.regular,
                        fontColor: ColorUtil.primaryColor),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
  
Future<void> loginUser(Map<String, String> data, BuildContext context) async {
  final apiClient = ApiClient(http.Client());

  try {
    final response = await apiClient.post('auth/patient/sign-in', params: data);
    if (response.statusCode == 200) {
      
      final responseData = jsonDecode(response.body);

      final token = responseData['access_token'];
      final tokenType = responseData['token_type'];
      final userData = responseData['userData'];

      if (token != null && tokenType != null) {
        await saveAccessToken('$tokenType $token');
      }

      if (userData != null) {
        await saveUserData(userData);
      }

      // Navigate to BottomNav screen
      NavigationUtil.to(context, const BottomNav());
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

Future<void> saveAccessToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', token);
}

Future<void> saveUserData(Map<String, dynamic> userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_data', jsonEncode(userData));
}


}

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.icon}) : super(key: key);
  final String icon;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.all(17.h),
      height: 65.h,
      width: 65.h,
      decoration: BoxDecoration(
          color: isLight ? Colors.white : ColorUtil.surfaceDark,
          borderRadius: BorderRadius.circular((65 / 2).h),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff2D2D2D).withOpacity(.10),
                offset: Offset(5.w, 4.h),
                blurRadius: 20)
          ]),
      child: SvgIcon(icon),
    );
  }
}
