import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class GameLobbyScreen extends StatelessWidget {
  const GameLobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.espressoBrown,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Briscola', style: AppTextStyles.displaySmallOnDark.copyWith(color: AppColors.goldenYellow)),
            backgroundColor: AppColors.espressoBrown,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Hero
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF4E342E), AppColors.espressoBrown],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.goldenYellow.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        // Playing cards display
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _FanCard('🏆', 'Asso', 'di Coppe', -15),
                            _FanCard('⚔️', 'Re', 'di Spade', 0),
                            _FanCard('💰', '3', 'di Denari', 15),
                          ],
                        )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .slideY(begin: 0.3),
                        const SizedBox(height: 24),
                        Text(
                          'La Briscola',
                          style: AppTextStyles.displayLargeOnDark.copyWith(color: AppColors.goldenYellow, fontSize: 40),
                        ).animate().fadeIn(delay: 200.ms),
                        const SizedBox(height: 8),
                        Text(
                          'The traditional Italian card game that inspired this trattoria',
                          style: AppTextStyles.tagline,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 300.ms),
                        const SizedBox(height: 24),
                        // Point values reference
                        _PointsReference(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Play options
                  Text('Choose Your Mode', style: AppTextStyles.headlineLarge.copyWith(color: AppColors.warmCream))
                      .animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 16),

                  _GameModeCard(
                    title: 'Play vs. AI',
                    subtitle: 'Test your wits against the house. The staff challenge awaits.',
                    icon: '🤖',
                    color: AppColors.trattoriaRed,
                    onTap: () => context.go('/game/board'),
                  ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.1),

                  const SizedBox(height: 12),

                  _GameModeCard(
                    title: 'Learn the Rules',
                    subtitle: 'New to Briscola? A step-by-step tutorial to master the game.',
                    icon: '📖',
                    color: AppColors.goldenYellowDark,
                    onTap: () => context.go('/game/tutorial'),
                  ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.1),

                  const SizedBox(height: 32),

                  // Historical note
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      children: [
                        const Text('🃏', style: TextStyle(fontSize: 28)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Briscola is one of Italy\'s most popular card games, played with a 40-card Italian deck. The trump suit (briscola) is revealed at the start — and everything changes.',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.warmCreamDark),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 700.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FanCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String suit;
  final double rotation;

  const _FanCard(this.emoji, this.value, this.suit, this.rotation);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: 80,
        height: 110,
        margin: const EdgeInsets.symmetric(horizontal: -8),
        decoration: BoxDecoration(
          color: AppColors.warmCream,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.goldenYellow.withOpacity(0.5), width: 1.5),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8, offset: const Offset(2, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(value, style: AppTextStyles.headlineMedium.copyWith(fontSize: 14)),
            Text(suit, style: AppTextStyles.bodySmall.copyWith(fontSize: 9)),
          ],
        ),
      ),
    );
  }
}

class _PointsReference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final points = [
      ('Asso', '11 pts'),
      ('Tre', '10 pts'),
      ('Re', '4 pts'),
      ('Cavallo', '3 pts'),
      ('Fante', '2 pts'),
      ('2–7', '0 pts'),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Card Values', style: AppTextStyles.labelMedium.copyWith(color: AppColors.goldenYellow, letterSpacing: 1.5)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 6,
            children: points.map((p) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.goldenYellow.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: p.$1, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                    TextSpan(text: ' · ${p.$2}', style: TextStyle(color: AppColors.goldenYellow, fontSize: 11)),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _GameModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color color;
  final VoidCallback onTap;

  const _GameModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.headlineMedium.copyWith(color: color)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.warmCreamDark)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }
}
