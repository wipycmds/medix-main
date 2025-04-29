import 'package:flutter/cupertino.dart';
import 'package:medix/Presentation/Constants/gradients.dart';

class CardStyle {
  final LinearGradient gradient;
  final Color illustrationColor;
  const CardStyle({required this.gradient, required this.illustrationColor});
}

List cardStyles = <CardStyle>[
  CardStyle(
    gradient: LinearGradient(colors: [
      const Color(0xff2AA3BF),
      const Color(0xff73E5FF).withOpacity(.56),
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
    illustrationColor: const Color(0xff2AA3BF),
  ),
  CardStyle(
    gradient: AppGradients.lightBlueGradient,
    illustrationColor: const Color(0xff1FBDB8),
  ),
];
