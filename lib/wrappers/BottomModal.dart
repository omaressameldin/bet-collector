import 'package:flutter/material.dart';
import 'package:long_term_bets/widgets/BetCard/BetPopUp.dart';

class BottomModal {
  final Widget child;
  final BuildContext context;

  BottomModal({
    @required this.child,
    @required this.context,
  }) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}