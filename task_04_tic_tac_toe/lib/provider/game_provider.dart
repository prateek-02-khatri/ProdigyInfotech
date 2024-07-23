import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  int _turn = 1;
  final Map<int, String> _marks = {};
  final List<int> _filledBlocks = [];
  final List<int> _player1 = [];
  final List<int> _player2 = [];

  int get turn => _turn;
  Map<int, String> get marks => _marks;
  List<int> get filledBlocks => _filledBlocks;
  List<int> get player1 => _player1;
  List<int> get player2 => _player2;


  void setTurn(int turn) {
    _turn = turn;
    notifyListeners();
  }

  void addFilledBlocks(int index) {
    _filledBlocks.add(index);
    notifyListeners();
  }

  void addPlayer1Mark(int index) {
    _player1.add(index);
    _marks[index] = 'X';
    notifyListeners();
  }

  void addPlayer2Mark(int index) {
    _player2.add(index);
    _marks[index] = 'O';
    notifyListeners();
  }

  List<List<int>> winningCombination = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],

    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],

    [0, 4, 8],
    [2, 4, 6],
  ];

  String? checkWinner(Map<int, String> marks) {
    for (var combination in winningCombination) {
      String? a = marks[combination[0]];
      String? b = marks[combination[1]];
      String? c = marks[combination[2]];

      if (a != null && a == b && a == c) {
        return a;
      }
    }

    if (_filledBlocks.length == 9) {
      return 'draw';
    }

    return null;
  }

  void reset() {
    _turn = 1;
    _player1.clear();
    _player2.clear();
    _filledBlocks.clear();
    _marks.clear();
    notifyListeners();
  }
}