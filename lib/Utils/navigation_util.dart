import 'package:flutter/cupertino.dart';

class NavigationUtil {
  static void to(BuildContext context, Widget child) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => child));
  }

  static void dissolveTo(BuildContext context, Widget child) {
    Navigator.push(
        context,
        MyDissolvingRoute((context, anim, anim2) => AnimatedOpacity(
            opacity: anim.value,
            duration: const Duration(milliseconds: 300),
            child: child)));
  }
}

class MyDissolvingRoute extends PageRouteBuilder {
  final RoutePageBuilder myPageBuilder;

  MyDissolvingRoute(this.myPageBuilder)
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: myPageBuilder,
          opaque: true,
        );
}
