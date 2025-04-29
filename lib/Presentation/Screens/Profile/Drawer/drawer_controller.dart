import 'package:flutter/cupertino.dart';

typedef CustomBuilder<T extends ChangeNotifier> = Widget Function(
    BuildContext, T);

class Controller extends ChangeNotifier {
  int _currentIndex = -1;
  int get index => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);


class DrawerWrapper<T extends ChangeNotifier> extends StatelessWidget {
  const DrawerWrapper(
      {Key? key, required this.builder, required this.controller})
      : super(key: key);
  final CustomBuilder<T> builder;
  final T controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) => builder(context, controller));
  }
}
