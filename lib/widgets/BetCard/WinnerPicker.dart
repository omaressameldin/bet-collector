import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/widgets/Better/BetterAvatar.dart';

class WinnerPickerState extends State<WinnerPicker> {
  WinnerPickerState({
    @required this.better,
    @required this.accepter,
    @required this.mainContext,
    @required this.onChanged,
  });

  final Better better;
  final Better accepter;
  final BuildContext mainContext;
  final Function(Better) onChanged;
  Better _selected;

  final bool _isBigAvatar = false;
  final bool _isVertical = false;
  final Color _activeColor = AppColors.info;

  void _setSelected(Better value) {
   setState(() {
    _selected = value;
   });
   onChanged(value);
  }

  @override
  void initState() {
    super.initState();
    _selected = better;
  }

  @override
  Widget build (BuildContext context) {
    return Column(
    children: <Widget>[
    RadioListTile<Better>(
      activeColor: _activeColor,
      title: BetterAvatar(
        mainContext: mainContext,
        better: better,
        isBig: _isBigAvatar,
        isVertical: _isVertical,
      ),
      value: better,
      groupValue: _selected,
      onChanged: _setSelected,
    ),
    RadioListTile<Better>(
      activeColor: _activeColor,
      title: BetterAvatar(
        mainContext: mainContext,
        better: accepter,
        isBig: _isBigAvatar,
        isVertical: _isVertical,
      ),
      value: accepter,
      groupValue: _selected,
      onChanged: _setSelected,
    ),
  ],
);
  }
}

class WinnerPicker extends StatefulWidget {
  const WinnerPicker({
    @required this.better,
    @required this.accepter,
    @required this.context,
    @required this.onChanged,
  });

  final Better better;
  final Better accepter;
  final Function(Better) onChanged;
  final BuildContext context;


  @override
  WinnerPickerState createState() => WinnerPickerState(
    better: better,
    accepter: accepter,
    mainContext: context,
    onChanged: onChanged
  );
}