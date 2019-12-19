import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/InputFields/AppBarSeach/AppBarSearch.dart';

class MainBar extends StatelessWidget with PreferredSizeWidget{
  MainBar({
    @required this.isSearching,
    @required this.currentIndex,
    @required this.toggleSearch,
    @required this.onSearchChange,
  });

  final bool isSearching;
  final int currentIndex;
  final Function toggleSearch;
  final Function onSearchChange;

  @override
  Widget build(BuildContext context) {
    const Color appBarColor = AppColors.white ;

    return AppBar(
      centerTitle: false,
      elevation: _isProfilePage() ? AppSizes.noElevation : AppSizes.bigElevation,
      title: isSearching ? AppBarSearch(onInputChange: onSearchChange) : _renderTitle(),
      primary: true,
      actions: <Widget>[
        _isProfilePage() ? _generateAction(AppIcons.friends, 'Friends', (){} ) :
          _generateAction(
            isSearching ? AppIcons.exit : AppIcons.search,
            'Search',
            toggleSearch,
          ),
      ],
      backgroundColor: appBarColor,
    );
  }

  Widget _renderTitle() {
    final Function widgetToShow = (String text, IconData icon, Color color) => Wrap(
      spacing: AppSizes.iconSpacing,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Icon(icon, size: AppSizes.mediumIconSize, color: color),
        Text(text, style: TextStyle(color: AppColors.buttonText)),
      ]
    );

    switch (currentIndex) {
      case 0: return widgetToShow('All Bets', AppIcons.allBets, AppColors.cardTitle);
      case 1: return widgetToShow('Running Bets', AppIcons.runningBets, AppColors.info);
      case 2: return widgetToShow('Won Bets', AppIcons.betWinner, AppColors.winner);
      case 3: return widgetToShow('Lost Bets', AppIcons.betLoser, AppColors.danger);
      default: return widgetToShow('Profile', AppIcons.account, AppColors.primary);
    }
  }

  bool _isProfilePage() => currentIndex == 4;

  Widget _generateAction (IconData icon, String tooltip,  Function onPressed) {
      return FloatingActionButton(
        heroTag: null,
        child: Icon(
          icon,
          color: AppColors.buttonText,
          size: AppSizes.appBarIconSize,
        ),
        onPressed: onPressed,
        mini: true,
        elevation: AppSizes.noElevation,
        backgroundColor: AppColors.transparent,
        highlightElevation: AppSizes.noElevation,
        tooltip: tooltip,
      );
  }

  @override
  Size get preferredSize => Size(double.infinity, AppSizes.appBarSize);
}