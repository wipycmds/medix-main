import 'package:flutter/material.dart';

enum AnimationParentType { row, column, wrap }

class TheMultiChildAnimationWrapper extends StatefulWidget {
  const TheMultiChildAnimationWrapper({
    Key? key,
    required this.children,
    this.mainAxisAlignment,
    this.duration = const Duration(milliseconds: 5000),
    required this.size,
    this.crossAxisAlignment,
    this.animationParentType = AnimationParentType.row,
    this.runAlignment,
    this.alignment,
    this.wrapCrossAlignment,
    this.runSpacing = 0,
    this.spacing = 0,
  }) : super(key: key);
  final MainAxisAlignment? mainAxisAlignment;
  final WrapAlignment? runAlignment, alignment;
  final WrapCrossAlignment? wrapCrossAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final List<Widget> children;
  final Duration? duration;
  final Size size;
  final AnimationParentType? animationParentType;
  final double? runSpacing, spacing;
  @override
  _TheMultiChildAnimationWrapperState createState() =>
      _TheMultiChildAnimationWrapperState();
}

class _TheMultiChildAnimationWrapperState
    extends State<TheMultiChildAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animationList;
  late final List<Widget> _animatingChildren;

  @override
  void initState() {
    _animationList = [];
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    List.generate(
        widget.children.length,
        (int index) => _animationList.add(Tween<double>(begin: 1, end: 0)
            .animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                    0.0 * ((index * (1 / widget.children.length)) + 1),
                    .2 * ((index * (1 / widget.children.length)) + 1),
                    curve: Curves.decelerate)))));
    _animatingChildren = [
      ...List.generate(widget.children.length, (i) {
        return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                  offset:
                      Offset(widget.size.width * _animationList[i].value, 0),
                  child: widget.children[i]);
            });
      })
    ];
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.animationParentType) {
      case AnimationParentType.column:
        return Column(
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: _animatingChildren,
        );
      case AnimationParentType.row:
        return Row(
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: _animatingChildren,
        );
      case AnimationParentType.wrap:
        return Wrap(
          runSpacing: widget.runSpacing!,
          spacing: widget.spacing!,
          alignment: widget.alignment ?? WrapAlignment.start,
          crossAxisAlignment:
              widget.wrapCrossAlignment ?? WrapCrossAlignment.start,
          runAlignment: widget.runAlignment ?? WrapAlignment.start,
          children: _animatingChildren,
        );

      default:
        return Row(
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: _animatingChildren,
        );
    }
  }
}
