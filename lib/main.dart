import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/providers/BetsProvider.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';
import 'package:long_term_bets/widgets/BetCard/BetCard.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Long Term Bets',
      home: Navigation()
    );
  }
}

class BetsList extends StatelessWidget with BetsConsumer, BetProvider {
  BetsList({
    @required this.betsType,
  });

  final BetsType betsType;

  Widget _buildSuggestions(BuildContext context) {
    final List<Bet> betsToShow = betsList(context, betsType);
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (BuildContext context, int i) {
          if (i < betsToShow.length) {
            return provideBet(
              betsToShow[i],
              BetCard(betsType: betsType)
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions(context);
  }
}

class NavigationState extends State<Navigation> with BetsProvider {
  int _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    BetsList(betsType: BetsType.all),
    BetsList(betsType: BetsType.running),
  ];

  @override
  Widget build(BuildContext context) {
    final Bets bets = Bets();
    final Better better = bets.getLoggedInBetter();

    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: const Text('Long Term Bets'),
        backgroundColor: AppColors.primary,
      ),
      body: provideBets(bets, better, _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        onTap: onTabTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(AppIcons.allBets),
            title: const Text('All'),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.runningBets),
            title: const Text('Running'),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.betWinner),
            title: const Text('Won'),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.betLoser),
            title: const Text('Lost'),
          ),
          BottomNavigationBarItem(
            icon: Avatar(size: avatarSize.medium, avatar: better.avatar),
            title: const Text('Lost'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}

class Navigation extends StatefulWidget {
  @override
  NavigationState createState() => NavigationState();
}