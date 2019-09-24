import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetForm/AddBetter.dart';
import 'package:long_term_bets/widgets/BetForm/AddDescription.dart';
import 'package:long_term_bets/widgets/BetForm/AddExpiry.dart';
import 'package:long_term_bets/widgets/BetForm/AddPayment.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

class BetFormState extends State<BetForm> with BetterConsumer, BetsConsumer {
  int _step = 1;
  final int _maxStep = 4;
  String _description;
  String _payment;
  DateTime _expiry;
  Better _better;
  GlobalKey<FormState> _formKey;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
      if (widget.bet != null) {
        _description = widget.bet.description;
        _payment = widget.bet.payment;
        _expiry = widget.bet.expiryDate;
        _better = widget.bet.accepter;
      }
    _formKey = GlobalKey<FormState>();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Card(
        elevation: AppSizes.noElevation,
        color: AppColors.transparent,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _formItems(),
          ),
        ),
      )
    );
  }

  List<Widget> _formItems() {
    final List<Widget> items = <Widget>[
      Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.topCenter,
          child: _renderField()
        )
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _backButton(),
          _nextButton(),
        ],
      ),
    ];

    if(widget.isCentered) {
      items.insert(0, Expanded(
        flex: 2,
        child: Container(
        ),
      ));
    }

    return items;
  }

  Widget _renderField() {
    switch(_step) {
      case 1: return AddDescription(
        setDescription: setDescription,
        focusNode: _focusNode,
        initialValue: _description,
        inputSize: widget.inputSize,
      );
      case 2: return AddPayment(
        setPayment: setPayment,
        focusNode: _focusNode,
        initialValue: _payment,
        inputSize: widget.inputSize,
      );
      case 3: return AddExpiry(
        setExpiry: setExpiry,
        focusNode: _focusNode,
        initialValue: _expiry,
        inputSize: widget.inputSize,
      );
      default: return AddBetter(
        better: _better,
        setBetter: setBetter,
        focusNode: _focusNode,
        inputSize: widget.inputSize,
      );
    }
  }

  Widget _nextButton() {
    final String doneButtonText = widget.bet == null ? 'Create Bet' : 'Update Bet';
    final String buttonText = _step < _maxStep ? 'Next Step' : doneButtonText;

    return ActionButton(
      shape: ButtonShape.flat,
      hasPadding: false,
      isReversed: true,
      isBig: true,
      onPressed: _nextStep,
      text: '$buttonText \n ${_step + 1}/${_maxStep + 1}',
      color: AppColors.formButton,
      iconStyle: IconStyle(icon: AppIcons.next, color: AppColors.buttonText)
    ).generateButton();
  }

  Widget _backButton() {
    final String buttonText = _step > 1 ? 'Prev Step \n ${_step - 1}/${_maxStep + 1}' :
      'Discard';

    return ActionButton(
      shape: ButtonShape.flat,
      hasPadding: false,
      isBig: true,
      onPressed: _prevStep,
      text: buttonText,
      color: AppColors.formButton,
      iconStyle: IconStyle(icon: AppIcons.prev, color: AppColors.buttonText)
    ).generateButton();
  }

  void _nextStep() {
    if (_formKey.currentState.validate()) {
      if (_step < _maxStep) {
        setState(() => _step++);
        _focusNode = FocusNode();
        FocusScope.of(context).requestFocus(_focusNode);
      } else {
        if(widget.bet == null) {
          _addNew();
        } else {
          _updatet();
        }
        widget.onDone();
      }
    }
  }

  void _addNew() {
    final Better currentUser = consumeBetter(widget.appContext);
    final Bets bets = consumeBets(widget.appContext);
    final Bet bet = Bet(
      better: currentUser,
      description: _description,
      payment: _payment,
      expiryDate: _expiry,
      accepter: _better,
      id: '${bets.allBets.length}' //TODO: needs to be dynamic from backend!
    );

    bets.add(bet, currentUser);
  }

  void _updatet() {
    widget.bet.editBetInfo(
      description: _description,
      expiryDate: _expiry,
      accepter: _better,
      payment: _payment,
    );
  }

  void _prevStep() {
    if (_step > 1) {
      setState(() => _step--);
    } else {
      widget.onDone();
    }
  }

  void setDescription(String description) => setState(() => _description = description);
  void setPayment(String payment) => setState(() => _payment = payment);
  void setExpiry(DateTime expiry) => setState(() => _expiry = expiry);
  void setBetter(Better better) => setState(() => _better = better);


}


class BetForm extends StatefulWidget {
  const BetForm({
    @required this.onDone,
    @required this.appContext,
    @required this.inputSize,
    this.isCentered = true,
    this.bet,
  });

  final Function onDone;
  final BuildContext appContext;
  final InputSize inputSize;
  final Bet bet;
  final bool isCentered;

  @override
  State<StatefulWidget> createState() => BetFormState();
}