import 'package:flutter/material.dart';
List<Better> betters = <Better>[
  Better(
    id: '1',
    name: 'Shadwa',
    avatar: NetworkImage('https://listimg.pinclipart.com/picdir/s/335-3356471_female-avatar-girls-avatar-clipart.png'),
  ),
  Better(
    id: '2',
    name: 'Omar',
    avatar: NetworkImage('https://cdn0.iconfinder.com/data/icons/iconshock_guys/512/andrew.png'),
  ),
  Better(
    id: '3',
    name: 'Aley',
    avatar: NetworkImage('https://banner2.kisspng.com/20180626/fhs/kisspng-avatar-user-computer-icons-software-developer-5b327cc98b5780.5684824215300354015708.jpg')
  ),
  Better(
    id: '3',
    name: 'Mody',
    avatar: NetworkImage('http://www.sclance.com/pngs/avatar-icon-png/avatar_icon_png_70847.jpg')
  ),
  Better(
    id: '1',
    name: 'Mehany',
    avatar: NetworkImage('https://img.pngio.com/child-avatar-icon-flat-design-red-yellow-coffee-avatar-png-693_720.png'),
  ),
  Better(
    id: '2',
    name: 'Hariry',
    avatar: NetworkImage('https://cdn0.iconfinder.com/data/icons/iconshock_guys/512/andrew.png'),
  ),
  Better(
    id: '3',
    name: 'sharkawy',
    avatar: NetworkImage('http://kepido.com/protected/modules/singlemerchant/assets/images/avatar.png')
  ),
  Better(
    id: '3',
    name: 'Mody',
    avatar: NetworkImage('http://www.sclance.com/pngs/avatar-icon-png/avatar_icon_png_70847.jpg')
  ),
];

class Better {

  Better({
    @required this.id,
    @required this.name,
    @required this.avatar,
  });

  final String id;
  final String name;
  final NetworkImage avatar;

 @override
  bool operator ==(dynamic other) {
    return other is Better && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  static Future<List<Better>> filterBetters(String input) {
    if (input.isEmpty) {
      return Future<List<Better>>(() => <Better>[]);
    }
    return Future<List<Better>>.delayed(const Duration(seconds: 1), () {
      return betters.where((Better b) {
        return b.name.toLowerCase().contains(input.toLowerCase());
      }).toList();
    });

  }
}