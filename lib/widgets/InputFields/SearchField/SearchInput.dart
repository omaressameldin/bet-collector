import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/FieldDecoration.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';
import 'package:long_term_bets/widgets/InputFields/SearchField/SearchList.dart';

class SearchInputState extends State<SearchInput> {
  List<dynamic> _results = <dynamic>[];
  bool _isLoading = false;
  dynamic _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initalSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          minLines: 1,
          controller: _isSelected() ? TextEditingController(text: widget.textValue) : null,
          maxLines: 1,
          onChanged: _filterResults,
          cursorColor: AppColors.textInput,
          style: TextStyles.inputStyle(widget.inputSize),
          focusNode: widget.focusNode,
          buildCounter: _showSelected,
          autofocus: widget.initalSelected == null,
          onTap: _onTap,
          textCapitalization: TextCapitalization.sentences,
          decoration: FieldDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            icon: widget.icon,
            inputSize: widget.inputSize,
          ),
        ),
        Expanded(
          child: SearchList(
            results: _results,
            buildFn: widget.buildFn,
            onSelect: _onSelect,
            isLoading: _isLoading,
            isSelected: _isSelected(),
          ),
        )
      ]
    );
  }

  void _onTap() {
    if(_isSelected()) {
      widget.onSelect(null);
      setState(() => _selected = null);
    }
  }

  Widget _showSelected(
    BuildContext c,
    {int currentLength, int maxLength, bool isFocused})
  {
    return _isSelected() ? widget.buildFn(_selected) : null;
  }

  bool _isSelected() => _selected != null;

  void _onSelect(dynamic selected) {
    setState(() => _selected = selected);
    widget.onSelect(selected);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<void> _filterResults(String input) async {
    setState(() => _isLoading = true);

    //TODO: improve this to not make multiple network calls
    final List<dynamic> returnedResults = await widget.filterFn(input);
    setState(() {
      _isLoading = false;
      _results = returnedResults;
    });
  }
}

class SearchInput extends StatefulWidget {
  const SearchInput({
    @required this.focusNode,
    @required this.validationFn,
    @required this.labelText,
    @required this.hintText,
    @required this.icon,
    @required this.buildFn,
    @required this.onSelect,
    @required this.filterFn,
    @required this.textValue,
    @required this.inputSize,
    this.initalSelected,
  });

  final FocusNode focusNode;
  final Function validationFn;
  final String labelText;
  final String hintText;
  final IconData icon;
  final String textValue;
  final dynamic initalSelected;
  final Function buildFn;
  final Function onSelect;
  final InputSize inputSize;
  final Future<List<dynamic>> Function(String) filterFn;

  @override
  State<StatefulWidget> createState() => SearchInputState();

}