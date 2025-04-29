import 'package:flutter/cupertino.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Screens/Pre_auth/on_boarding/on_boarding.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 3000));
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => const OnBoarding()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(gradient: AppGradients.blueGradient),
        child: const Center(
          child: SvgIcon('assets/Icons/logo.svg'),
        ));
  }
}
