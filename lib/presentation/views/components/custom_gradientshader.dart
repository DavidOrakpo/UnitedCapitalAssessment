import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask(
      {super.key, this.child, this.gradientOne, this.gradientTwo});
  final Widget? child;
  final Color? gradientOne;
  final Color? gradientTwo;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [gradientOne ?? Colors.white, gradientTwo ?? Colors.white],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
