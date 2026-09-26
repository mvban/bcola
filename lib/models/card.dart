class BriscolaCard {
  final int value;    // 1-7, 11 (Fante), 12 (Cavallo), 13 (Re)
  final String suit;  // coppe (cups), spade (swords), denari (coins), bastoni (clubs)
  final int points;   // 11 for Ace, 10 for 3, 4 for Re, 3 for Cavallo, 2 for Fante, 0 for 4-7
  final String displayName;
  final String emoji;

  const BriscolaCard({
    required this.value,
    required this.suit,
    required this.points,
    required this.displayName,
    required this.emoji,
  });

  String get suitSymbol {
    switch (suit) {
      case 'coppe':
        return '🏆';
      case 'spade':
        return '⚔️';
      case 'denari':
        return '💰';
      case 'bastoni':
        return '🪄';
      default:
        return '?';
    }
  }

  String get suitName {
    switch (suit) {
      case 'coppe':
        return 'Coppe';
      case 'spade':
        return 'Spade';
      case 'denari':
        return 'Denari';
      case 'bastoni':
        return 'Bastoni';
      default:
        return suit;
    }
  }

  static int getPoints(int value) {
    switch (value) {
      case 1:
        return 11; // Asso
      case 3:
        return 10;
      case 13:
        return 4; // Re
      case 12:
        return 3; // Cavallo
      case 11:
        return 2; // Fante
      default:
        return 0; // 2, 4, 5, 6, 7
    }
  }

  static String getDisplayName(int value) {
    switch (value) {
      case 1:
        return 'Asso';
      case 11:
        return 'Fante';
      case 12:
        return 'Cavallo';
      case 13:
        return 'Re';
      default:
        return value.toString();
    }
  }
}

enum GameState { lobby, playing, finished }

class GameModel {
  final List<BriscolaCard> deck;
  final List<BriscolaCard> playerHand;
  final List<BriscolaCard> aiHand;
  final BriscolaCard? trumpCard;
  final String? trumpSuit;
  final int playerScore;
  final int aiScore;
  final GameState state;
  final bool isPlayerTurn;
  final BriscolaCard? playerPlayed;
  final BriscolaCard? aiPlayed;

  const GameModel({
    required this.deck,
    required this.playerHand,
    required this.aiHand,
    this.trumpCard,
    this.trumpSuit,
    this.playerScore = 0,
    this.aiScore = 0,
    this.state = GameState.lobby,
    this.isPlayerTurn = true,
    this.playerPlayed,
    this.aiPlayed,
  });

  GameModel copyWith({
    List<BriscolaCard>? deck,
    List<BriscolaCard>? playerHand,
    List<BriscolaCard>? aiHand,
    BriscolaCard? trumpCard,
    String? trumpSuit,
    int? playerScore,
    int? aiScore,
    GameState? state,
    bool? isPlayerTurn,
    BriscolaCard? playerPlayed,
    BriscolaCard? aiPlayed,
  }) {
    return GameModel(
      deck: deck ?? this.deck,
      playerHand: playerHand ?? this.playerHand,
      aiHand: aiHand ?? this.aiHand,
      trumpCard: trumpCard ?? this.trumpCard,
      trumpSuit: trumpSuit ?? this.trumpSuit,
      playerScore: playerScore ?? this.playerScore,
      aiScore: aiScore ?? this.aiScore,
      state: state ?? this.state,
      isPlayerTurn: isPlayerTurn ?? this.isPlayerTurn,
      playerPlayed: playerPlayed,
      aiPlayed: aiPlayed,
    );
  }
}
