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
    return FutureBuilder<List<Bet>>(
        future:  betsList(context, betsType),
        builder: (BuildContext context, AsyncSnapshot<List<Bet>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return EmptyList();
          }

          final List<Bet> bets = snapshot.data;
          return ListView.builder(
              padding: EdgeInsets.all(AppSizes.widgetMargin),
              itemBuilder: (BuildContext context, int i) {
                if (i < bets.length) {
                  return provideBet(
                    bets[i],
                    BetCard()
                  );
                }
                return null;
              });
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCards(context);
  }
}