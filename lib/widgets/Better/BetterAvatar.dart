import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';

class BetterAvatar extends StatelessWidget with BetterConsumer {
  BetterAvatar({
  @required this.better,
   @required this.size,
   @required this.isVertical,
   this.mainContext,
  });

  final Better better;
  final avatarSize size;
  final bool isVertical;
  final BuildContext mainContext;

  final TextStyle _avatarTextStyle = TextStyle(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    final Better currentUser = consumeBetter(mainContext != null ? mainContext : context);

    return Wrap(
      direction: isVertical ? Axis.vertical : Axis.horizontal,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: isVertical ? 0.0 : 5.0,
      children: <Widget>[
        Avatar(avatar: better.avatar, size: size),
        Text(better == currentUser ? 'You' : better.name, style: _avatarTextStyle)
      ]);
  }
}