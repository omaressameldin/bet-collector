import 'package:flutter/material.dart';
import 'package:long_term_bets/consumers/BetterConsumer.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/mixins/LoginHelepr.dart';
import 'package:long_term_bets/styles/AppColors.dart';
import 'package:long_term_bets/styles/AppIcons.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
import 'package:long_term_bets/styles/TextStyles.dart';
import 'package:long_term_bets/widgets/Animations/Animation.dart';
import 'package:long_term_bets/widgets/Animations/FadeAnimation.dart';
import 'package:long_term_bets/widgets/Animations/ScaleAnimation.dart';
import 'package:long_term_bets/widgets/Animations/SlideAnimation.dart';
import 'package:long_term_bets/widgets/Avatar/Avatar.dart';

class ProfileCardState extends State<ProfileCard> with
  TickerProviderStateMixin,
  BetterConsumer,
  LoginHelper
{

  Better _better;

  AnimationController _cardController;
  AnimationController _avatarController;
  AnimationController _nameController;
  AnimationController _editController;
  AnimationController _logoutController;


  @override
  Widget build(BuildContext context) {
    _better ??= consumeBetter(context);
    _buildControllers();

    return SlideAnimation(
      child: _betCard(context),
      begin: const Offset(0, -4),
      end: const Offset(0, 0),
      curve: Curves.decelerate,
      controller: _cardController,
    );


  }

  void _buildControllers() {
    _cardController ??= WidgetAnimation.createController(500, this);
    _avatarController ??= WidgetAnimation.createController(300, this);
    _nameController ??= WidgetAnimation.createController(500, this);
    _editController ??= WidgetAnimation.createController(150, this);
    _logoutController ??= WidgetAnimation.createController(150, this);

    _cardController.forward().then<void>((_) {
      _avatarController.forward().then<void>((_) {
        _nameController.forward().then<void>((_) {
          _editController.forward().then<void>((_) {
            _logoutController.forward().then<void>((_) {
              if (widget.onRenderDone != null) {
                widget.onRenderDone();
              }
            });
          });
        });
      });
    });
  }

  Widget _betCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0)
      ),
      color: AppColors.white,
      margin: EdgeInsets.only(bottom: AppSizes.widgetMargin),
      elevation: AppSizes.elevation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalWidgetPadding
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              _renderProfile(),
              _renderActions(context),
            ],
          ),
        )
      ),
    );
  }

  Widget _renderProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _renderAvatar(),
        _renderName(),
      ]);
  }

  Widget _renderAvatar() {
    return ScaleAnimation(
      child: Avatar(avatar: _better.avatar, size: AvatarSize.huge),
      begin: 0,
      end: 1,
      controller: _avatarController,
    );
  }

  Widget _renderName() {
    return FadeAnimation(
      controller: _nameController,
      begin: 0,
      end: 1,
      curve: Curves.decelerate,
      child: Text(_better.name, style: TextStyles.lightTitleStyle),
    );
  }

  Widget _renderActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _scalingButton(
          AppIcons.edit,
          AppColors.funky,
          'Edit',
          _editController,
          (){},
        ),
        _scalingButton(
          AppIcons.logout,
          AppColors.buttonText,
          'Log out',
          _logoutController,
          () => signOutGoogle(context),
        ),
      ],
    );
  }
}


  Widget _scalingButton(
    IconData icon,
    Color color,
    String tooltip,
    AnimationController controller,
    Function onPressed,
  ) {
      return ScaleAnimation(
        controller: controller,
        begin: 0,
        end: 1,
        child: FloatingActionButton(
          heroTag: null,
          child: Icon(
            icon,
            color: color,
            size: AppSizes.appBarIconSize,
          ),
          onPressed: onPressed,
          mini: true,
          elevation: AppSizes.noElevation,
          backgroundColor: AppColors.transparent,
          highlightElevation: AppSizes.noElevation,
          tooltip: tooltip,
        ),
      );
  }

class ProfileCard extends StatefulWidget {
  const ProfileCard({ this.onRenderDone });
  final Function onRenderDone;

  @override
  State<StatefulWidget> createState()  => ProfileCardState();
}