import 'dart:collection';

import 'package:flutter/material.dart';

List<Bet> bets = <Bet>[
      Bet(
        id: '1',
        better: Better(
          id: '1',
          name: 'Shadwa',
          avatar: CircleAvatar(
            backgroundImage: NetworkImage('https://listimg.pinclipart.com/picdir/s/335-3356471_female-avatar-girls-avatar-clipart.png'),
          ),
        ),
        description: 'shadwa will stay thin after marriage',
        payment: 'Omar will go down on shadwa for thirty minutes',
        expiryDate: DateTime(2024, 1, 1)
      ),
      Bet(
        id: '2',
        better: Better(
          id: '2',
          name: 'Omar',
          avatar: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn0.iconfinder.com/data/icons/iconshock_guys/512/andrew.png'),
          )
        ),
        description: 'Aley is gonna live outside of Egypt',
        payment: 'Shadwa will give Omar a lapdance',
        expiryDate: DateTime(2022, 1, 1)
      ),
      Bet(
        id: '3',
        better: Better(
          id: '2',
          name: 'Omar',
          avatar: CircleAvatar(
            backgroundImage: NetworkImage('https://cdn0.iconfinder.com/data/icons/iconshock_guys/512/andrew.png'),
          )
        ),
        description: 'Aley will finish university soon',
        payment: 'Omar Will give shadwa 10\$',
        expiryDate: DateTime(2019, 1, 1),
        completionDate: DateTime(2018, 6, 1)
      )
    ];

class Bets with ChangeNotifier {
  Bets(): super() {
    _allBets.addAll(bets);
    _completedBets.add(bets[2]);
  }

  final HashSet<Bet> _allBets = HashSet<Bet>();
  final HashSet<Bet> _completedBets = HashSet<Bet>();


  HashSet<Bet> get allBets => _allBets;
  HashSet<Bet> get completedBets => _completedBets;

  void getNewBets() {
    notifyListeners();
  }

  void markAsCompleted(Bet bet) {
    if(_allBets.contains(bet)) {
      bet._markAsCompleted();
      _completedBets.add(bet);
    }

    notifyListeners();
  }

  void delete(Bet bet) {
    _allBets.remove(bet);
    _completedBets.remove(bet);

    notifyListeners();
  }
}

class Bet with ChangeNotifier {
  Bet({
    @required this.id,
    @required this.better,
    @required this.description,
    @required this.payment,
    @required this.expiryDate,
    this.completionDate
  });

  final String id;
  final Better better;
  String description;
  String payment;
  DateTime expiryDate;
  DateTime completionDate;


  @override
  bool operator ==(dynamic other) {
    return other is Bet && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  void _markAsCompleted() {
    completionDate = DateTime.now();
    notifyListeners();
  }

  bool isCompleted() => completionDate != null;
}

class Better {
  Better({
    @required this.id,
    @required this.name,
    @required this.avatar,
  });

  final String id;
  final String name;
  final CircleAvatar avatar;

 @override
  bool operator ==(dynamic other) {
    return other is Better && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}