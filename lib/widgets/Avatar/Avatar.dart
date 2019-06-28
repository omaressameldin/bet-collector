import 'package:flutter/material.dart';
enum avatarSize {
    big,
    medium,
    small,
}
class Avatar extends StatelessWidget {
  const Avatar({@required this.avatar, @required this.size});

  final NetworkImage avatar;
  final avatarSize size;

  @override
  Widget build (BuildContext context) {
    double radius;
    switch(size) {
      case avatarSize.big: radius = 20.0; break;
      case avatarSize.medium: radius = 10.0; break;
      case avatarSize.small: radius = 7.5; break;

    }
    return CircleAvatar(
      radius: radius,
      backgroundImage: avatar,
    );
  }
}