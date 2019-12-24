import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetCard/BetCard.dart';
import 'package:long_term_bets/widgets/BetsList/EmptyList.dart';

class BetsListState extends State<BetsList> with BetsConsumer, BetProvider {
  bool _shouldRefresh = true;

  Widget _buildCards(BuildContext context) {
    return FutureBuilder<List<Bet>>(
        future:  betsList(context, widget.betsType, _shouldRefresh),
        builder: (BuildContext context, AsyncSnapshot<List<Bet>> snapshot) {
          if (_shouldRefresh) {
            setState(() => _shouldRefresh = false);
          }

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

class BetsList extends StatefulWidget {
  const BetsList({
    @required this.betsType,
  });

  final BetsType betsType;

  @override
  State<BetsList> createState() => BetsListState();
}