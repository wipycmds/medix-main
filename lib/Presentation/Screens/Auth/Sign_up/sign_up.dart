
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Screens/Profile/Profile/profile_screen.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  final String? mobile;
  const SignUp({Key? key, this.mobile}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool agreement = false;

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController signupReasonController = TextEditingController();
  final TextEditingController signupOtherReasonController = TextEditingController();


  String? selectedGender;
  String? selectedSignupReason;
  DateTime? selectedDate;

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
              SizedBox(height: 70.h),
              // const AppLogo(),
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
                hint: 'First Name',
                obscureText: false,
                controller: fnameController,
                prefix: const AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
              // SizedBox(height: 10.h),
              MyTextField(
                hint: 'Last Name',
                obscureText: false,
                controller: lnameController,
                prefix: const AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
              // SizedBox(height: 10.h),  
          
              MyTextField(
                hint: 'Middle Name',
                controller: mnameController,
                obscureText: false,
                 prefix: const AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
            
              SizedBox(height: 5.h),
              // TextFormField(
              //   controller: dobController,
              //   readOnly: true,
              //   decoration: InputDecoration(
              //     hintText: 'Select Date of Birth',
              //     suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
              //     contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              //   ),
              //   onTap: () async {
              //     FocusScope.of(context).unfocus(); // Dismiss keyboard
              //     final DateTime? picked = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime(2000),
              //       firstDate: DateTime(1900),
              //       lastDate: DateTime.now(),
              //       initialDatePickerMode: DatePickerMode.year,
              //     );
              //     if (picked != null) {
              //       setState(() {
              //         selectedDate = picked;
              //         dobController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
              //       });
              //     }
              //   },
              // ),


              DropdownButtonFormField<String>(
                value: selectedGender,
                hint: Text('Select Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
               MyTextField(
                hint: 'Barangay',
                controller: barangayController,
                obscureText: false,
                 prefix: const AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
              MyTextField(
                hint: 'City',
                controller: cityController,
                obscureText: false,
                 prefix: const AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
              MyTextField(
                hint: 'Province',
                controller: provinceController,
                obscureText: false,
                 prefix: const AuthIconWrapper(
                  icon: 'assets/Icons/user.svg',
                ),
              ),
              SizedBox(height: 10.h),
              DropdownButtonFormField<String>(
                value: selectedSignupReason,
                hint: Text('Select Reason'),
                items: ['New Patient', 'Routine check-up', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSignupReason = value;
                  });
                },
              ),
              if (selectedSignupReason == 'Other')
                MyTextField(
                  hint: 'Other Reason',
                  controller: signupOtherReasonController,
                  obscureText: false,
                  maxLines: 3,
                ),
              
              
              
              // Row(
              //   children: [
              //     MyCheckBox(
              //       onChange: (bool value) {
              //         setState(() {
              //           agreement = value;
              //         });
              //       },
              //     ),
              //     SizedBox(width: 8.w),
              //     GestureDetector(
              //         onTap: () {},
              //         child: Text.rich(TextSpan(children: [
              //           TextSpan(
              //               text: 'I accept all the ',
              //               style: FontStyleUtilities.t4(
              //                 fontColor: isLight
              //                     ? Colors.black
              //                     : Colors.white.withOpacity(0.7),
              //               )),
              //           TextSpan(
              //               text: 'Terms & Conditions',
              //               style: FontStyleUtilities.t4(
              //                 fontWeight: FWT.medium,
              //                 fontColor: isLight ? Colors.black : Colors.white,
              //               ))
              //         ]))),
              //   ],
              // ),
              SizedBox(height: 10.h),
              Button(
                  tittle: 'Sign Up',
                  onTap: () {
                    String fname = fnameController.text;
                    String lname = lnameController.text;
                    String mname = mnameController.text;
                    String brgy = barangayController.text;
                    String city = cityController.text;
                    String province = provinceController.text;
                    String gender = selectedGender!;
                    String mobile = widget.mobile!;                 
                    // String dob = dobController.text;
                    String reason = selectedSignupReason!;
                    // String otherReason = signupOtherReasonController.text;

                    var data = {
                      'fname': fname,
                      'lname': lname,
                      'mname': mname,
                      'brgy': brgy,
                      'city': city,
                      'province': province,
                      'gender': gender,
                      'mobile_no': mobile,
                      // 'dob': dob,
                      'signup_reason': reason,
                    };

                  // print(data);

                    // if (
                    //     fname.isEmpty ||
                    //     lname.isEmpty ||
                    //     mname.isEmpty ||
                    //     brgy.isEmpty ||
                    //     city.isEmpty ||
                    //     province.isEmpty ||
                    //     gender.isEmpty ||
                    //     dob.isEmpty ||
                    //     reason.isEmpty 
                    //     ) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //           content: Text(
                    //             'All fields must not be empty',
                    //             textAlign: TextAlign.center,
                    //           )),
                    //     );
                    //     return;
                    //   }

                    // if (!agreement) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text('You must accept the Terms & Conditions')),
                    //   );
                    //   return;
                    // }

                      // showVerificationDialog(
                      //   context: context,
                      //   email: emailController.text.trim(),
                      //   mobile: mobileController.text.trim(),
                      // );

                    //  NavigationUtil.to(context, SignupOtpVerification(type: 'mobile', value: mobileController.text.trim(),));
                      // sendVerificationCode(data, context);
                    signupUser(data, context);
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
              //   GestureDetector(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: Text(
              //       'Sign In',
              //       style: FontStyleUtilities.h6(
              //           fontWeight: FWT.regular,
              //           fontColor: ColorUtil.primaryColor),
              //     ),
              //   ),
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
    final response = await apiClient.post('auth/patient/register', params: data);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up successful!')),
      );
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.body}')),
      );
    }
  } catch (e) {
    print("Error occurred: $e");
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



