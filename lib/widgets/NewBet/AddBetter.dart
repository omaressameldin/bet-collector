import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';
import 'package:long_term_bets/widgets/InputFields/SearchField/SearchInput.dart';

class AddBetter extends StatelessWidget {

  const AddBetter({
    @required this.setBetter,
    @required this.focusNode,
    @required this.better,
  });

  final void Function(Better) setBetter;
  final FocusNode focusNode;
  final Better better;

  @override
  Widget build(BuildContext context) {
    return SearchInput(
      focusNode: focusNode,
      hintText: 'Start typing to select a better',
      labelText: 'Better',
      icon: AppIcons.better,
      validationFn: _validatePayment,
      buildFn : _buildResult,
      filterFn: _filterBetters,
      onSelect: setBetter,
      value: better != null ? better.name : null,
    );
  }

  Future<List<Better>> _filterBetters(String input) {
    return Better.filterBetters(input);
  }

  String _validatePayment(Better value) {
    setBetter(value);
    return null;
  }

  Widget _buildResult(Better better) {
    return Container(
      padding: EdgeInsets.all(AppSizes.verticalWidgetPadding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSizes.widgetMargin,
        children: <Widget>[
          Avatar(avatar: better.avatar, size: AvatarSize.big),
          Text(better.name, style: TextStyles.inputStyle)
        ],
      ),
    );
  }
}