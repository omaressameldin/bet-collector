import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetCard/BetCard.dart';
import 'package:long_term_bets/widgets/BetsList/EmptyList.dart';

class BetsList extends StatelessWidget with BetsConsumer, BetProvider {
  BetsList({
    @required this.betsType,
  });

  final BetsType betsType;

  Widget _buildCards(BuildContext context) {
    final List<Bet> betsToShow = betsList(context, betsType);
    if (betsToShow.isEmpty) {
      return EmptyList();
    }

    return ListView.builder(
        padding: EdgeInsets.all(AppSizes.widgetMargin),
        itemBuilder: (BuildContext context, int i) {
          if (i < betsToShow.length) {
            return provideBet(
              betsToShow[i],
              BetCard()
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCards(context);
  }
}