import 'package:flutter/material.dart';
import 'package:long_term_bets/widgets/Animations/Animation.dart';

class SlideAnimationState extends AnimationState<SlideAnimation> {

  @override
  Widget buildAnimation() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: widget.begin,
        end: widget.end,
      ).animate(animation),
      child: widget.child
    );
  }
}

class SlideAnimation extends WidgetAnimation {

  SlideAnimation({
    @required Widget child,
    @required this.begin,
    @required this.end,
    @required AnimationController controller,
    Curve curve,
  }): super(
    child: child,
    curve: curve,
    controller: controller,
  );

  final Offset begin;
  final Offset end;

  @override
  SlideAnimationState createState() => SlideAnimationState();
}


