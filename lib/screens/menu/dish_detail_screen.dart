import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../providers/menu_provider.dart';
import '../../models/dish.dart';
import '../../services/url_launcher_service.dart';

class DishDetailScreen extends StatelessWidget {
  final String dishId;
  const DishDetailScreen({super.key, required this.dishId});

  @override
  Widget build(BuildContext context) {
    final menu = context.read<MenuProvider>();
    final dish = menu.allDishes.firstWhere(
      (d) => d.id == dishId,
      orElse: () => menu.allDishes.first,
    );

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppColors.trattoriaRed,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.warmCream),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.trattoriaRedDark, AppColors.trattoriaRed, Color(0xFF8E0000)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Text(dish.emoji, style: const TextStyle(fontSize: 80))
                        .animate().scale(begin: const Offset(0, 0)).fadeIn(duration: 400.ms),
                    const SizedBox(height: 12),
                    if (dish.isSignature)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.goldenYellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('★ Signature Dish', style: AppTextStyles.labelMedium.copyWith(color: AppColors.espressoBrown)),
                      ),
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
                  Text(dish.category.toUpperCase(), style: AppTextStyles.category)
                      .animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: 4),
                  Text(dish.name, style: AppTextStyles.displayMedium)
                      .animate().fadeIn(delay: 150.ms).slideX(begin: 0.1),
                  Text(dish.italianName, style: AppTextStyles.italic)
                      .animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Text('\$${dish.price.toInt()}', style: AppTextStyles.price),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.trattoriaRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(dish.regionEmoji, style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 6),
                            Text(dish.region, style: AppTextStyles.labelMedium.copyWith(color: AppColors.trattoriaRed)),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 250.ms),

                  const Divider(height: 32),

                  const _SectionLabel('The Story'),
                  const SizedBox(height: 8),
                  Text(dish.story, style: AppTextStyles.bodyLarge)
                      .animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 24),

                  const _SectionLabel('Ingredients'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: dish.ingredients.map((ing) => Chip(
                      label: Text(ing, style: AppTextStyles.bodySmall.copyWith(color: AppColors.espressoBrown)),
                      backgroundColor: AppColors.warmCream,
                      side: const BorderSide(color: AppColors.divider),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    )).toList(),
                  ).animate().fadeIn(delay: 350.ms),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.goldenYellow.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.goldenYellow.withOpacity(0.4)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🍷', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Wine Pairing', style: AppTextStyles.headlineSmall.copyWith(color: AppColors.goldenYellowDark)),
                              const SizedBox(height: 4),
                              Text(dish.pairingSuggestion, style: AppTextStyles.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => UrlLauncherService.openToast(context),
                      icon: const Icon(Icons.delivery_dining),
                      label: const Text('Order This Dish'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: AppTextStyles.category.copyWith(fontSize: 12, letterSpacing: 2));
  }
}
