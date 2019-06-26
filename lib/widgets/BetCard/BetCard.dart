import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/widgets/BetCard/BetTooltips.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/widgets/BetCard/BetPopUp.dart';

class BetCard extends StatelessWidget with
  WidgetHelper,
  BetterConsumer,
  BetConsumer,
  BetProvider
{
  BetCard({@required this.isCompletedList});

  final bool isCompletedList;

  final Color _iconColor = AppColors.secondary;
  final TextStyle _titleStyle = TextStyle(
    color: AppColors.cardTitle,
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: _buildTile(context),
    );
  }

  ListTile _buildTile(BuildContext context) {
    final Bet bet = consumeBet(context);
    final Better better = consumeBetter(context);
    final Better otherSide = bet.getOtherSide(better);

    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildDividedContainer(
              true,
              otherSide.avatar,
            )
          ],
        ),
        title: Text(
          bet.description,
          style: _titleStyle,
          maxLines: 2,
        ),
        subtitle: BetTooltips(bet: bet),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 5.0,
              padding: const EdgeInsets.all(0),
              shape: const CircleBorder(side: BorderSide.none),
              child: FlatButton(
                onPressed: () => showBottomModal(
                  context,
                  provideBet(
                    bet,
                    BetPopUp(
                      mainContext: context,
                      isCompletedList: isCompletedList
                    )
                  ),
                ),
                child: Icon(Icons.keyboard_arrow_up, color: _iconColor, size: 30.0),
              )
            )

          ]
        )
    );
  }
}