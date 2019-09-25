import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:long_term_bets/mixins/WidgetHelper.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/Animations/Animation.dart';
import 'package:long_term_bets/widgets/Animations/FadeAnimation.dart';
import 'package:long_term_bets/widgets/Animations/ScaleAnimation.dart';
import 'package:long_term_bets/widgets/Animations/SlideAnimation.dart';
import 'package:long_term_bets/widgets/SignIn/SignInButton.dart';

class SignInPageState extends State<SignInPage> with
  TickerProviderStateMixin,
  WidgetHelper
{

  AnimationController _imageController;
  AnimationController _titleController;
  AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _checkSignedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    _imageController ??= WidgetAnimation.createController(500, this);
    _titleController ??= WidgetAnimation.createController(500, this);
    _buttonController ??= WidgetAnimation.createController(800, this);

    _imageController.forward().then<void>((_) {
      _titleController.forward().then<void>((_) {
        _buttonController.forward();
      });
    });

    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(AppSizes.widgetMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleAnimation(
              child: Image(
                image: const AssetImage('assets/images/signin.png'),
                height: AppSizes.mediumImage,
                alignment: Alignment.bottomCenter,
              ),
              begin: 0,
              end: 1,
              controller: _imageController,
            ),
            SlideAnimation(
              begin: const Offset(0, 10),
              end: const Offset(0, 0),
              child: Text('Long Term Bets', style: TextStyles.signInTitleStyle),
              controller: _titleController,
            ),
            FadeAnimation(
              controller: _buttonController,
              begin: 0,
              end: 1,
              curve: Curves.decelerate,
              child: const SignInButton(),
            )
          ]),
      ),
    );
  }

  void _checkSignedIn(BuildContext context) async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser currentUser = await auth.currentUser();

    if(await currentUser.getIdToken() != null) {
      afterSiginIn(context, currentUser);
    }
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage();


  @override
  State<StatefulWidget> createState()  => SignInPageState();
}
