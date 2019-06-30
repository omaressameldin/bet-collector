import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/TitleChip/TitleChip.dart';
import 'package:long_term_bets/widgets/Translucent/Translucent.dart';

class BetDetails extends StatelessWidget {
  const BetDetails({ @required this.bet });

  final Bet bet;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _fields(<Widget>[
          _field(bet.description, AppIcons.bet, 'Descrpiption'),
          _field(bet.payment, AppIcons.payment, 'Payment'),
          ]),
        _moneyPanda(),
      ]
    );
  }

  Widget _field(String field, IconData icon, String fieldName) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.iconSpacing),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TitleChip(icon: icon, title: fieldName),
            Padding(
              padding: EdgeInsets.only(left: AppSizes.iconSpacing),
              child: Text(
                field,
                style: TextStyles.detailsStyle,
                maxLines: 3,
              ),
            )
          ],
        )
    );
  }

  Widget _fields(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _moneyPanda() {
    return Container(
      alignment: Alignment.center,
      child: Translucent(
        shape: BoxShape.circle,
        child: Image(
          image: const AssetImage('assets/images/money-panda.png'),
          height: AppSizes.mediumImage,
        ),
      ),
    );
  }
}