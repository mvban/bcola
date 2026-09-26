import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../providers/menu_provider.dart';
import '../../models/dish.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            leading: context.canPop()
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.warmCream),
                    onPressed: () => context.pop(),
                  )
                : null,
            title: Text('Il Menu', style: AppTextStyles.displaySmallOnDark),
            backgroundColor: AppColors.trattoriaRed,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: _CategoryFilter(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: Consumer<MenuProvider>(
              builder: (context, menu, _) {
                final dishes = menu.filteredDishes;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      if (index == 0 && menu.selectedCategory == 'Tutti') {
                        return _RegionalMapBanner();
                      }
                      final dishIndex = menu.selectedCategory == 'Tutti' ? index - 1 : index;
                      if (dishIndex < 0 || dishIndex >= dishes.length) return null;
                      final dish = dishes[dishIndex];
                      return _DishCard(dish: dish)
                          .animate()
                          .fadeIn(delay: (dishIndex * 80).ms)
                          .slideX(begin: 0.1);
                    },
                    childCount: dishes.length + (menu.selectedCategory == 'Tutti' ? 1 : 0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menu, _) {
        return Container(
          color: AppColors.trattoriaRed,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: menu.categories.map((cat) {
                final isSelected = menu.selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () => menu.setCategory(cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.goldenYellow : Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: isSelected ? AppColors.espressoBrown : AppColors.warmCream,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _RegionalMapBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.trattoriaRedDark, AppColors.trattoriaRed],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('🇮🇹', style: TextStyle(fontSize: 36)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A Journey Across Italy', style: AppTextStyles.headlineLarge.copyWith(color: AppColors.warmCream)),
                const SizedBox(height: 4),
                Text('Every dish traces back to a specific Italian region. Tap any dish to discover its story.', style: AppTextStyles.bodySmall.copyWith(color: AppColors.warmCreamDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DishCard extends StatelessWidget {
  final Dish dish;
  const _DishCard({required this.dish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/menu/dish/${dish.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: AppColors.trattoriaRed.withOpacity(0.08),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(dish.emoji, style: const TextStyle(fontSize: 40)),
                  const SizedBox(height: 8),
                  if (dish.isSignature)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.goldenYellow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('★', style: TextStyle(fontSize: 10, color: AppColors.espressoBrown)),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(dish.category.toUpperCase(), style: AppTextStyles.category),
                        const Spacer(),
                        Text(dish.regionEmoji),
                        const SizedBox(width: 4),
                        Text(dish.region, style: AppTextStyles.bodySmall.copyWith(fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(dish.name, style: AppTextStyles.headlineMedium),
                    Text(dish.italianName, style: AppTextStyles.italic.copyWith(fontSize: 12)),
                    const SizedBox(height: 6),
                    Text(dish.description, style: AppTextStyles.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('\$${dish.price.toInt()}', style: AppTextStyles.priceSmall),
                        const Spacer(),
                        Row(
                          children: [
                            Text('Story', style: AppTextStyles.bodySmall.copyWith(color: AppColors.trattoriaRed, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.trattoriaRed),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
