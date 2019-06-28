import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';

class Translucent extends StatelessWidget {
  const Translucent({ @required this.shape, this.child });
  final BoxShape shape;
  final Widget child;

  @override
  Widget build(BuildContext context) {
  const double _opacity = 0.3;

    return Opacity(
      opacity: _opacity,
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: AppColors.buttonText,
          shape: shape,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: child,
      ),
    );
  }
}