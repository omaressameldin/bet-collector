import 'package:flutter/material.dart';
import 'package:long_term_bets/widgets/Animations/Animation.dart';

class FadeAnimationState extends AnimationState<FadeAnimation> {

  @override
  Widget buildAnimation() {
    return FadeTransition(
      opacity: Tween<double>(
        begin: widget.begin,
        end: widget.end,
      ).animate(animation),
      child: widget.child
    );
  }
}

class FadeAnimation extends WidgetAnimation {

  FadeAnimation({
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
  FadeAnimationState createState() => FadeAnimationState();
}


