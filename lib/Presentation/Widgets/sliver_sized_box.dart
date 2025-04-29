import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {
  const SliverSizedBox({Key? key, this.height, this.width, this.child})
      : super(key: key);
  final double? height, width;

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
