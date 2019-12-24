import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:long_term_bets/data/Better.dart';
import 'package:long_term_bets/mixins/LoginHelepr.dart';
import 'package:long_term_bets/mixins/QueriesHelper.dart';

class Bets with ChangeNotifier, LoginHelper {

  List<Bet> _allBets = <Bet>[];
  final HashSet<Bet> _wonBets = HashSet<Bet>();
  final HashSet<Bet> _lostBets = HashSet<Bet>();
  final HashSet<Bet> _runningBets = HashSet<Bet>();

  List<Bet> sortBets(List<Bet> bets) {
    bets.sort((Bet a, Bet  b) => a.createdAt.compareTo(b.createdAt));
    return bets;
  }

  Future<List<Bet>> allBets(BuildContext context, bool shouldRefresh) async {
    if (!shouldRefresh) {
      return sortBets(_allBets);
    }

    final GraphQLClient client = QueriesHelper.getClient(context);
    final String token = await LoginHelper.getIDToken();
    final QueryResult res = await QueriesHelper.makeQuery(
      client, QueriesHelper.readAllBets(token)
    );
    final List<dynamic> betsResult =res.data['readAllBets']['bets'];
     _allBets = betsResult.map((dynamic bet) => Bet(
      id: bet['id'],
      description: bet['description'],
      payment: bet['payment'],
      accepter: Better(
        id: bet['accepter']['id'],
        avatar: NetworkImage(bet['accepter']['avatar']),
        email: bet['accepter']['email'],
        name: bet['accepter']['name']
      ),
      better: Better(
        id: bet['better']['id'],
        avatar: NetworkImage(bet['better']['avatar']),
        email: bet['better']['email'],
        name: bet['better']['name']
      ),
      expiryDate: DateTime.fromMillisecondsSinceEpoch(
        bet['expiryDate']['seconds'] * 1000
      ),
      completionDate: DateTime.fromMillisecondsSinceEpoch(
        bet['completionDate']['seconds'] * 1000
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        bet['createdAt']['seconds'] * 1000
      ),
    )).toList();

    return sortBets(_allBets);
  }
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

  Future<void> delete(BuildContext context, Bet bet) async {
    _runningBets.remove(bet);
    _wonBets.remove(bet);
    _lostBets.remove(bet);
    _allBets.remove(bet);
    notifyListeners();

    await Future<void>.delayed(const Duration(seconds: 5), () async {
      final String token = await LoginHelper.getIDToken();
      final QueryResult res = await QueriesHelper.makeQuery(
        context, QueriesHelper.deleteBet(token, bet)
      );
      if (res.hasErrors) {
        final GraphQLError error =res.errors.toList()[0];
        _allBets.add(bet);
        if (bet.completionDate == null) {
          _runningBets.add(bet);
        } else {
          final Better user = await LoginHelper.getLoggedInUser(context);
          if (user == bet.winner) {
            _wonBets.add(bet);
          } else {
            _lostBets.add(bet);
          }
        }
      }
      notifyListeners();
    });
  }


  Future<void> add(BuildContext context, Bet bet) async {
    final String token = await LoginHelper.getIDToken();
    final QueryResult res = await QueriesHelper.makeQuery(
      context, QueriesHelper.createBet(token, bet)
    );
    final String betId =res.data['createBet']['id'];
    bet._id = betId;
    bet._createdAt = DateTime.now();
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
    DateTime createdAt,
    Better winner,
    String id,
  }) {
    _payment = payment;
    _description = description;
    _expiryDate = expiryDate;
    _completionDate = completionDate;
    _winner = winner;
    _accepter = accepter;
    _id = id;
    _createdAt = createdAt;
  }

  final Better better;
  String _id;
  Better _accepter;
  String _description;
  String _payment;
  DateTime _expiryDate;
  DateTime _completionDate;
  DateTime _createdAt;
  Better _winner;


  @override
  bool operator ==(dynamic other) {
    return other is Bet && other.id == id;
  }

  String get description => _description;
  String get payment => _payment;
  DateTime get expiryDate => _expiryDate;
  DateTime get createdAt => _createdAt;
  DateTime get completionDate => _completionDate;
  Better get winner => _winner;
  Better get accepter => _accepter;
  String get id => _id;


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
