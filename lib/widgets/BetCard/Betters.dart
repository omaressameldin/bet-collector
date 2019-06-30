import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';
import 'package:long_term_bets/widgets/Better/BetterAvatar.dart';


class Betters extends StatelessWidget {
  Betters({@required this.accepter, @required this.better, @required this.mainContext});

  final Better better;
  final Better accepter;
  final BuildContext mainContext;

  final MainAxisAlignment alignment = MainAxisAlignment.center;
  final IconStyle vsIconStyle = IconStyle(
    color: AppColors.funky,
    icon: AppIcons.vs,
  );

  @override
  Widget build(BuildContext context) {
    final Icon vsIcon = Icon(
      vsIconStyle.icon,
      color: vsIconStyle.color,
      size: AppSizes.bigIconSize,
    );
    return Container(
      child: Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          _avatar(better),
          vsIcon,
          _avatar(accepter),
        ],
      ),
    );
  }

  Widget _avatar(Better better) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.widgetMargin),
      child: BetterAvatar(
        better: better,
        size: AvatarSize.big,
        mainContext: mainContext,
        isVertical: true,
      )
    );
  }
}