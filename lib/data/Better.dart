import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:long_term_bets/mixins/QueriesHelper.dart';
List<Better> betters = <Better>[
  Better(
    email: 'test@test.test',
    id: '1',
    name: 'Shadwa',
    avatar: const NetworkImage('https://listimg.pinclipart.com/picdir/s/335-3356471_female-avatar-girls-avatar-clipart.png'),
  ),
  Better(
    email: 'test@test.test',
    id: '2',
    name: 'Omar',
    avatar: const NetworkImage('https://cdn0.iconfinder.com/data/icons/iconshock_guys/512/andrew.png'),
  ),
  Better(
    email: 'test@test.test',
    id: '3',
    name: 'Aley',
    avatar: const NetworkImage('https://banner2.kisspng.com/20180626/fhs/kisspng-avatar-user-computer-icons-software-developer-5b327cc98b5780.5684824215300354015708.jpg')
  ),
  Better(
    email: 'test@test.test',
    id: '3',
    name: 'Mody',
    avatar: const NetworkImage('http://www.sclance.com/pngs/avatar-icon-png/avatar_icon_png_70847.jpg')
  ),
  Better(
    email: 'test@test.test',
    id: '1',
    name: 'Mehany',
    avatar: const NetworkImage('https://img.pngio.com/child-avatar-icon-flat-design-red-yellow-coffee-avatar-png-693_720.png'),
  ),
  Better(
    email: 'test@test.test',
    id: '2',
    name: 'Hariry',
    avatar: const NetworkImage('https://cdn0.iconfinder.com/data/icons/iconshock_guys/512/andrew.png'),
  ),
  Better(
    email: 'test@test.test',
    id: '3',
    name: 'sharkawy',
    avatar: const NetworkImage('http://kepido.com/protected/modules/singlemerchant/assets/images/avatar.png')
  ),
  Better(
    email: 'test@test.test',
    id: '3',
    name: 'Mody',
    avatar: const NetworkImage('http://www.sclance.com/pngs/avatar-icon-png/avatar_icon_png_70847.jpg')
  ),
];

class Better with QueriesHelper {

  Better({
    @required this.id,
    @required this.name,
    @required this.avatar,
    @required this.email,
  });

  final String id;
  final String name;
  final NetworkImage avatar;
  final String email;

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

  static Future<Better> login(BuildContext context, String token) async {
  final QueryResult res = await QueriesHelper.makeQuery(context, QueriesHelper.loginUser(token));
  final Map<String, dynamic> userResult =res.data['loginUser']['user'];

  return Better(
    avatar: NetworkImage(userResult['avatar']),
    email: userResult['email'],
    name: userResult['name'],
    id: userResult['id']
    );
  }
}