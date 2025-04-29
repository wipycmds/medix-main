import 'package:flutter/cupertino.dart';

class Specialization {
  const Specialization(
      {required this.icon,
      required this.text,
      required this.time,
      required this.subText});

  final String icon, text, subText;
  final List time;
}

ValueNotifier<double> totalCounting = ValueNotifier(300.0);
ValueNotifier<int> count = ValueNotifier(6);
ValueNotifier<double> height = ValueNotifier(690.0);
