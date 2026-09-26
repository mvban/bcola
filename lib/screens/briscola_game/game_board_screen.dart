import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../providers/game_provider.dart';
import '../../models/card.dart' as briscola;

class GameBoardScreen extends StatefulWidget {
  const GameBoardScreen({super.key});

  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, provider, _) {
        final game = provider.game;

        if (game.state == briscola.GameState.finished) {
          return _GameResultScreen(
            playerScore: game.playerScore,
            aiScore: game.aiScore,
            onRestart: () => provider.startGame(),
            onBack: () {
              provider.resetToLobby();
              Navigator.of(context).pop();
            },
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF1B5E20), // Green felt
          body: SafeArea(
            child: Column(
              children: [
                // Top bar
                _GameTopBar(
                  playerScore: game.playerScore,
                  aiScore: game.aiScore,
                  deckCount: game.deck.length,
                  trumpCard: game.trumpCard,
                  onQuit: () {
                    provider.resetToLobby();
                    Navigator.of(context).pop();
                  },
                ),

                // AI hand (face down)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _AIHandDisplay(cardCount: game.aiHand.length),
                ),

                // Play area
                Expanded(
                  child: _PlayArea(
                    playerPlayed: game.playerPlayed,
                    aiPlayed: game.aiPlayed,
                    trumpCard: game.trumpCard,
                    isPlayerTurn: game.isPlayerTurn,
                    deckCount: game.deck.length,
                  ),
                ),

                // Player hand
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _PlayerHandDisplay(
                    hand: game.playerHand,
                    isPlayerTurn: game.isPlayerTurn,
                    onCardTap: (card) => provider.playerPlayCard(card),
                  ),
                ),

                // Turn indicator
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: game.isPlayerTurn ? AppColors.goldenYellow : Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    game.isPlayerTurn ? '✨ Your Turn — Tap a card to play' : '🤔 AI is thinking...',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: game.isPlayerTurn ? AppColors.espressoBrown : Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GameTopBar extends StatelessWidget {
  final int playerScore;
  final int aiScore;
  final int deckCount;
  final briscola.BriscolaCard? trumpCard;
  final VoidCallback onQuit;

  const _GameTopBar({
    required this.playerScore,
    required this.aiScore,
    required this.deckCount,
    required this.trumpCard,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.black26,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70, size: 20),
            onPressed: onQuit,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ScoreBox('AI', aiScore, Colors.red.shade400),
                const SizedBox(width: 16),
                if (trumpCard != null)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('BRISCOLA', style: AppTextStyles.labelSmall.copyWith(color: Colors.white60, fontSize: 8)),
                      Text(trumpCard!.suitSymbol, style: const TextStyle(fontSize: 18)),
                      Text(trumpCard!.suitName, style: const TextStyle(color: Colors.white70, fontSize: 9)),
                    ],
                  ),
                const SizedBox(width: 16),
                _ScoreBox('You', playerScore, Colors.green.shade400),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '🂠 $deckCount',
              style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreBox extends StatelessWidget {
  final String label;
  final int score;
  final Color color;

  const _ScoreBox(this.label, this.score, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w600)),
        Text('$score', style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w900)),
        Text('pts', style: const TextStyle(color: Colors.white38, fontSize: 9)),
      ],
    );
  }
}

class _AIHandDisplay extends StatelessWidget {
  final int cardCount;
  const _AIHandDisplay({required this.cardCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(cardCount, (i) => Transform.rotate(
        angle: (i - cardCount / 2) * 0.12,
        child: Container(
          width: 44,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: -6),
          decoration: BoxDecoration(
            color: AppColors.trattoriaRed,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.goldenYellow.withOpacity(0.3)),
          ),
          child: const Center(child: Text('🂠', style: TextStyle(fontSize: 20))),
        ),
      )),
    );
  }
}

class _PlayArea extends StatelessWidget {
  final briscola.BriscolaCard? playerPlayed;
  final briscola.BriscolaCard? aiPlayed;
  final briscola.BriscolaCard? trumpCard;
  final bool isPlayerTurn;
  final int deckCount;

  const _PlayArea({
    required this.playerPlayed,
    required this.aiPlayed,
    required this.trumpCard,
    required this.isPlayerTurn,
    required this.deckCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // AI played card
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AI played', style: AppTextStyles.bodySmall.copyWith(color: Colors.white60)),
            const SizedBox(height: 8),
            if (aiPlayed != null)
              _PlayingCardWidget(card: aiPlayed!, isRevealed: true)
                  .animate(key: ValueKey('ai_${aiPlayed!.value}_${aiPlayed!.suit}'))
                  .scale(begin: const Offset(0.5, 0.5)).fadeIn()
            else
              _EmptyCardSlot(),
          ],
        ),

        // Center: deck
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (deckCount > 0 && trumpCard != null) ...[
              // Trump card lying face up
              Transform.rotate(
                angle: 1.5708, // 90 degrees
                child: _PlayingCardWidget(card: trumpCard!, isRevealed: true, isSmall: true),
              ),
              const SizedBox(height: 4),
              // Deck pile on top
              Container(
                width: 44, height: 60,
                decoration: BoxDecoration(
                  color: AppColors.trattoriaRed,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.goldenYellow.withOpacity(0.4)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🂠', style: TextStyle(fontSize: 20)),
                    Text('$deckCount', style: const TextStyle(color: Colors.white70, fontSize: 9)),
                  ],
                ),
              ),
            ],
          ],
        ),

        // Player played card
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You played', style: AppTextStyles.bodySmall.copyWith(color: Colors.white60)),
            const SizedBox(height: 8),
            if (playerPlayed != null)
              _PlayingCardWidget(card: playerPlayed!, isRevealed: true)
                  .animate(key: ValueKey('player_${playerPlayed!.value}_${playerPlayed!.suit}'))
                  .scale(begin: const Offset(0.5, 0.5)).fadeIn()
            else
              _EmptyCardSlot(),
          ],
        ),
      ],
    );
  }
}

class _EmptyCardSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 94,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _PlayerHandDisplay extends StatelessWidget {
  final List<briscola.BriscolaCard> hand;
  final bool isPlayerTurn;
  final void Function(briscola.BriscolaCard) onCardTap;

  const _PlayerHandDisplay({
    required this.hand,
    required this.isPlayerTurn,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: hand.map((card) {
        return GestureDetector(
          onTap: isPlayerTurn ? () => onCardTap(card) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            transform: isPlayerTurn ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
            child: _PlayingCardWidget(card: card, isRevealed: true, interactive: isPlayerTurn),
          ),
        );
      }).toList(),
    );
  }
}

class _PlayingCardWidget extends StatelessWidget {
  final briscola.BriscolaCard card;
  final bool isRevealed;
  final bool isSmall;
  final bool interactive;

  const _PlayingCardWidget({
    required this.card,
    required this.isRevealed,
    this.isSmall = false,
    this.interactive = false,
  });

  Color get _suitColor {
    switch (card.suit) {
      case 'coppe': return AppColors.cupGold;
      case 'spade': return AppColors.swordBlue;
      case 'denari': return AppColors.coinGold;
      case 'bastoni': return AppColors.clubGreen;
      default: return AppColors.espressoBrown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = isSmall ? 44.0 : 68.0;
    final height = isSmall ? 60.0 : 94.0;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.warmCream,
        borderRadius: BorderRadius.circular(isSmall ? 6 : 10),
        border: Border.all(
          color: interactive ? AppColors.goldenYellow : AppColors.divider,
          width: interactive ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: interactive ? AppColors.goldenYellow.withOpacity(0.3) : Colors.black26,
            blurRadius: interactive ? 8 : 4,
            spreadRadius: interactive ? 1 : 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            card.displayName,
            style: TextStyle(
              fontSize: isSmall ? 10 : 14,
              fontWeight: FontWeight.w900,
              color: _suitColor,
            ),
          ),
          Text(card.suitSymbol, style: TextStyle(fontSize: isSmall ? 16 : 24)),
          if (card.points > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: _suitColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${card.points}p',
                style: TextStyle(
                  fontSize: isSmall ? 7 : 9,
                  fontWeight: FontWeight.w700,
                  color: _suitColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GameResultScreen extends StatelessWidget {
  final int playerScore;
  final int aiScore;
  final VoidCallback onRestart;
  final VoidCallback onBack;

  const _GameResultScreen({
    required this.playerScore,
    required this.aiScore,
    required this.onRestart,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final playerWon = playerScore > aiScore;
    final isDraw = playerScore == aiScore;

    return Scaffold(
      backgroundColor: AppColors.espressoBrown,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isDraw ? '🤝' : (playerWon ? '🏆' : '😤'),
                  style: const TextStyle(fontSize: 80),
                ).animate().scale(begin: const Offset(0, 0)).fadeIn(duration: 500.ms),

                const SizedBox(height: 24),

                Text(
                  isDraw ? 'It\'s a Draw!' : (playerWon ? 'Bravissimo!' : 'The House Wins!'),
                  style: AppTextStyles.displayLargeOnDark.copyWith(
                    color: isDraw ? Colors.white : (playerWon ? AppColors.goldenYellow : AppColors.trattoriaRedLight),
                  ),
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 8),

                Text(
                  playerWon
                    ? 'You beat the house! Come challenge the staff in person.'
                    : (isDraw ? 'A fair match. Rematch?' : 'Don\'t worry — dinner is still on.'),
                  style: AppTextStyles.tagline,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 32),

                // Score display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ResultScore('You', playerScore, playerWon && !isDraw ? AppColors.goldenYellow : Colors.white60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text('vs', style: AppTextStyles.headlineMedium.copyWith(color: Colors.white38)),
                    ),
                    _ResultScore('AI', aiScore, !playerWon && !isDraw ? Colors.red.shade400 : Colors.white60),
                  ],
                ).animate().fadeIn(delay: 500.ms),

                const SizedBox(height: 48),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onBack,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          side: const BorderSide(color: Colors.white24),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Back to Lobby'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onRestart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.trattoriaRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Play Again'),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultScore extends StatelessWidget {
  final String label;
  final int score;
  final Color color;
  const _ResultScore(this.label, this.score, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('$score', style: TextStyle(color: color, fontSize: 42, fontWeight: FontWeight.w900)),
        const Text('/ 120', style: TextStyle(color: Colors.white38, fontSize: 12)),
      ],
    );
  }
}
