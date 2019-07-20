import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:long_term_bets/data/Bets.dart';
import 'package:long_term_bets/data/IconStyle.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/widgets/BetForm/BetForm.dart';
import 'package:long_term_bets/widgets/Close/Close.dart';
import 'package:long_term_bets/widgets/EditBet/EditTitle.dart';
import 'package:long_term_bets/widgets/InputFields/BasicInput/Input.dart';

class EditBetWrapperState extends State<EditBetWrapper> {
  double _height = AppSizes.modalSizeWithoutKeyboard;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool isVisible) {
        setState(() {
          _height = isVisible ? AppSizes.modalSizeWithKeyboard :
            AppSizes.modalSizeWithoutKeyboard;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _renderCloseIcon(),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(
            AppSizes.horizontalWidgetPadding,
            AppSizes.verticalWidgetPadding,
            AppSizes.horizontalWidgetPadding,
            AppSizes.verticalWidgetPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EditTitle(),
              Container(height: _height, child:BetForm(
                appContext: context,
                onDone: widget.onDone,
                inputSize: InputSize.small,
                bet: widget.bet,
                isCentered: false,
              )),
            ]
          ),
        ),
      ],
    );
  }

  Widget _renderCloseIcon() {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.widgetMargin,
        top: AppSizes.widgetMargin,
      ),
      alignment: Alignment.centerLeft,
      child: Close(
        onClose: widget.onDone,
        icon: IconStyle(
          icon: AppIcons.prev,
          color: AppColors.funky,
        ),
      ),
    );
  }
}

class EditBetWrapper extends StatefulWidget {

  const EditBetWrapper({@required this.onDone, @required this.bet});

  final Function onDone;
  final Bet bet;

  @override
  State<StatefulWidget> createState() => EditBetWrapperState();

}