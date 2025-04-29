import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  bool _isLightTheme = true;

  bool get isLight => _isLightTheme;

  void toggleThem(bool themeValue) {
    _isLightTheme = themeValue;
    notifyListeners();
  }
}

typedef ControllerBuilder = ThemeController Function();

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    Key? key,
    required this.buildController,
    required this.builder,
  }) : super(key: key);
  final ControllerBuilder buildController;
  final Widget Function(BuildContext, ThemeController) builder;
  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  late ThemeController _controller;

  @override
  void initState() {
    _controller = widget.buildController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => widget.builder(context, _controller));
  }
}

class ThemeProviderInheritedWidget extends InheritedWidget {
  const ThemeProviderInheritedWidget({
    Key? key,
    required this.child,
    required this.themeController,
  }) : super(key: key, child: child);

  @override
  final Widget child;
  final ThemeController themeController;

  static ThemeProviderInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeProviderInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ThemeProviderInheritedWidget oldWidget) {
    return true;
  }
}
