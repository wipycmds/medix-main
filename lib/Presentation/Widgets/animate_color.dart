import 'package:flutter/material.dart';
import '../../Utils/color_utils.dart';

class AnimateColor extends StatefulWidget {
  const AnimateColor(
      {Key? key,
      this.counting = '',
      this.size = 12,
      this.child = const SizedBox(),
      this.isTextAnimate = true,
      this.textStyle,
      this.milliduration,
      this.startcolor = ColorUtil.blue,
      this.endcolor = Colors.white})
      : super(key: key);

  final String counting;
  final double size;
  final int? milliduration;
  final Widget child;
  final TextStyle? textStyle;
  final bool isTextAnimate;
  final Color startcolor, endcolor;

  @override
  State<AnimateColor> createState() => _AnimateColorState();
}

class _AnimateColorState extends State<AnimateColor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.milliduration ?? 500));
    _animation = ColorTween(begin: widget.startcolor, end: widget.endcolor)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimateColor oldWidget) {
    if (oldWidget.counting != widget.counting) {
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isTextAnimate
        ? Text(widget.counting,
            style: widget.textStyle!
                .copyWith(fontSize: widget.size, color: _animation.value))
        : AnimatedContainer(
            duration:
                Duration(milliseconds: _controller.duration!.inMilliseconds),
            decoration: BoxDecoration(
                color: _animation.value ?? widget.endcolor,
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: widget.child,
          );
  }
}
