import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_game_state.dart';
import 'card_tile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CardGameState(),
      child: CardMatchingApp(),
    ),
  );
}

class CardMatchingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Matching Game',
      theme: ThemeData(primarySwatch: Colors.blue),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final availableHeight = constraints.maxHeight;

          const int columns = 4;
          final int rows = (gameState.cards.length / columns).ceil();

          final cardWidth = availableWidth / columns;
          final cardHeight = availableHeight / rows;

          final aspectRatio = cardWidth / cardHeight;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: aspectRatio,
              ),
              itemCount: gameState.cards.length,
              itemBuilder: (context, index) {
                return CardTile(index: index);
              },
              physics: BouncingScrollPhysics(),
            ),
          );
        },
      ),
    );
  }
}