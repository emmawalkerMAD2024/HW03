import 'package:flutter/material.dart';

class CardModel {
  final String front;
  bool isFaceUp;
  bool isMatched;

  CardModel({required this.front, this.isFaceUp = false, this.isMatched = false});
}

class CardGameState extends ChangeNotifier {
  List<CardModel> cards = [
    CardModel(front: 'A'),
    CardModel(front: 'A'),
    CardModel(front: 'B'),
    CardModel(front: 'B'),
    CardModel(front: 'C'),
    CardModel(front: 'C'),
    CardModel(front: 'D'),
    CardModel(front: 'D'),
    CardModel(front: 'E'),
    CardModel(front: 'E'),
    CardModel(front: 'F'),
    CardModel(front: 'F'),
    CardModel(front: 'G'),
    CardModel(front: 'G'),
    CardModel(front: 'H'),
    CardModel(front: 'H'),
  ];

  List<int> flippedIndices = [];
  bool isProcessing = false; // Flag to control card flipping

  void flipCard(int index, BuildContext context) {
    final card = cards[index];

    // Prevent flipping if we're already processing two cards or card is already flipped/matched
    if (isProcessing || card.isFaceUp || card.isMatched) return;

    // Flip the card face-up
    card.isFaceUp = true;
    flippedIndices.add(index);
    notifyListeners();

    // Check when two cards are flipped
    if (flippedIndices.length == 2) {
      isProcessing = true; // Lock further card flips

      final firstCard = cards[flippedIndices[0]];
      final secondCard = cards[flippedIndices[1]];

      if (firstCard.front == secondCard.front) {
        // Cards match
        firstCard.isMatched = true;
        secondCard.isMatched = true;

        // Show the "You made a match!" message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You made a match!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Clear flipped indices and unlock further flips
        Future.delayed(Duration(milliseconds: 500), () {
          flippedIndices.clear();
          isProcessing = false;
          notifyListeners();
        });

        // Optionally remove matched cards after a short delay
        Future.delayed(Duration(milliseconds: 1000), () {
          removeMatchedCards();
        });
      } else {
        // Cards don't match, flip them back after a short delay
        Future.delayed(Duration(milliseconds: 1000), () {
          firstCard.isFaceUp = false;
          secondCard.isFaceUp = false;

          // Clear flipped indices and unlock further flips
          flippedIndices.clear();
          isProcessing = false;
          notifyListeners();
        });
      }
    }
  }

  void removeMatchedCards() {
    // Optionally remove matched cards from the list (if you want them to disappear)
    cards.removeWhere((card) => card.isMatched);
    notifyListeners();
  }
}

