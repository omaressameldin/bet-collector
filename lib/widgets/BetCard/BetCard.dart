import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/widgets/BetCard/BetTooltips.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/widgets/BetCard/BetPopUp.dart';

class BetCard extends StatelessWidget with WidgetHelper, BetConsumer, BetProvider {
  final Color _iconColor = AppColors.secondary;
  final TextStyle _titleStyle = TextStyle(
    color: AppColors.cardTitle,
    fontWeight: FontWeight.bold
  );

  final int betIndex;
  final bool isCompletedList;

  BetCard({@required this.betIndex, @required this.isCompletedList});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(vertical: 8.0),
      child: _buildTile(context),
    );
  }

  ListTile _buildTile(BuildContext context) {
    Bet bet = consumeBet(context);

    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildDividedContainer(
              true,
              bet.better.avatar
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
              padding: EdgeInsets.all(0),
              shape: CircleBorder(side: BorderSide.none),
              child: FlatButton(
                onPressed: () => showBottomModal(
                  context,
                  provideBet(
                    bet,
                    BetPopUp(
                      mainContext: context,
                      betIndex: this.betIndex,
                      isCompletedList: this.isCompletedList
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