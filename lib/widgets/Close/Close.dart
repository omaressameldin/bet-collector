import 'package:flutter/material.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppSizes.dart';

class Close extends StatelessWidget {
  const Close({@required this.onClose, @required this.icon});

  final Function onClose;
  final IconStyle icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSizes.noElevation,
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        highlightColor: AppColors.transparent,
        onTap: onClose,
        borderRadius: BorderRadius.circular(AppSizes.mediumIconSize),
        child: Icon(
          icon.icon,
          color: icon.color,
          size: AppSizes.mediumIconSize,
        ),
      )
    );
  }
}