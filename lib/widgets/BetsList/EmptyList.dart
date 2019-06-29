import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/Translucent/Translucent.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Translucent(
              shape: BoxShape.circle,
              child: Image(
                image: const AssetImage('assets/images/empty.png'),
                height: AppSizes.bigImage,
              ),
            ),
            Text('Nothing to See Here!', style: TextStyles.lightTitleStyle)
          ],
        )
      ]
    );
  }

}