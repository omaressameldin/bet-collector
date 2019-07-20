import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

class EditTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Icon(AppIcons.edit, color: AppColors.primary),
        Text(
          'Edit Bet',
          style: TextStyles.lightTitleStyle,
        )
      ],
    );
  }
}