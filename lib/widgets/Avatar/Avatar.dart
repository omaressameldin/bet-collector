import 'package:flutter/material.dart';
enum AvatarSize {
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
      case AvatarSize.big: radius = 20.0; break;
      case AvatarSize.medium: radius = 10.0; break;
      case AvatarSize.small: radius = 7.5; break;

    }
    return CircleAvatar(
      radius: radius,
      backgroundImage: avatar,
    );
  }
}