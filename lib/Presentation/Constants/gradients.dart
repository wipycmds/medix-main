import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient blueGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xff1FA0BD), Color(0xff5FD8F3)]);
  static final LinearGradient lightBlueGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xff17D4C3),
        const Color(0xff7EDCD4).withOpacity(.81)
      ]);
  static const LinearGradient purpleGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xff1E59F0), Color(0xff4676F0)]);
}
