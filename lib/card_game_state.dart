import 'package:flutter/material.dart';

class CardModel {
  final String front;
  bool isFaceUp;
  bool isMatched;

  CardModel({required this.front, this.isFaceUp = false, this.isMatched = false});
}

class CardGameState extends ChangeNotifier { 
  List<CardModel> cards = [
    CardModel(front: '🍎'), CardModel(front: '🍎'),
    CardModel(front: '🍌'), CardModel(front: '🍌'),
    CardModel(front: '🍇'), CardModel(front: '🍇'),
    CardModel(front: '🍉'), CardModel(front: '🍉'),
    CardModel(front: '🍒'), CardModel(front: '🍒'),
    CardModel(front: '🍓'), CardModel(front: '🍓'),
    CardModel(front: '🥭'), CardModel(front: '🥭'),
    CardModel(front: '🍍'), CardModel(front: '🍍'),
  ];

  List<int> selectedCards = [];

  CardGameState() {
    cards.shuffle();
  }

  void flipCard(int index) {
    if (cards[index].isMatched || selectedCards.length == 2) return;

    cards[index].isFaceUp = !cards[index].isFaceUp;
    selectedCards.add(index);

    if (selectedCards.length == 2) {
      _checkMatch();
    }
    notifyListeners();
  }

  void _checkMatch() async {
    if (cards[selectedCards[0]].front == cards[selectedCards[1]].front) {
      cards[selectedCards[0]].isMatched = true;
      cards[selectedCards[1]].isMatched = true;
    } else {
      await Future.delayed(Duration(seconds: 1)); 
      cards[selectedCards[0]].isFaceUp = false;
      cards[selectedCards[1]].isFaceUp = false;
    }
    selectedCards.clear();
    notifyListeners();
  }
}
