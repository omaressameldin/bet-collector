import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/flutter.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:long_term_bets/data/ChartInfo.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';

class ChartCard extends StatelessWidget {
  ChartCard({ @required this.data, @required this.title, @required this.icon });

  final List<ChartInfo> data;
  final String title;
  final IconData icon;
  final prefix1.Color emptyColor = prefix1.Color(
      a: AppColors.buttonText.alpha,
      r: AppColors.buttonText.red,
      b: AppColors.buttonText.blue,
      g: AppColors.buttonText.green
    );
  static const int EMPTY_CHART_VALUE = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: EdgeInsets.only(bottom: AppSizes.widgetMargin),
      elevation: AppSizes.elevation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalWidgetPadding,
          vertical: AppSizes.verticalWidgetPadding,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Icon(icon, color: AppColors.primary),
                Text(title, style: TextStyles.lightTitleStyle),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: AppSizes.chartSize,
                      width: AppSizes.chartSize,
                      child: _renderChart(),
                  ),
                  Expanded(
                    flex: 1,
                    child: _renderInfo(),
                  ),
                ]
              ),
            ]
          )
        ),
      ),
    );
  }

  Widget _renderInfo() {
    final List<Widget> children = data.map((ChartInfo info) => Row(children: <Widget>[
      Text('${info.name}: ', style: TextStyles.chartLabelStyle(info)),
      Text('${info.data}', style: TextStyles.titleStyle)
    ])).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _renderChart() {
    return PieChart<String>(
      <Series<ChartInfo, String>>[
        Series<ChartInfo, String>(
          id: title,
          domainFn: (ChartInfo info, _) => info.name,
          measureFn: (ChartInfo info, int i) => (i == 0 && _forceShowData() ) ?
            EMPTY_CHART_VALUE : info.data,
          data: data,
          colorFn: (ChartInfo info, _) =>  _forceShowData() ? emptyColor : info.color,
          displayName: title,
        ),
      ],
    animate: true,
    animationDuration: Duration(milliseconds: 700),
    defaultRenderer: ArcRendererConfig<String>(arcWidth: AppSizes.chartWidth),
    );
  }

  // force showing data by setting a dummy info if all data values are 0
  bool _forceShowData() => data.where((ChartInfo info) => info.data > 0 ).isEmpty;
}