import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:provider/provider.dart';
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

class BetsList extends StatelessWidget {
  final bool isCompletedList;


  BetsList({
    @required this.isCompletedList,
  });

  Widget _buildSuggestions(Bets bets) {
    List<Bet> betsToShow = this.isCompletedList ? bets.completedBets : bets.allBets;
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemBuilder: /*1*/ (context, i) {
          if (i < betsToShow.length) {
            return BetCard(betIndex: i, isCompletedList: this.isCompletedList);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final bets = Provider.of<Bets>(context);
    return _buildSuggestions(bets);
  }
}

class NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    BetsList(isCompletedList: false),
    BetsList(isCompletedList: true),
  ];

  @override
  Widget build(BuildContext context) {
    Bets bets = Bets();
    return
      ChangeNotifierProvider(
        builder: (context) => bets,
        child: Scaffold(
        appBar: AppBar(
          elevation: 8.0,
          title: Text('Long Term Bets'),
          backgroundColor: AppColors.primary,
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 8.0,
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.secondary,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.list),
              title: new Text('All'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              title: new Text('Favorites'),
            )
          ],
        ),
      )
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