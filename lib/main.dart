import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetProvider.dart';
import 'package:long_term_bets/providers/BetsProvider.dart';
import 'package:long_term_bets/styles/AppColors.dart';
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
    @required this.isCompletedList,
  });

  final bool isCompletedList;

  Widget _buildSuggestions(BuildContext context) {
    final List<Bet> betsToShow = betsList(context, isCompletedList);
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (BuildContext context, int i) {
          if (i < betsToShow.length) {
            return provideBet(
              betsToShow[i],
              BetCard(isCompletedList: isCompletedList)
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
    BetsList(isCompletedList: false),
    BetsList(isCompletedList: true),
  ];

  @override
  Widget build(BuildContext context) {
    final Bets bets = Bets();
    const String betterId = '2';

    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: const Text('Long Term Bets'),
        backgroundColor: AppColors.primary,
      ),
      body: provideBets(bets, betterId, _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        onTap: onTabTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('All'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
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