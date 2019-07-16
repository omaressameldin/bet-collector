import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetsConsumer.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/data/ActionButton.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/widgets/NewBet/AddBetter.dart';
import 'package:long_term_bets/widgets/NewBet/AddDescription.dart';
import 'package:long_term_bets/widgets/NewBet/AddExpiry.dart';
import 'package:long_term_bets/widgets/NewBet/AddPayment.dart';

class NewBetFormState extends State<NewBetForm> with BetterConsumer, BetsConsumer {
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
        elevation: 0,
        color: AppColors.transparent,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                ),
              ),
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
            ],
          ),
        ),
      )
    );
  }

  Widget _renderField() {
    switch(_step) {
      case 1: return AddDescription(
        setDescription: setDescription,
        focusNode: _focusNode,
        description: _description,
      );
      case 2: return AddPayment(
        setPayment: setPayment,
        focusNode: _focusNode,
        payment: _payment,
      );
      case 3: return AddExpiry(
        setExpiry: setExpiry,
        focusNode: _focusNode,
        expiry: _expiry,
      );
      default: return AddBetter(
        better: _better,
        setBetter: setBetter,
        focusNode: _focusNode,
      );
    }
  }

  Widget _nextButton() {
    final String buttonText = _step < _maxStep ? 'Next Step' : 'Create Bet';

    return ActionButton(
      isFlat: true,
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
      'Exit';

    return ActionButton(
      isFlat: true,
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
        widget.onDone();
      }
    }
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


class NewBetForm extends StatefulWidget {
  const NewBetForm({
    @required this.onDone,
    @required this.appContext,
  });

  final Function onDone;
  final BuildContext appContext;

  @override
  State<StatefulWidget> createState() => NewBetFormState();
}