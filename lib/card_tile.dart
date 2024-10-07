import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_game_state.dart';

class CardTile extends StatelessWidget {
  final int index;

  const CardTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<CardGameState>(context);
    final card = gameState.cards[index];

    return GestureDetector(
      onTap: () {
        gameState.flipCard(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        transform: Matrix4.rotationY(card.isFaceUp ? 0 : 3.1416),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4.0, offset: Offset(2, 2))
          ],
        ),
        child: Center(
          child: Text(
            card.isFaceUp ? card.front : '❓',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
