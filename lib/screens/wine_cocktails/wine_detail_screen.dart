import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../providers/wine_provider.dart';
import '../../models/wine.dart';

class WineDetailScreen extends StatelessWidget {
  final String wineId;
  const WineDetailScreen({super.key, required this.wineId});

  Color _typeColor(String type) {
    switch (type) {
      case 'red': return AppColors.trattoriaRed;
      case 'white': return AppColors.goldenYellowDark;
      case 'sparkling': return const Color(0xFF1565C0);
      case 'rosé': return const Color(0xFFE91E63);
      default: return AppColors.warmWood;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<WineProvider>();
    // Look in all wines (not just filtered)
    final allWines = [...provider.filteredWines];
    // Try to find across all types
    Wine? wine;
    for (final type in ['All', 'Red', 'White', 'Sparkling', 'Rosé']) {
      provider.setType(type);
      try {
        wine = provider.filteredWines.firstWhere((w) => w.id == wineId);
        break;
      } catch (_) {}
    }
    provider.setType('All');
    wine ??= allWines.isNotEmpty ? allWines.first : null;

    if (wine == null) {
      return const Scaffold(body: Center(child: Text('Wine not found')));
    }

    final w = wine;
    final color = _typeColor(w.type);

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color.withOpacity(0.8), color],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Text(w.emoji, style: const TextStyle(fontSize: 72))
                        .animate().scale(begin: const Offset(0, 0)).fadeIn(),
                    const SizedBox(height: 8),
                    Text(w.type.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 2)),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(w.name, style: AppTextStyles.displayMedium).animate().fadeIn(delay: 100.ms),
                  Text('${w.producer} · ${w.vintage}', style: AppTextStyles.italic).animate().fadeIn(delay: 150.ms),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text('📍 ${w.region} · ${w.grape}', style: AppTextStyles.bodySmall),
                    backgroundColor: color.withOpacity(0.1),
                    side: BorderSide(color: color.withOpacity(0.3)),
                  ).animate().fadeIn(delay: 200.ms),

                  const Divider(height: 32),

                  // Price row
                  Row(
                    children: [
                      _PriceBlock('\$${w.priceGlass.toInt()}', 'per glass', color),
                      const SizedBox(width: 16),
                      _PriceBlock('\$${w.priceBottle.toInt()}', 'per bottle', color),
                    ],
                  ).animate().fadeIn(delay: 250.ms),

                  const SizedBox(height: 24),

                  _Label('Tasting Notes'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: color.withOpacity(0.2)),
                    ),
                    child: Text(w.tastingNotes, style: AppTextStyles.bodyLarge),
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 20),

                  _Label('The Winery'),
                  const SizedBox(height: 8),
                  Text(w.story, style: AppTextStyles.bodyLarge).animate().fadeIn(delay: 350.ms),

                  const SizedBox(height: 20),

                  _Label('Pairs Well With'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8, runSpacing: 8,
                    children: w.pairings.map((p) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.softWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color.withOpacity(0.3)),
                      ),
                      child: Text(p, style: AppTextStyles.bodySmall.copyWith(color: color, fontWeight: FontWeight.w600)),
                    )).toList(),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceBlock extends StatelessWidget {
  final String price;
  final String label;
  final Color color;
  const _PriceBlock(this.price, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Text(price, style: AppTextStyles.price.copyWith(color: color, fontSize: 22)),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: AppTextStyles.category.copyWith(fontSize: 12, letterSpacing: 2));
  }
}
