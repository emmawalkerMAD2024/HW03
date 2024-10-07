import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_game_state.dart';
import 'card_tile.dart';

void main() {
  runApp(
    ChangeNotifierProvider<CardGameState>( 
      create: (_) => CardGameState(), 
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CardMatchingGame(),
    );
  }
}

class CardMatchingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<CardGameState>(context); 
    return Scaffold(
      appBar: AppBar(title: Text('Card Matching Game')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, 
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: gameState.cards.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return CardTile(index: index); 
        },
      ),
    );
  }
}