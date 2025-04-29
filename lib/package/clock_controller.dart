import 'dart:async';
import 'package:flutter/material.dart';

class ClockController extends ChangeNotifier {
  late final Timer _timer;
  initDecrease() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _decreaseCount();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  reset() {
    _minutes = 1;
    _seconds = 60;
    notifyListeners();
  }

  _decreaseCount() {
    if (_seconds != 0) {
      _seconds--;
      notifyListeners();
    } else if (_seconds == 0 && _minutes != 0) {
      _minutes--;
      _seconds = 60;
      notifyListeners();
    }
  }

  int _minutes = 1;
  int _seconds = 60;

  int get minute => _minutes;
  int get second => _seconds;
}
