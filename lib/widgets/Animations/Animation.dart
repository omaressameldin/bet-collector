import 'package:flutter/material.dart';

abstract class AnimationState <T extends WidgetAnimation> extends State<T> with
  TickerProviderStateMixin
{

  CurvedAnimation _animation;

  @override
  Widget build(BuildContext context) {
    _wrapControllerInAnimation();

    return buildAnimation();
  }

  Widget buildAnimation();

  Animation<double> get animation => _animation != null ? _animation : widget.controller;

  void _wrapControllerInAnimation() {
    if (widget.curve == null) {
      return;
    }

    _animation =  CurvedAnimation(
      parent: widget.controller,
      curve: widget.curve,
    );
  }
}

abstract class WidgetAnimation extends StatefulWidget {

  WidgetAnimation({
    @required this.controller,
    @required this.child,
    this.curve,
  }): super(key: UniqueKey());

  final Widget child;
  final Curve curve;
  final AnimationController controller;

  @override
  AnimationState<WidgetAnimation> createState();

  static AnimationController createController(
    int durationMilli,
    TickerProvider provider,
  ) {
    return AnimationController(
        vsync: provider,
        duration: Duration(milliseconds: durationMilli),
      );
  }
}
