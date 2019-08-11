import 'package:charts_flutter/flutter.dart';

class ChartInfo {
  ChartInfo(int data, String name, Color color) {
    _data = data;
    _name = name;
    _color = color;
  }

  int _data;
  String _name;
  Color _color;

  int get data => _data;
  String get name => _name;
  Color get color => _color;

}