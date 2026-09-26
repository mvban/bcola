import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/card.dart';

class GameProvider extends ChangeNotifier {
  GameModel _game = const GameModel(
    deck: [],
    playerHand: [],
    aiHand: [],
    state: GameState.lobby,
  );

  GameModel get game => _game;

  static List<BriscolaCard> _buildDeck() {
    const suits = ['coppe', 'spade', 'denari', 'bastoni'];
    // Briscola uses 1-7, 11 (Fante), 12 (Cavallo), 13 (Re) — 40 cards total
    const values = [1, 2, 3, 4, 5, 6, 7, 11, 12, 13];
    final deck = <BriscolaCard>[];
    for (final suit in suits) {
      for (final value in values) {
        deck.add(BriscolaCard(
          value: value,
          suit: suit,
          points: BriscolaCard.getPoints(value),
          displayName: BriscolaCard.getDisplayName(value),
          emoji: _suitEmoji(suit),
        ));
      }
    }
    return deck;
  }

  static String _suitEmoji(String suit) {
    switch (suit) {
      case 'coppe': return '🏆';
      case 'spade': return '⚔️';
      case 'denari': return '💰';
      case 'bastoni': return '🪄';
      default: return '?';
    }
  }

  void startGame() {
    final deck = _buildDeck()..shuffle(Random());
    final playerHand = deck.sublist(0, 3);
    final aiHand = deck.sublist(3, 6);
    final remainingDeck = deck.sublist(6);
    final trumpCard = remainingDeck.last;

    _game = GameModel(
      deck: remainingDeck,
      playerHand: playerHand,
      aiHand: aiHand,
      trumpCard: trumpCard,
      trumpSuit: trumpCard.suit,
      playerScore: 0,
      aiScore: 0,
      state: GameState.playing,
      isPlayerTurn: true,
    );
    notifyListeners();
  }

  void resetToLobby() {
    _game = const GameModel(
      deck: [],
      playerHand: [],
      aiHand: [],
      state: GameState.lobby,
    );
    notifyListeners();
  }

  // Player plays a card
  void playerPlayCard(BriscolaCard card) {
    if (!_game.isPlayerTurn || _game.state != GameState.playing) return;

    final newHand = List<BriscolaCard>.from(_game.playerHand)..remove(card);
    _game = _game.copyWith(
      playerHand: newHand,
      playerPlayed: card,
      isPlayerTurn: false,
    );
    notifyListeners();

    // AI plays after a short delay (handled by UI with Future.delayed)
    Future.delayed(const Duration(milliseconds: 800), _aiPlayCard);
  }

  void _aiPlayCard() {
    if (_game.aiHand.isEmpty) return;

    final aiCard = _selectAiCard();
    final newAiHand = List<BriscolaCard>.from(_game.aiHand)..remove(aiCard);

    _game = _game.copyWith(
      aiHand: newAiHand,
      aiPlayed: aiCard,
    );
    notifyListeners();

    // Resolve trick after display delay
    Future.delayed(const Duration(milliseconds: 1200), _resolveTrick);
  }

  BriscolaCard _selectAiCard() {
    // Simple AI: play trump if player played trump with high points, else play highest non-trump
    final playerCard = _game.playerPlayed!;
    final trumpSuit = _game.trumpSuit!;

    // Try to win the trick
    final trumpCards = _game.aiHand.where((c) => c.suit == trumpSuit).toList();
    final nonTrumpCards = _game.aiHand.where((c) => c.suit != trumpSuit).toList();

    if (playerCard.suit == trumpSuit) {
      // Player played trump — try to beat with higher trump
      final winningTrumps = trumpCards.where((c) => c.points > playerCard.points).toList();
      if (winningTrumps.isNotEmpty) {
        winningTrumps.sort((a, b) => a.points.compareTo(b.points));
        return winningTrumps.first;
      }
    } else if (playerCard.points > 4) {
      // Player played a valuable non-trump card — use trump to win
      if (trumpCards.isNotEmpty) {
        trumpCards.sort((a, b) => a.points.compareTo(b.points));
        return trumpCards.first;
      }
    }

    // Otherwise throw lowest value non-trump
    if (nonTrumpCards.isNotEmpty) {
      nonTrumpCards.sort((a, b) => a.points.compareTo(b.points));
      return nonTrumpCards.first;
    }
    return _game.aiHand.first;
  }

  void _resolveTrick() {
    final playerCard = _game.playerPlayed!;
    final aiCard = _game.aiPlayed!;
    final trumpSuit = _game.trumpSuit!;
    final trickPoints = playerCard.points + aiCard.points;

    bool playerWins;
    if (playerCard.suit == aiCard.suit) {
      playerWins = playerCard.points > aiCard.points;
    } else if (aiCard.suit == trumpSuit) {
      playerWins = false; // AI played trump
    } else if (playerCard.suit == trumpSuit) {
      playerWins = true; // Player played trump
    } else {
      playerWins = true; // Neither match suit, player led
    }

    final newPlayerScore = _game.playerScore + (playerWins ? trickPoints : 0);
    final newAiScore = _game.aiScore + (!playerWins ? trickPoints : 0);

    // Draw new cards from deck
    var newDeck = List<BriscolaCard>.from(_game.deck);
    var newPlayerHand = List<BriscolaCard>.from(_game.playerHand);
    var newAiHand = List<BriscolaCard>.from(_game.aiHand);

    // Winner draws first
    if (newDeck.isNotEmpty) {
      if (playerWins) {
        newPlayerHand.add(newDeck.removeAt(0));
        if (newDeck.isNotEmpty) newAiHand.add(newDeck.removeAt(0));
      } else {
        newAiHand.add(newDeck.removeAt(0));
        if (newDeck.isNotEmpty) newPlayerHand.add(newDeck.removeAt(0));
      }
    }

    final isFinished = newPlayerHand.isEmpty && newAiHand.isEmpty;

    _game = _game.copyWith(
      deck: newDeck,
      playerHand: newPlayerHand,
      aiHand: newAiHand,
      playerScore: newPlayerScore,
      aiScore: newAiScore,
      isPlayerTurn: playerWins,
      state: isFinished ? GameState.finished : GameState.playing,
      playerPlayed: null,
      aiPlayed: null,
    );
    notifyListeners();
  }
}
