import 'package:flutter/material.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';
import 'package:long_term_bets/widgets/InputFields/SearchField/SearchInput.dart';

class AddBetter extends StatelessWidget {

  const AddBetter({
    @required this.setBetter,
    @required this.focusNode,
    @required this.better,
    @required this.inputSize
  });

  final void Function(Better) setBetter;
  final FocusNode focusNode;
  final Better better;
  final InputSize inputSize;

  @override
  Widget build(BuildContext context) {
    return SearchInput(
      focusNode: focusNode,
      hintText: 'Start typing to select a better',
      labelText: 'Better',
      icon: AppIcons.better,
      validationFn: _validatePayment,
      buildFn : _buildResult,
      filterFn: (String input) => _filterBetters(context, input),
      onSelect: setBetter,
      initalSelected: better,
      textValue: better != null ? better.name : null,
      inputSize: inputSize,
    );
  }

  Future<List<Better>> _filterBetters(BuildContext context, String input) async{
    return Better.filterBetters(context, input);
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
          Text(better.name, style: TextStyles.inputStyle(inputSize))
        ],
      ),
    );
  }
}