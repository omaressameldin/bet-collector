import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/mixins/LoginHelepr.dart';
import 'package:long_term_bets/mixins/QueriesHelper.dart';

class Bets with ChangeNotifier, LoginHelper {

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

  void markAsCompleted(Bet bet, Better winner) {
    if(_allBets.contains(bet)) {
      bet._markAsCompleted(winner);
      _runningBets.remove(bet);
      // if (winner == getLoggedInBetter()) {
      //   _wonBets.add(bet);
      // } else {
      //   _lostBets.add(bet);
      // }
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


  Future<void> add(BuildContext context, Bet bet) async {
    final String token = await LoginHelper.getIDToken();
      final QueryResult res = await QueriesHelper.makeQuery(
      context, QueriesHelper.createBet(token, bet)
    );
    final String betId =res.data['createBet']['id'];
    bet.id = betId;
    _allBets.add(bet);

    notifyListeners();
  }
}

class Bet with ChangeNotifier {
  Bet({
    @required this.better,
    @required Better accepter,
    @required String description,
    @required String payment,
    @required DateTime expiryDate,
    DateTime completionDate,
    Better winner,
  }) {
    _payment = payment;
    _description = description;
    _expiryDate = expiryDate;
    _completionDate = completionDate;
    _winner = winner;
    _accepter = accepter;
  }

  String id;
  final Better better;
  Better _accepter;
  String _description;
  String _payment;
  DateTime _expiryDate;
  DateTime _completionDate;
  Better _winner;


  @override
  bool operator ==(dynamic other) {
    return other is Bet && other.id == id;
  }

  String get description => _description;
  String get payment => _payment;
  DateTime get expiryDate => _expiryDate;
  DateTime get completionDate => _completionDate;
  Better get winner => _winner;
  Better get accepter => _accepter;

  @override
  int get hashCode => id.hashCode;

  void _markAsCompleted(Better winner) {
    if (winner != better && winner != accepter) {
      throw Exception('Only accepter or better can win a bet!');
    }

    _winner = winner;
    _completionDate = DateTime.now();
    notifyListeners();
  }

    void _markAsRunning() {
    _completionDate = null;
    _winner = null;

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

  int timeInSeconds() {
    return (expiryDate.millisecondsSinceEpoch/1000).round();
  }

  void editBetInfo({
    @required String description,
    @required String payment,
    @required DateTime expiryDate,
    @required Better accepter,
  }) {
    if (description != null) {
      _description = description;
    }
    if (payment != null) {
      _payment = payment;
    }
    if(expiryDate != null) {
      _expiryDate = expiryDate;
    }
    if(accepter != null) {
      _accepter = accepter;
    }
    notifyListeners();
  }
}
