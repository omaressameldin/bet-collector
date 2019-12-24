import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetCard/BetCard.dart';
import 'package:long_term_bets/widgets/BetsList/EmptyList.dart';

class BetsListState extends State<BetsList> with BetsConsumer, BetProvider {
  Future<List<Bet>> _betsList;
  bool _shouldRefresh = true;


  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if (!_shouldRefresh) {
      return;
    }

    _betsList = betsList(context, widget.betsType);
    setState(() {
      _shouldRefresh = false;
    });
  }

  Widget _buildCards(BuildContext context) {
    return FutureBuilder<List<Bet>>(
        future:  _betsList,
        builder: (BuildContext context, AsyncSnapshot<List<Bet>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _dataLoading();
          }

          if (!snapshot.hasData) {
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

  Widget _dataLoading() {
    return Container(
      alignment: Alignment.center,
      child: SpinKitWave(
        color: AppColors.buttonText,
        size: AppSizes.largeLoaderSize,
      ),
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