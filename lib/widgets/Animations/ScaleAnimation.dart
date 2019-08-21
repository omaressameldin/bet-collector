import 'package:flutter/material.dart';
import 'package:long_term_bets/widgets/Animations/Animation.dart';

class ScaleAnimationState extends AnimationState<ScaleAnimation> {

  @override
  Widget buildAnimation() {
    return ScaleTransition(
      scale: Tween<double>(
        begin: widget.begin,
        end: widget.end,
      ).animate(animation),
      child: widget.child
    );
  }
}

class ScaleAnimation extends WidgetAnimation {

  ScaleAnimation({
    @required Widget child,
    @required this.begin,
    @required this.end,
    @required AnimationController controller,
    Curve curve,
  }): super(
    child: child,
    controller: controller,
    curve: curve,
  );

  final double begin;
  final double end;

  @override
  ScaleAnimationState createState() => ScaleAnimationState();
}


