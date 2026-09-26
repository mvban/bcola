import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/constants/app_strings.dart';
import '../../services/url_launcher_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          const _HeroSliver(),
          SliverToBoxAdapter(child: _QuickActions(context: context)),
          SliverToBoxAdapter(child: _AboutSection()),
          SliverToBoxAdapter(child: _HoursSection()),
          SliverToBoxAdapter(child: _ContactSection(context: context)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _HeroSliver extends StatelessWidget {
  const _HeroSliver();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      backgroundColor: AppColors.trattoriaRed,
      automaticallyImplyLeading: false,
      leading: context.canPop()
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.warmCream),
              onPressed: () => context.pop(),
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.trattoriaRedDark,
                    AppColors.trattoriaRed,
                    Color(0xFFB71C1C),
                  ],
                ),
              ),
            ),
            // Decorative pattern
            Positioned.fill(
              child: CustomPaint(painter: _PatternPainter()),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Briscola', style: AppTextStyles.displayLargeOnDark.copyWith(fontSize: 48, letterSpacing: -1, color: AppColors.goldenYellow))
                      .animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
                  Text('TRATTORIA', style: AppTextStyles.labelLarge.copyWith(color: AppColors.warmCream, letterSpacing: 8, fontSize: 13))
                      .animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 8),
                  Text('Modern Italian · Crown Heights, Brooklyn', style: AppTextStyles.tagline)
                      .animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 20),
                  const _OpenStatusChip(),
                ],
              ),
            ),
          ],
        ),
      ),
      title: Text(
        AppStrings.restaurantName,
        style: AppTextStyles.headlineLarge.copyWith(color: AppColors.warmCream),
      ),
      titleSpacing: 16,
    );
  }
}

class _OpenStatusChip extends StatelessWidget {
  const _OpenStatusChip();

  bool _isOpenNow() {
    final now = DateTime.now();
    final weekday = now.weekday; // 1=Mon, 7=Sun
    final hour = now.hour;
    final minute = now.minute;
    final timeInMins = hour * 60 + minute;

    if (weekday >= 1 && weekday <= 4) {
      // Mon–Thu: 5:30 PM (17:30) – 9:30 PM (21:30)
      return timeInMins >= 1050 && timeInMins <= 1290;
    } else if (weekday == 5) {
      // Fri: 5:00 PM (17:00) – 10:30 PM (22:30)
      return timeInMins >= 1020 && timeInMins <= 1350;
    } else {
      // Sat–Sun: 12:00 PM (12:00) – 10:30 PM (22:30) or 9:30 PM
      final closeTime = weekday == 6 ? 1350 : 1290;
      return timeInMins >= 720 && timeInMins <= closeTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = _isOpenNow();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: (isOpen ? Colors.green.shade600 : Colors.red.shade800).withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              color: isOpen ? Colors.greenAccent : Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isOpen ? 'Open Now' : 'Closed',
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.8, 0.8));
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width + 60; x += 60) {
      for (double y = 0; y < size.height + 60; y += 60) {
        final path = Path()
          ..moveTo(x, y - 20)
          ..lineTo(x + 20, y)
          ..lineTo(x, y + 20)
          ..lineTo(x - 20, y)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_PatternPainter oldDelegate) => false;
}

class _QuickActions extends StatelessWidget {
  final BuildContext context;
  const _QuickActions({required this.context});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action('Reserve\nTable', Icons.table_restaurant, AppColors.trattoriaRed, () => UrlLauncherService.openResy(context)),
      _Action('Order\nOnline', Icons.delivery_dining, AppColors.goldenYellowDark, () => UrlLauncherService.openToast(context)),
      _Action('Get\nDirections', Icons.map_outlined, AppColors.warmWood, () => UrlLauncherService.openDirections(context, AppStrings.restaurantAddress)),
      _Action('Dessert\nCart', Icons.cake_outlined, const Color(0xFF6A1B9A), () => GoRouter.of(context).go('/dessert')),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: actions.map((a) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _QuickActionCard(action: a),
          ),
        )).toList(),
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2);
  }
}

class _Action {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  _Action(this.label, this.icon, this.color, this.onTap);
}

class _QuickActionCard extends StatelessWidget {
  final _Action action;
  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(action.icon, color: action.color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              action.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.espressoBrown, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.espressoBrown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🍝', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text('Our Story', style: AppTextStyles.headlineLarge.copyWith(color: AppColors.goldenYellow)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Chef Silvia Barban — Top Chef alumna from Northern Italy — brings her regional Italian heritage to Crown Heights. Briscola Trattoria is named after the centuries-old Italian card game, a nod to the convivial spirit of gathering around a table.',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.warmCreamDark, height: 1.7),
            ),
            const SizedBox(height: 12),
            Text(
              '"Every dish tells the story of a region, a grandmother, a season."',
              style: AppTextStyles.italic.copyWith(color: AppColors.goldenYellow),
            ),
            const SizedBox(height: 4),
            Text('— Chef Silvia Barban', style: AppTextStyles.labelSmall.copyWith(color: AppColors.warmWoodLight)),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2);
  }
}

class _HoursSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hours = [
      ('Mon – Thu', AppStrings.hoursMonThu),
      ('Friday', AppStrings.hoursFri),
      ('Saturday', AppStrings.hoursSat),
      ('Sunday', AppStrings.hoursSun),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🕯️', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Text('Hours', style: AppTextStyles.headlineLarge),
              ],
            ),
            const SizedBox(height: 4),
            Text('Resy · 15-min grace period', style: AppTextStyles.bodySmall.copyWith(color: AppColors.warmWood)),
            const Divider(height: 24),
            ...hours.map((h) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(h.$1, style: AppTextStyles.labelLarge),
                  Text(h.$2, style: AppTextStyles.bodyMedium),
                ],
              ),
            )),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
}

class _ContactSection extends StatelessWidget {
  final BuildContext context;
  const _ContactSection({required this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: _ContactCard(
              icon: Icons.phone_outlined,
              label: 'Call Us',
              subtitle: AppStrings.restaurantPhone,
              color: AppColors.trattoriaRed,
              onTap: () => UrlLauncherService.makeCall(context, AppStrings.restaurantPhone),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ContactCard(
              icon: Icons.mail_outline,
              label: 'Email Us',
              subtitle: 'briscolabrooklyn\n@gmail.com',
              color: AppColors.goldenYellowDark,
              onTap: () => UrlLauncherService.sendEmail(context, AppStrings.restaurantEmail),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 350.ms);
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(label, style: AppTextStyles.headlineSmall.copyWith(color: color)),
            const SizedBox(height: 4),
            Text(subtitle, style: AppTextStyles.bodySmall, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
