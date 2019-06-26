import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({@required this.avatar, @required this.isBig});

  final NetworkImage avatar;
  final bool isBig;

  @override
  Widget build (BuildContext context) {
    return CircleAvatar(
      radius: isBig ? 20.0 : 7.5,
      backgroundImage: avatar,
    );
  }
}