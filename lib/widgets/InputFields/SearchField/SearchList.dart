import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppSizes.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    @required this.results,
    @required this.buildFn,
    @required this.onSelect,
    @required this.isLoading,
    @required this.isSelected,
  });

  final List<dynamic> results;
  final Function buildFn;
  final Function onSelect;
  final bool isLoading;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return _buildResults(context);
  }

  Widget _buildResults(BuildContext context) {
    if(isSelected) {
      return Container();
    }
    if(isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SpinKitWave(
            color: AppColors.buttonText,
            size: AppSizes.smallLoaderSize,
          ),
        ]
      );
    }
    return ScrollConfiguration(
      behavior: NoGlowScroll(),
      child: ListView.builder(
        padding: EdgeInsets.all(AppSizes.widgetMargin),
        itemBuilder: (BuildContext context, int i) {
          if (i < results.length) {
            return InkWell(
              onTap: () {
                onSelect(results[i]);
              },
              child:buildFn(results[i])
            );
          }
          return null;
        }
      ),
    );
  }
}

class NoGlowScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}