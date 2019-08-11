import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ChartData.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/Animations/Animation.dart';
import 'package:long_term_bets/widgets/Animations/SlideAnimation.dart';
import 'package:long_term_bets/widgets/Dashboard/ChartCard.dart';
import 'package:long_term_bets/widgets/Dashboard/ProfileCard.dart';

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  AnimationController _chartsController;
  List<ChartData> _data;

  @override
  Widget build(BuildContext context) {
    _chartsController ??= WidgetAnimation.createController(500, this);
    _showCharts();

    return Column(children: <Widget>[
      _addMargin(const ProfileCard()),
       _renderCharts()
    ]);
  }

  @override
  void initState() {
    super.initState();
    _data = ChartData.getChartData();
  }

  Widget _renderCharts() {
    return Expanded(
      child: SlideAnimation(
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.all(AppSizes.widgetMargin),
          itemBuilder: (BuildContext context, int i) {
            if (i < _data.length) {
              return _addMargin(ChartCard(
                data: _data[i].data,
                title: _data[i].name,
                icon: _data[i].icon,
              ));
            }
            return null;
        }),
        controller: _chartsController,
        begin: const Offset(0, 5),
        end: const Offset(0, 0),
        curve: Curves.decelerate,
      ),
    );
  }

  void _showCharts() {
    _chartsController.forward();
  }

  Widget _addMargin(Widget child ) {
    final EdgeInsets padding = EdgeInsets.only(bottom: AppSizes.widgetMargin);

    return Padding(
      padding: padding,
      child: child,
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardState();
}