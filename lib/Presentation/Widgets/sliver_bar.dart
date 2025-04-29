import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Widgets/back_button.dart';
import 'package:medix/Utils/color_utils.dart';

class SliverBar extends StatelessWidget {
  const SliverBar(
      {Key? key,
      this.widget = const SizedBox(),
      this.borderRadius,
      this.mainChild,
      this.titleWidget,
      this.actions,
      this.backgroundColor,
      this.bottomChild,
      this.bottomHeight = 53,
      this.isbackVisible = true,
      this.divider,
      this.onBackTap,
      this.backcolor,
      this.collapseHeight = 60,
      this.toolbarHeight = kToolbarHeight,
      this.isPinned = true,
      this.expandedHeight = 293})
      : super(key: key);

  final Widget widget;
  final Color? backcolor;
  final VoidCallback? onBackTap;

  final bool isbackVisible, isPinned;
  // final double
  final Widget? titleWidget;
  final Color? backgroundColor;
  final Widget? divider;
  final Widget? mainChild;
  final BorderRadiusGeometry? borderRadius;
  final double expandedHeight, toolbarHeight, collapseHeight;
  final List<Widget>? actions;
  final Widget? bottomChild;
  final double bottomHeight;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 4,
      pinned: isPinned,
      actions: actions,
      backgroundColor: backgroundColor ?? ColorUtil.primaryColor,
      expandedHeight: expandedHeight,
      collapsedHeight: collapseHeight,
      toolbarHeight: toolbarHeight,
      title: titleWidget ?? const SizedBox(),
      centerTitle: false,
      titleSpacing: 1,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            widget,
            Positioned(
              bottom: -25.h,
              child: RoundedContainer(
                  bottomHeight: bottomHeight,
                  divider: divider,
                  borderRadius: borderRadius),
            ),
            mainChild ?? const SizedBox()
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      leading: isbackVisible
          ? MyBackButton(
              color: backcolor ?? Colors.white,
              onTap: onBackTap ??
                  () {
                    Navigator.pop(context);
                  },
            )
          : const SizedBox(),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.bottomHeight,
    this.divider,
    this.borderRadius,
  }) : super(key: key);

  final double bottomHeight;
  final Widget? divider;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: bottomHeight.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: borderRadius ??
              BorderRadius.vertical(top: Radius.circular(30.r))),
      child: divider,
    );
  }
}
