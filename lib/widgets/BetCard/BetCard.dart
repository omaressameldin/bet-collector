import 'package:flutter/material.dart';
import 'package:long_term_bets/abstracts/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/widgets/BetCard/BetCardInfo.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/widgets/BetCard/BetPopUp.dart';
import 'package:long_term_bets/wrappers/BottomModal.dart';
import 'package:provider/provider.dart';

class BetCard extends BetsConsumer with WidgetHelper {
  final Color _iconColor = AppColors.secondary;
  final TextStyle _titleStyle = TextStyle(
    color: AppColors.cardTitle,
    fontWeight: FontWeight.bold
  );


  BetCard({@required int betIndex, @required bool isCompletedList}): super(
    betIndex: betIndex,
    isCompletedList: isCompletedList
  );

  @override
  Widget renderChild(BuildContext context, Bet bet, Bets bets) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(vertical: 8.0),
      child: _buildTile(context, bet),
    );
  }

  ListTile _buildTile(BuildContext context, Bet bet) {
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
        subtitle: BetCardInfo(bet: bet),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 5.0,
              padding: EdgeInsets.all(0),
              shape: CircleBorder(side: BorderSide.none),
              child: FlatButton(
                onPressed: ()  {
                  return BottomModal(
                  context: context,
                  child: BetPopUp(betIndex: betIndex, isCompletedList: this.isCompletedList)
                );},
                child: Icon(Icons.keyboard_arrow_up, color: _iconColor, size: 30.0),
              )
            )

          ]
        )
    );
  }
}