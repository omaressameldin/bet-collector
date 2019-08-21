import 'package:flutter/material.dart';
import 'package:long_term_bets/styles/AppSizes.dart';
enum AvatarSize {
    huge,
    big,
    medium,
    small,
}
class Avatar extends StatelessWidget {
  const Avatar({@required this.avatar, @required this.size});

  final NetworkImage avatar;
  final AvatarSize size;

  @override
  Widget build (BuildContext context) {
    double radius;
    switch(size) {
      case AvatarSize.huge: radius = AppSizes.hugeAvatar; break;
      case AvatarSize.big: radius = AppSizes.bigAvatar; break;
      case AvatarSize.medium: radius = AppSizes.mediumAvatar; break;
      case AvatarSize.small: radius = AppSizes.smallAvatar; break;

    }
    return CircleAvatar(
      radius: radius,
      backgroundImage: avatar,
    );
  }
}