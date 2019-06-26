import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';


class Betters extends StatelessWidget {
  Betters({@required this.currentUser, @required this.accepter, @required this.better});

  final Better currentUser;
  final Better better;
  final Better accepter;

  final MainAxisAlignment alignment = MainAxisAlignment.center;
  final double iconSize = 50.0;
  final IconStyle vsIconStyle = IconStyle(
    color: AppColors.secondary,
    icon: Icons.compare_arrows
  );
  final TextStyle _avatarTextStyle = TextStyle(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    final Icon vsIcon = Icon(vsIconStyle.icon, color: vsIconStyle.color, size: iconSize);
    return Container(
      padding: const EdgeInsets.only(top: 5.0),
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
      padding: const EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        better.avatar,
        Text(better == currentUser ? 'You' : better.name, style: _avatarTextStyle)
      ])
    );
  }
}