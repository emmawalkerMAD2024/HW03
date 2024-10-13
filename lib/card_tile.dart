import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_game_state.dart';

class CardTile extends StatefulWidget {
  final int index;

  const CardTile({required this.index});

  @override
  _CardTileState createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    final gameState = Provider.of<CardGameState>(context, listen: false);
    final card = gameState.cards[widget.index];

    if (!card.isFaceUp && !card.isMatched) {
      _controller.forward();
    } else if (card.isFaceUp && !card.isMatched) {
      _controller.reverse();
    }

    gameState.flipCard(widget.index, context); // Pass context here
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<CardGameState>(context);
    final card = gameState.cards[widget.index];

    if (card.isMatched) {
      return SizedBox.shrink(); // Hide matched cards
    }

    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isUnder = _animation.value > 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(_animation.value * 3.1416),
            child: isUnder
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4.0, offset: Offset(2, 2))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        card.front,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4.0, offset: Offset(2, 2))
                      ],
                    ),
                    child: Center(
                      child: Text(''), // Blank when the card is face-down
                    ),
                  ),
          );
        },
      ),
    );
  }
}
