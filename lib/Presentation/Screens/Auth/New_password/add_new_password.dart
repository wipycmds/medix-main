import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Main/Home/Compo/bottomnav.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewPassWord extends StatefulWidget {
  const AddNewPassWord({Key? key}) : super(key: key);

  @override
  State<AddNewPassWord> createState() => _AddNewPassWordState();
}

class _AddNewPassWordState extends State<AddNewPassWord> {
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
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
        title: const Text('Add New Password'),
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
                        'assets/Illustration/add_new_password.svg',
                        height: 245.79.h,
                        fit: BoxFit.cover,
                        width: 242.99.w,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'New Password',
                          style: FontStyleUtilities.h3(
                              fontWeight: FWT.medium,
                              fontColor: isLight
                                  ? Colors.black
                                  : Colors.white.withOpacity(0.80)),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 22.h),
              MyTextField(
                controller: _newPasswordController,
                hint: 'Enter your password',
                obscureText: false,
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/password.svg',
                  color: isLight
                      ? const Color(0xffCAF6FF).withOpacity(.35)
                      : const Color(0xffCAF6FF).withOpacity(.05),
                ),
              ),
              SizedBox(height: 20.h),
              MyTextField(
                controller: _confirmPasswordController,
                hint: 'Confirm your password',
                obscureText: false,
                prefix: AuthIconWrapper(
                  icon: 'assets/Icons/password.svg',
                  color: isLight
                      ? const Color(0xffCAF6FF).withOpacity(.35)
                      : const Color(0xffCAF6FF).withOpacity(.05),
                ),
              ),
              SizedBox(height: 36.h),
              Button(
                  tittle: 'Save',
                  onTap: () {
                    NavigationUtil.to(context, const BottomNav());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
