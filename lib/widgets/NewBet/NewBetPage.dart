import 'package:flutter/material.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetForm/BetForm.dart';
import 'package:long_term_bets/widgets/Close/Close.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

class NewBetPage extends PageRoute<void> {
  NewBetPage({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final Widget result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0.25, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(AppSizes.horizontalWidgetPadding),
          decoration: BoxDecoration(
            border: Border.all(width: 0),
            color: AppColors.transparentFunky,
          ),
          child: Column(
            children: <Widget>[
              _renderCloseIcon(context),
              Expanded(child: result),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderCloseIcon(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          right: AppSizes.verticalWidgetPadding,
          top: AppSizes.horizontalWidgetPadding,
        ),
        alignment: Alignment.centerRight,
        child: Close(
          onClose: () => _close(context),
          icon: IconStyle(
            color: AppColors.buttonText,
            icon: AppIcons.exit,
          ),
        ),

    );
  }

  static void _close(BuildContext context) {
    Navigator.pop(context);
  }

  static void addNewBet(BuildContext context) {
    Navigator.push<void>(
      context,
      NewBetPage(builder: (_) => BetForm(
        appContext: context,
        onDone: () => _close(context),
        inputSize: InputSize.big,
      )),
    );
  }
}