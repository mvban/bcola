import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class GameTutorialScreen extends StatefulWidget {
  const GameTutorialScreen({super.key});

  @override
  State<GameTutorialScreen> createState() => _GameTutorialScreenState();
}

class _GameTutorialScreenState extends State<GameTutorialScreen> {
  int _currentStep = 0;

  final List<_TutorialStep> _steps = const [
    _TutorialStep(
      emoji: '🃏',
      title: 'The Deck',
      content: 'Briscola uses a 40-card Italian deck. No 8s, 9s, or 10s. The four suits are Coppe (Cups), Spade (Swords), Denari (Coins), and Bastoni (Clubs).\n\nEach suit has 10 cards: Asso, 2, 3, 4, 5, 6, 7, Fante, Cavallo, and Re.',
    ),
    _TutorialStep(
      emoji: '⭐',
      title: 'Card Values',
      content: 'Not all cards are equal! Points are distributed as follows:\n\n🏅 Asso (Ace) = 11 points\n🥈 3 = 10 points\n👑 Re (King) = 4 points\n🐴 Cavallo (Horse) = 3 points\n⚔️ Fante (Jack) = 2 points\n⬜ 2, 4, 5, 6, 7 = 0 points\n\nTotal: 120 points in the deck.',
    ),
    _TutorialStep(
      emoji: '🎴',
      title: 'The Briscola (Trump)',
      content: 'At the start, one card is turned face-up at the bottom of the deck. That card\'s SUIT is the trump suit — the Briscola.\n\nTrump cards beat all non-trump cards, regardless of value. This is the heart of the game strategy.',
    ),
    _TutorialStep(
      emoji: '🤲',
      title: 'How to Play',
      content: 'Each player holds 3 cards. On your turn:\n\n1. Play any card from your hand\n2. The AI plays a card\n3. The winner of the trick takes both cards\n4. Both players draw from the deck (winner draws first)\n5. Repeat until the deck and hands are empty',
    ),
    _TutorialStep(
      emoji: '🏆',
      title: 'Winning a Trick',
      content: 'Who wins a trick?\n\n• If both cards are the same suit: the higher VALUE wins\n• If one card is the Briscola (trump) suit and the other is not: the trump wins\n• If neither card is trump and they\'re different suits: the FIRST card played wins\n\nThe winner leads the next trick.',
    ),
    _TutorialStep(
      emoji: '🎯',
      title: 'Winning the Game',
      content: 'Count the points in your captured tricks when the deck runs out.\n\n• 61+ points: You WIN! 🏆\n• 60 points each: Draw 🤝\n• 59 or fewer: You lose 😤\n\nThe Asso (11 pts) and the 3 (10 pts) are the most valuable cards to capture. Hunt them down!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    final isLast = _currentStep == _steps.length - 1;

    return Scaffold(
      backgroundColor: AppColors.espressoBrown,
      appBar: AppBar(
        backgroundColor: AppColors.espressoBrown,
        title: Text('How to Play Briscola', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.goldenYellow)),
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: List.generate(_steps.length, (i) => Expanded(
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: i <= _currentStep ? AppColors.goldenYellow : Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
              ),
            ),

            // Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                ),
                child: SingleChildScrollView(
                  key: ValueKey(_currentStep),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Emoji
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.goldenYellow.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.goldenYellow.withOpacity(0.3), width: 2),
                        ),
                        child: Center(
                          child: Text(step.emoji, style: const TextStyle(fontSize: 50)),
                        ),
                      ).animate().scale(begin: const Offset(0.5, 0.5)).fadeIn(),

                      const SizedBox(height: 24),

                      Text(
                        step.title,
                        style: AppTextStyles.displayMedium.copyWith(color: AppColors.goldenYellow),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 100.ms),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Text(
                          step.content,
                          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.warmCreamDark, height: 1.7),
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 16),

                      Text(
                        '${_currentStep + 1} of ${_steps.length}',
                        style: AppTextStyles.bodySmall.copyWith(color: Colors.white38),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Navigation
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _currentStep--),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          side: const BorderSide(color: Colors.white24),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: isLast
                        ? () => Navigator.of(context).pop()
                        : () => setState(() => _currentStep++),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.goldenYellow,
                        foregroundColor: AppColors.espressoBrown,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      child: Text(isLast ? '🃏 Let\'s Play!' : 'Next'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TutorialStep {
  final String emoji;
  final String title;
  final String content;
  const _TutorialStep({required this.emoji, required this.title, required this.content});
}
