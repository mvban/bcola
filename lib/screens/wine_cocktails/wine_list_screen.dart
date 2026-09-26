import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../providers/wine_provider.dart';
import '../../models/wine.dart';

class WineListScreen extends StatefulWidget {
  const WineListScreen({super.key});

  @override
  State<WineListScreen> createState() => _WineListScreenState();
}

class _WineListScreenState extends State<WineListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            leading: context.canPop()
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.warmCream),
                    onPressed: () => context.pop(),
                  )
                : null,
            title: Text('Vini & Cocktails', style: AppTextStyles.displaySmallOnDark),
            backgroundColor: AppColors.trattoriaRed,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.goldenYellow,
              indicatorWeight: 3,
              labelColor: AppColors.goldenYellow,
              unselectedLabelColor: AppColors.warmCream.withOpacity(0.7),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              tabs: const [
                Tab(text: '🍷  Wine List'),
                Tab(text: '🍹  Cocktails'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _WinesTab(),
            _CocktailsTab(),
          ],
        ),
      ),
    );
  }
}

class _WinesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WineProvider>(
      builder: (context, provider, _) {
        final wines = provider.filteredWines;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _WineTypeFilter(),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) => _WineCard(wine: wines[index])
                      .animate().fadeIn(delay: (index * 70).ms).slideY(begin: 0.1),
                  childCount: wines.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _WineTypeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WineProvider>(
      builder: (context, provider, _) {
        return Container(
          color: AppColors.warmCream,
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: provider.types.map((type) {
                final isSelected = provider.selectedType == type;
                final emoji = {'All': '🍾', 'Red': '🍷', 'White': '🥂', 'Sparkling': '🫧', 'Rosé': '🌸'}[type] ?? '';
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => provider.setType(type),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.trattoriaRed : AppColors.softWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppColors.trattoriaRed : AppColors.divider),
                      ),
                      child: Text(
                        '$emoji $type',
                        style: TextStyle(
                          color: isSelected ? AppColors.warmCream : AppColors.espressoBrown,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
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

class _WineCard extends StatelessWidget {
  final Wine wine;
  const _WineCard({required this.wine});

  Color get _typeColor {
    switch (wine.type) {
      case 'red': return AppColors.trattoriaRed;
      case 'white': return AppColors.goldenYellowDark;
      case 'sparkling': return const Color(0xFF1565C0);
      case 'rosé': return const Color(0xFFE91E63);
      default: return AppColors.warmWood;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/wine/detail/${wine.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _typeColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(wine.emoji, style: const TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(wine.type.toUpperCase(), style: AppTextStyles.category.copyWith(color: _typeColor)),
                      const Spacer(),
                      Text(wine.vintage, style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(wine.name, style: AppTextStyles.headlineMedium),
                  Text('${wine.producer} · ${wine.region}', style: AppTextStyles.bodySmall),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _PriceTag('\$${wine.priceGlass.toInt()}', 'Glass'),
                      const SizedBox(width: 12),
                      _PriceTag('\$${wine.priceBottle.toInt()}', 'Bottle'),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.warmWood),
          ],
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final String price;
  final String label;
  const _PriceTag(this.price, this.label);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: price, style: AppTextStyles.priceSmall),
          TextSpan(text: ' /$label', style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _CocktailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WineProvider>(
      builder: (context, provider, _) {
        final cocktails = provider.cocktails;
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          itemCount: cocktails.length + 1,
          itemBuilder: (ctx, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.espressoBrown, Color(0xFF5D4037)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Text('🍹', style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Signature Cocktails', style: AppTextStyles.headlineLarge.copyWith(color: AppColors.goldenYellow)),
                            Text('Crafted with Italian spirits & aperitivi', style: AppTextStyles.bodySmall.copyWith(color: AppColors.warmCreamDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            final cocktail = cocktails[index - 1];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.softWhite,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cocktail.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(cocktail.name, style: AppTextStyles.headlineMedium)),
                            Text('\$${cocktail.price.toInt()}', style: AppTextStyles.priceSmall),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(cocktail.description, style: AppTextStyles.bodySmall, maxLines: 3, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: cocktail.ingredients.map((ing) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.warmCream,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(ing, style: AppTextStyles.labelSmall),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (index * 70).ms);
          },
        );
      },
    );
  }
}
