import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/constants/app_strings.dart';
import '../../providers/event_provider.dart';
import '../../models/event.dart';
import '../../services/url_launcher_service.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

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
            title: Text('Eventi & Catering', style: AppTextStyles.displaySmallOnDark),
            backgroundColor: AppColors.trattoriaRed,
          ),
          SliverToBoxAdapter(child: _ReservationBanner()),
          Consumer<EventProvider>(
            builder: (context, provider, _) {
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) => _EventCard(event: provider.events[index])
                        .animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1),
                    childCount: provider.events.length,
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(child: _ContactCTA()),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _ReservationBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.espressoBrown, Color(0xFF5D4037)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🍽️', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Text('Reserve Your Table', style: AppTextStyles.headlineLarge.copyWith(color: AppColors.goldenYellow)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Book via Resy. Please note our 15-minute grace period policy.',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.warmCreamDark),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => UrlLauncherService.openResy(context),
              icon: const Icon(Icons.calendar_today, size: 16),
              label: const Text('Book on Resy'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldenYellow,
                foregroundColor: AppColors.espressoBrown,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}

class _EventCard extends StatelessWidget {
  final Event event;
  const _EventCard({required this.event});

  Color get _typeColor {
    switch (event.type) {
      case 'private': return AppColors.trattoriaRed;
      case 'family': return AppColors.warmWood;
      case 'catering': return AppColors.goldenYellowDark;
      default: return AppColors.warmWood;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/events/detail/${event.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _typeColor.withOpacity(0.08),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Text(event.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.type.toUpperCase(), style: AppTextStyles.category.copyWith(color: _typeColor)),
                        Text(event.title, style: AppTextStyles.headlineMedium),
                        Text(event.capacity, style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(event.priceRange, style: AppTextStyles.priceSmall.copyWith(fontSize: 13)),
                      const SizedBox(height: 4),
                      const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.warmWood),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(event.description, style: AppTextStyles.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            const Text('👥', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 12),
            Text('Groups of 7 or More?', style: AppTextStyles.headlineLarge),
            const SizedBox(height: 8),
            Text(
              'For large parties and custom events, reach out directly to our team.',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => UrlLauncherService.makeCall(context, AppStrings.restaurantPhone),
                    icon: const Icon(Icons.phone, size: 16),
                    label: const Text('Call'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => UrlLauncherService.sendEmail(context, AppStrings.restaurantEmail, subject: 'Event Inquiry'),
                    icon: const Icon(Icons.email, size: 16),
                    label: const Text('Email'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}
