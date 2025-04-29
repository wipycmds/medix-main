import 'package:flutter/material.dart';
import 'dart:ui';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    this.opacity = 0.05,
    this.child,
    this.blur = 5,
    this.height,
    this.width,
    this.shadowStrength = 4,
    this.padding,
    this.margin,
    this.borderRadius,
    required this.color,
  }) : super(key: key);

  ///FOR LAYOUT CONFIG...
  final EdgeInsetsGeometry? padding, margin;
  final double? width;
  final double? height;

  ///FOR DECORATION...
  final BorderRadius? borderRadius;

  ///FOR GLASS_MORPHIC EFFECT...
  final double opacity;
  final double blur;
  final double shadowStrength;
  final Color color;

  ///...
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PaintShadow(shadowStrength: shadowStrength),
      child: SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur,
              sigmaY: blur * 2,
            ),
            child: Container(
              color: color,
              padding: padding,
              margin: margin,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _PaintShadow extends CustomPainter {
  _PaintShadow({
    this.shadowStrength = 1,
  });

  final double shadowStrength;

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  Paint customPainter(
      {required double blurStrength,
      required Color color,
      double? opacity,
      required double strokeWidth}) {
    return Paint()
      ..style = PaintingStyle.stroke
      ..color = color.withOpacity(0.24)
      ..strokeWidth = strokeWidth
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        convertRadiusToSigma(
          blurStrength,
        ),
      );
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (shadowStrength == 0) return;
    RRect rect = RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(-shadowStrength / 2, -shadowStrength / 2),
          Offset(
            size.width + shadowStrength / 2,
            size.height + shadowStrength / 2,
          ),
        ),
        const Radius.circular(10));
    canvas.drawRRect(
      rect,
      customPainter(
        color: const Color(0xff333333),
        blurStrength: 20,
        strokeWidth: shadowStrength,
        opacity: 0.24,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
