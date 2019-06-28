import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/providers/BetsProvider.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';
import 'package:long_term_bets/widgets/BetsList/BetsList.dart';
import 'package:long_term_bets/widgets/Translucent/Translucent.dart';


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

class NavigationState extends State<Navigation> with BetsProvider {
  int _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    BetsList(betsType: BetsType.all),
    BetsList(betsType: BetsType.running),
    BetsList(betsType: BetsType.won),
    BetsList(betsType: BetsType.lost),
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
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: AppColors.funky,
        icon: const Icon(Icons.add),
        label: const Text('Add new'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        currentIndex: _currentIndex,
        unselectedItemColor: AppColors.buttonText,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(AppIcons.allBets),
            activeIcon: Icon(AppIcons.allBets, color: AppColors.cardTitle),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.runningBets),
            title: Container(height: 0.0),
            activeIcon: Icon(AppIcons.runningBets, color: AppColors.info),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.betWinner),
            activeIcon: Icon(AppIcons.betWinner, color: AppColors.winner),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.betLoser),
            activeIcon: Icon(AppIcons.betLoser, color: AppColors.danger),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Translucent(
              shape: BoxShape.circle,
            child: Avatar(size: AvatarSize.medium, avatar: better.avatar),
            ),
            activeIcon: Avatar(size: AvatarSize.medium, avatar: better.avatar),
            title: Container(height: 0.0),
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