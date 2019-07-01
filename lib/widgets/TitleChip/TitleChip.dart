import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

class TitleChip extends StatelessWidget{
  const TitleChip({ @required this.title, @required this.icon });
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: AppSizes.smallElevation,
      padding: EdgeInsets.all(AppSizes.zeroSpacing),
      backgroundColor: AppColors.funky,
      avatar: CircleAvatar(
        backgroundColor: AppColors.buttonText,
        child: Icon(icon, color: AppColors.primary),
      ),
      label: Text(title, style: TextStyles.chipStyle),
    );
  }

}