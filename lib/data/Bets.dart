import 'dart:collection';

import 'package:flutter/material.dart';
// TODO: Remove once backend is connected
Better better1 = Better(
  id: '1',
  name: 'Shadwa',
  avatar: NetworkImage('https://listimg.pinclipart.com/picdir/s/335-3356471_female-avatar-girls-avatar-clipart.png'),
);
Better better2 = Better(
  id: '2',
  name: 'Omar',
  avatar: NetworkImage('https://cdn0.iconfinder.com/data/icons/iconshock_guys/512/andrew.png'),
);

// TODO: Remove once backend is connected
List<Bet> bets = <Bet>[
      Bet(
        id: '1',
        better: better1,
        winner: better1,
        accepter: better2,
        description: 'shadwa will stay thin after marriage',
        payment: 'Omar will go down on shadwa for thirty minutes',
        expiryDate: DateTime(2024, 1, 1)
      ),
      Bet(
        id: '2',
        better: better2,
        winner: better1,
        accepter: better1,
        description: 'Aley is gonna live outside of Egypt',
        payment: 'Shadwa will give Omar a lapdance',
        expiryDate: DateTime(2022, 1, 1)
      ),
      Bet(
        id: '3',
        better: better2,
        winner: better2,
        accepter: better1,
        description: 'Aley will finish university soon',
        payment: 'Omar Will give shadwa 10\$',
        expiryDate: DateTime(2019, 1, 1),
        completionDate: DateTime(2018, 6, 1)
      )
    ];

class Bets with ChangeNotifier {
  Bets(): super() {
    _allBets.addAll(bets);
    _wonBets.add(bets[2]);
    _runningBets.add(bets[0]);
    _runningBets.add(bets[1]);
  }

  final HashSet<Bet> _allBets = HashSet<Bet>();
  final HashSet<Bet> _wonBets = HashSet<Bet>();
  final HashSet<Bet> _lostBets = HashSet<Bet>();
  final HashSet<Bet> _runningBets = HashSet<Bet>();



  HashSet<Bet> get allBets => _allBets;
  HashSet<Bet> get wonBets => _wonBets;
  HashSet<Bet> get lostBets => _lostBets;
  HashSet<Bet> get runningBets => _runningBets;


  void getNewBets() {
    notifyListeners();
  }

  // TODO: Remove once backend is connected
  Better getLoggedInBetter() {
    return better2;
  }

  void markAsCompleted(Bet bet, Better winner) {
    if(_allBets.contains(bet)) {
      bet._markAsCompleted(winner);
      _runningBets.remove(bet);
      if (winner == getLoggedInBetter()) {
        _wonBets.add(bet);
      } else {
        _lostBets.add(bet);
      }
    } else {
      throw Exception('Only running bets can be marked as completed');
    }

    notifyListeners();
  }

  void markAsRunning(Bet bet) {
    if (!_allBets.contains(bet) ||
      (!_wonBets.contains(bet) && !_lostBets.contains(bet))
    ) {
      throw Exception('Only completed bets can be marked as running');
    }

    _wonBets.remove(bet);
    _lostBets.remove(bet);
    bet._markAsRunning();
    _runningBets.add(bet);

    notifyListeners();
  }

  void delete(Bet bet) {
    _allBets.remove(bet);
    _wonBets.remove(bet);
    _lostBets.remove(bet);
    _runningBets.remove(bet);

    notifyListeners();
  }


  void add(Bet bet, Better currentUser, {int index = -1}) {
    _allBets.add(bet);
    if(bet.isCompleted()) {
      if (bet.winner == currentUser) {
        _wonBets.add(bet);
      } else {
        _lostBets.add(bet);
      }
    } else {
      _runningBets.add(bet);
    }

    notifyListeners();
  }
}

class Bet with ChangeNotifier {
  Bet({
    @required this.id,
    @required this.better,
    @required this.accepter,
    @required this.description,
    @required this.payment,
    @required this.expiryDate,
    this.completionDate,
    this.winner,
  });

  final String id;
  final Better better;
  final Better accepter;
  String description;
  String payment;
  DateTime expiryDate;
  DateTime completionDate;
  Better winner;


  @override
  bool operator ==(dynamic other) {
    return other is Bet && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  void _markAsCompleted(Better winner) {
    if (winner != better && winner != accepter) {
      throw Exception('Only accepter or better can win a bet!');
    }

    this.winner = winner;
    completionDate = DateTime.now();
    notifyListeners();
  }

    void _markAsRunning() {
    completionDate = null;
    winner = null;

    notifyListeners();
  }

  bool isCompleted() => completionDate != null && winner != null;

  Better getOtherSide(Better currentUser) {
    if (currentUser == better) {
      return accepter;
    } else {
      return better;
    }
  }
}


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
}