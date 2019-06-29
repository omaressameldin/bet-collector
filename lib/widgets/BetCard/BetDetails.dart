import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/TitleChip/TitleChip.dart';
import 'package:long_term_bets/widgets/Translucent/Translucent.dart';

class BetDetails extends StatelessWidget with WidgetHelper {
  const BetDetails({ @required this.bet });

  final Bet bet;

  @override
  Widget build(BuildContext context) {
    return
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            horizontalDivider(),
            _field(bet.description, AppIcons.bet, 'Descrpiption'),
            _field(bet.payment, AppIcons.payment, 'Payment'),
            _moneyPanda(),
          ],
    );
  }

  Widget _field(String field, IconData icon, String fieldName) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.widgetMargin,
        bottom: AppSizes.widgetMargin
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleChip(icon: icon, title: fieldName),
            Padding(
              padding: EdgeInsets.only(left: AppSizes.iconSpacing),
              child: Text(
              field,
              style: TextStyles.detailsStyle,
            ),
            )
          ],
        )
    );
  }
    );
  }

  Widget _moneyPanda() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Translucent(
              shape: BoxShape.circle,
              child: Image(
                image: const AssetImage('assets/images/money-panda.png'),
                height: AppSizes.mediumImage,
              ),
            ),
          ],
        )
      ]
    );
  }
}