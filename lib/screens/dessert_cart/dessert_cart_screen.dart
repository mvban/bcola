import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/constants/app_strings.dart';
import '../../providers/event_provider.dart';
import '../../models/event.dart';

class DessertCartScreen extends StatelessWidget {
  const DessertCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Il Carrello dei Dolci', style: AppTextStyles.displaySmallOnDark),
            backgroundColor: AppColors.trattoriaRed,
            actions: [
              Consumer<EventProvider>(
                builder: (context, provider, _) {
                  final count = provider.cartCount;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.warmCream),
                        onPressed: () => _showCart(context, provider),
                      ),
                      if (count > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: AppColors.goldenYellow,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text('$count', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.espressoBrown)),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _CartHeroBanner(),
          ),
          Consumer<EventProvider>(
            builder: (context, provider, _) {
              final desserts = provider.desserts;
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) => _DessertCard(
                      item: desserts[index],
                      onIncrement: () => provider.increment(desserts[index].id),
                      onDecrement: () => provider.decrement(desserts[index].id),
                    ).animate().fadeIn(delay: (index * 80).ms).scale(begin: const Offset(0.8, 0.8)),
                    childCount: desserts.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Consumer<EventProvider>(
        builder: (context, provider, _) {
          if (provider.cartCount == 0) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            onPressed: () => _showCart(context, provider),
            backgroundColor: AppColors.trattoriaRed,
            label: Text('View Cart · \$${provider.cartTotal.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
          ).animate().scale(begin: const Offset(0.5, 0.5)).fadeIn();
        },
      ),
    );
  }

  void _showCart(BuildContext context, EventProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _CartSheet(provider: provider),
    );
  }
}

class _CartHeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🍮', style: TextStyle(fontSize: 32)),
                SizedBox(height: 8),
                Text('The Dessert Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                SizedBox(height: 4),
                Text('Rolling tableside since opening night. Add items to pre-order with Toast.', style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}

class _DessertCard extends StatelessWidget {
  final DessertItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _DessertCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Emoji area
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF3E5F5),
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Center(
                child: Text(item.emoji, style: const TextStyle(fontSize: 52)),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.italianName, style: AppTextStyles.italic.copyWith(fontSize: 10)),
                Text(item.name, style: AppTextStyles.headlineSmall.copyWith(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('\$${item.price.toInt()}', style: AppTextStyles.priceSmall),
                    const Spacer(),
                    // Quantity control
                    if (item.quantity == 0)
                      GestureDetector(
                        onTap: onIncrement,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.trattoriaRed,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 14),
                        ),
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: onDecrement,
                            child: Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.divider,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.remove, size: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text('${item.quantity}', style: AppTextStyles.headlineSmall.copyWith(fontSize: 14)),
                          ),
                          GestureDetector(
                            onTap: onIncrement,
                            child: Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.trattoriaRed,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.add, size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartSheet extends StatelessWidget {
  final EventProvider provider;
  const _CartSheet({required this.provider});

  @override
  Widget build(BuildContext context) {
    final items = provider.desserts.where((d) => d.quantity > 0).toList();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Your Dessert Cart', style: AppTextStyles.headlineLarge),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
              ],
            ),
            const Divider(),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(item.emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(child: Text(item.name, style: AppTextStyles.headlineSmall)),
                  Text('×${item.quantity}', style: AppTextStyles.bodyMedium),
                  const SizedBox(width: 8),
                  Text('\$${(item.price * item.quantity).toInt()}', style: AppTextStyles.priceSmall),
                ],
              ),
            )),
            const Divider(),
            Row(
              children: [
                Text('Total', style: AppTextStyles.headlineMedium),
                const Spacer(),
                Text('\$${provider.cartTotal.toStringAsFixed(0)}', style: AppTextStyles.price),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final uri = Uri.parse(AppStrings.toastUrl);
                  if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Order via Toast'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                provider.clearCart();
                Navigator.of(context).pop();
              },
              child: const Text('Clear Cart', style: TextStyle(color: AppColors.warmWood)),
            ),
          ],
        ),
      ),
    );
  }
}
