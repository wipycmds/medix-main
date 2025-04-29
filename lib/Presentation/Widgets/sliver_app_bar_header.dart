import 'package:flutter/material.dart';

class MyStickyHeader extends StatelessWidget {
  const MyStickyHeader(
      {Key? key,
      required this.height,
      required this.child,
      this.padding,
      this.pinned,
      this.backgroundColor,
      this.floating,
      this.elevation,
      this.forceElevated,
      this.expandedHeight})
      : super(key: key);
  final double height;
  final Color? backgroundColor;
  final double? expandedHeight;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool? pinned, floating, forceElevated;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        removeLeft: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: SliverAppBar(
            expandedHeight: expandedHeight ?? height,
            backgroundColor:
                backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            elevation: elevation,
            toolbarHeight: 2,
            pinned: pinned ?? false,
            floating: floating ?? false,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(height),
                child: Container(
                    color: backgroundColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                    child: child))));
  }
}
