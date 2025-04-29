import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/audio_call_doctor/audio_call_doctor.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCallDoctor extends StatefulWidget {
  const VideoCallDoctor({Key? key}) : super(key: key);

  @override
  State<VideoCallDoctor> createState() => _VideoCallDoctorState();
}

class _VideoCallDoctorState extends State<VideoCallDoctor> {
  late IncreasingClockController _increasingClockController;

  @override
  void initState() {
    _increasingClockController = IncreasingClockController()..setUpTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(height: 812.h),
            Positioned(
              width: 375.w,
              height: 220.h,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                alignment: Alignment.center,
                height: 160.h,
                decoration:
                    const BoxDecoration(gradient: AppGradients.blueGradient),
                child: Padding(
                  padding: EdgeInsets.only(top: 31.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AuthIconWrapper(
                          padding: EdgeInsets.all(12.h),
                          color: Colors.white,
                          icon: 'assets/Icons/twin_chat.svg',
                          height: 50.h,
                          width: 50.h,
                          borderRadius: 14.r,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 30.h,
                            backgroundColor: const Color(0xffFF6948),
                            child: const SvgIcon('assets/Icons/Call_out.svg'),
                          ),
                        ),
                        AuthIconWrapper(
                          padding: EdgeInsets.all(15.h),
                          color: const Color(0xff565E7A),
                          icon: 'assets/Icons/refresh.svg',
                          height: 50.h,
                          width: 50.h,
                          borderRadius: 14.r,
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height:
                  690.h - (MediaQuery.of(context).padding.top + kToolbarHeight),
              width: 375.w,
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(40.r)),
                      child: Image.asset('assets/Images/Temp/dct.png',
                          height: 690.h, width: 375.w, fit: BoxFit.cover)),
                  Positioned(
                      right: 16,
                      top: MediaQuery.of(context).padding.top + 10,
                      child: Image.asset('assets/Images/Temp/user_video.png')),
                  Positioned(
                      right: 16.w,
                      bottom: 35.h,
                      child: Column(
                        children: [
                          AuthIconWrapper(
                            height: 60.h,
                            width: 60.h,
                            iconColor: Colors.white,
                            borderRadius: 14.r,
                            padding: EdgeInsets.all(16.h),
                            icon: 'assets/Icons/Video.svg',
                            color: Colors.white.withOpacity(.20),
                          ),
                          30.height(),
                          AuthIconWrapper(
                            height: 60.h,
                            width: 60.h,
                            iconColor: Colors.white,
                            borderRadius: 14.r,
                            padding: EdgeInsets.all(18.h),
                            icon: 'assets/Icons/bold_voice.svg',
                            color: Colors.white.withOpacity(.20),
                          ),
                        ],
                      )),
                  Positioned(
                      bottom: 35.h,
                      left: 16.w,
                      child: Column(
                        children: [
                          Text(
                            'Leslie',
                            style: FontStyleUtilities.h3(
                                fontWeight: FWT.medium,
                                fontColor: Colors.white),
                          ),
                          35.height(),
                          Container(
                            alignment: Alignment.center,
                            height: 32.h,
                            width: 71.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white.withOpacity(.20)),
                            child: AnimatedBuilder(
                              animation: _increasingClockController,
                              builder: (context, child) => Text(
                                "${_increasingClockController.minute}:${_increasingClockController.second}",
                                style: FontStyleUtilities.t2(
                                    fontWeight: FWT.semiBold,
                                    fontColor: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
