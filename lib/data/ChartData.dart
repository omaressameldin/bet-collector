import 'package:charts_flutter/flutter.dart' as prefix1;
import 'package:flutter/cupertino.dart';
import 'package:long_term_bets/data/ChartInfo.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';

class ChartData {
  ChartData(List<ChartInfo> data, String name, IconData icon) {
    _data = data;
    _name = name;
    _icon = icon;
  }

  List<ChartInfo> _data;
  String _name;
  IconData _icon;

  List<ChartInfo> get data => _data;
  String get name => _name;
  IconData get icon => _icon;

  // TODO: this should later make a network request!
  static List<ChartData> getChartData() {
    return <ChartData>[
      ChartData(
        <ChartInfo>[
          ChartInfo(
            20,
            'All',
            prefix1.Color(r: AppColors.cardTitle.red, g: AppColors.cardTitle.green, b: AppColors.cardTitle.blue),
          ),
          ChartInfo(
            5,
            'Running',
            prefix1.Color(r: AppColors.info.red, g: AppColors.info.green, b: AppColors.info.blue),
          ),
          ChartInfo(
            10,
            'Lost',
            prefix1.Color(r: AppColors.danger.red, g: AppColors.danger.green, b: AppColors.danger.blue),
          ),
          ChartInfo(
            5,
            'Won',
            prefix1.Color(r: AppColors.winner.red, g: AppColors.winner.green, b: AppColors.winner.blue),
          ),
        ],
        'Bet States',
        AppIcons.allBets,
      ),
      ChartData(
        <ChartInfo>[
          ChartInfo(
            50,
            'Past Year',
            prefix1.Color(r: AppColors.primary.red, g: AppColors.primary.green, b: AppColors.primary.blue),
          ),
          ChartInfo(
            30,
            'Past 90 Days',
            prefix1.Color(r: AppColors.secondary.red, g: AppColors.secondary.green, b: AppColors.secondary.blue),
          ),
          ChartInfo(
            5,
            'This Month',
            prefix1.Color(r: AppColors.success.red, g: AppColors.success.green, b: AppColors.success.blue),
          ),
        ],
        'Bet Creation',
        AppIcons.betCreationStats,
      ),
    ];
  }

}