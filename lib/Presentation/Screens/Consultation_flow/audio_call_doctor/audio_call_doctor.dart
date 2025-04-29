import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncreasingClockController extends ChangeNotifier {
  late final Timer _timer;
  setUpTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _increaseCount();
    });
  }

  setUpdecrementTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _decreaseCount();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  reset({int seconds = 0, int minutes = 0}) {
    _minutes = minutes;
    _seconds = seconds;
    notifyListeners();
  }

  _decreaseCount() {
    if (_seconds == 0) {
      _seconds = 60;
      _seconds--;
      _minutes--;
      notifyListeners();
    } else {
      _seconds--;

      notifyListeners();
    }
  }

  _increaseCount() {
    if (_seconds == 60) {
      _seconds = 00;
      _minutes++;
      notifyListeners();
    } else {
      _seconds++;
      notifyListeners();
    }
  }

  int _minutes = 00;
  int _seconds = 00;

  set minutes(int val) => _minutes = val;
  set seconds(int val) => _seconds = val;

  int get minute => _minutes;
  int get second => _seconds;
}

class CallADoctor extends StatefulWidget {
  const CallADoctor({Key? key}) : super(key: key);

  @override
  State<CallADoctor> createState() => _CallADoctorState();
}

class _CallADoctorState extends State<CallADoctor> {
  late IncreasingClockController _increasingClockController;
  @override
  void initState() {
    _increasingClockController = IncreasingClockController()..setUpTimer();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  @override
  void dispose() {
    _increasingClockController.removeListener(() {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      setState(() {});
    });
    _increasingClockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      // appBar: AppBar(
      //   leading:
      //   actions: [ 16.width()],
      //   backgroundColor: Colors.transparent,
      // ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 812.h,
              width: 375.w,
              child: Image.asset(
                'assets/Images/Temp/audio_call.jpg',
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: SizedBox(
                height: 812.h,
                width: 375.w,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: const Color(0xffC4C4C4).withOpacity(.20))),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 115.h,
                  width: 115.h,
                  child: Image.asset('assets/Images/Temp/caller.png'),
                ),
                7.height(),
                AnimatedBuilder(
                  animation: _increasingClockController,
                  builder: (context, child) => Text(
                    '${_increasingClockController.minute}:${_increasingClockController.second.toString().padLeft(2, '0')}',
                    style: FontStyleUtilities.h1(
                        fontWeight: FWT.semiBold, fontColor: Colors.white),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 36.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30.h,
                    backgroundColor: const Color(0xff505050),
                    child: const SvgIcon('assets/Icons/Voice.svg'),
                  ),
                  17.width(),
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
                ],
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: 0,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                            height: 16.h,
                            width: 16.h,
                            child: const SvgIcon(
                              'assets/Icons/arrow_back.svg',
                              color: Colors.white,
                            )),
                      ),
                      const SvgIcon("assets/Icons/chat_out.svg"),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
