import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Auth/Login/login.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(width: size.width),
            SizedBox(
              height: 153.h,
            ),
            SizedBox(
                height: 331.56.h,
                width: 290.38,
                child: Image.asset('assets/Illustration/on_boading.png')),
            SizedBox(height: 44.44.h),
            Text(
              'Get connect our best Doctors',
              style: FontStyleUtilities.h3(
                  height: 1.53,
                  fontWeight: FWT.medium,
                  fontColor: isLight ? null : Colors.white),
            ),
            SizedBox(height: 6.h),
            Text(
              'Get an Expert Medical Opinion from one of our\nworld-renowned specialists.',
              style: FontStyleUtilities.h5(
                      height: 1.53,
                      fontWeight: FWT.regular,
                      fontColor: isLight
                          ? ColorUtil.lightTextColor
                          : Colors.white.withOpacity(0.7))
                  .copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 73.h),
            Button(
              tittle: 'Next',
              onTap: () {
                NavigationUtil.to(context, const Login());
              },
            ),
          ],
        ),
      ),
    );
  }
}
