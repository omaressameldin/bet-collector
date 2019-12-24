import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';
import 'package:long_term_bets/widgets/BetsList/BetsList.dart';
import 'package:long_term_bets/widgets/MainBar/MainBar.dart';
import 'package:long_term_bets/widgets/NewBet/NewBetPage.dart';
import 'package:long_term_bets/widgets/Dashboard/Dashboard.dart';
import 'package:long_term_bets/widgets/Translucent/Translucent.dart';

class LoggedInPageState extends State<LoggedInPage> with BetterConsumer {
  int _currentIndex = 0;
  bool _isSearching = false;
  Better _better;

  static const int TOTAL_NUMBER_OF_TABS = 5;
  static const int PROFILE_TAB_INDEX = 4;

  final List<Widget> _children = <Widget>[
    const BetsList(betsType: BetsType.all),
    const BetsList(betsType: BetsType.running),
    const BetsList(betsType: BetsType.won),
    const BetsList(betsType: BetsType.lost),
    Dashboard(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _better = consumeBetter(context);
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        currentIndex: _currentIndex,
        isSearching: _isSearching,
        toggleSearch: _toggleSearch,
        onSearchChange: _filterResults,
      ),
      body:  _children[_currentIndex % TOTAL_NUMBER_OF_TABS],
      floatingActionButton: _renderFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        elevation: AppSizes.bigElevation,
        currentIndex: _currentIndex,
        unselectedItemColor: AppColors.buttonText,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(AppIcons.allBets),
            activeIcon: Icon(AppIcons.allBets, color: AppColors.cardTitle),
            title: Container(height: AppSizes.zeroSpacing),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.runningBets),
            title: Container(height: AppSizes.zeroSpacing),
            activeIcon: Icon(AppIcons.runningBets, color: AppColors.info),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.betWinner),
            activeIcon: Icon(AppIcons.betWinner, color: AppColors.winner),
            title: Container(height: AppSizes.zeroSpacing),
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.betLoser),
            activeIcon: Icon(AppIcons.betLoser, color: AppColors.danger),
            title: Container(height: AppSizes.zeroSpacing),
          ),
          BottomNavigationBarItem(
            icon: Translucent(
              shape: BoxShape.circle,
            child: Avatar(size: AvatarSize.medium, avatar: _better.avatar),
            ),
            activeIcon: Avatar(size: AvatarSize.medium, avatar: _better.avatar),
            title: Container(height: 0.0),
          )
        ],
      ),
    );
  }

  void _toggleSearch() => setState(() => _isSearching = !_isSearching);

  void _filterResults() {}

  Widget _renderFab() {
    if (_currentIndex == PROFILE_TAB_INDEX) {
      return null;
    }

    return FloatingActionButton.extended(
      heroTag: null,
      elevation: AppSizes.elevation,
      backgroundColor: AppColors.funky,
      icon: const Icon(Icons.add),
      label: const Text('Add new'),
      onPressed: () => NewBetPage.addNewBet(context),
    );
  }

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
     if (index == PROFILE_TAB_INDEX) {
       _isSearching = false;
     }
   });
 }
}

class LoggedInPage extends StatefulWidget {

  @override
  LoggedInPageState createState() => LoggedInPageState();
}
