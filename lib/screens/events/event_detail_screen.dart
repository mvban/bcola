import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/constants/app_strings.dart';
import '../../providers/event_provider.dart';
import '../../models/event.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventId;
  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<EventProvider>();
    final event = provider.events.firstWhere(
      (e) => e.id == eventId,
      orElse: () => provider.events.first,
    );

    final color = _typeColor(event.type);

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
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
                    colors: [color.withOpacity(0.8), color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Text(event.emoji, style: const TextStyle(fontSize: 64))
                          .animate().scale(begin: const Offset(0, 0)).fadeIn(),
                      Text(event.type.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.w600)),
                    ],
                  ),
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
                  Text(event.title, style: AppTextStyles.displayMedium).animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.people_outline, size: 16, color: AppColors.warmWood),
                      const SizedBox(width: 6),
                      Text(event.capacity, style: AppTextStyles.bodyMedium),
                      const SizedBox(width: 16),
                      Icon(Icons.attach_money, size: 16, color: color),
                      Text(event.priceRange, style: AppTextStyles.bodyMedium.copyWith(color: color, fontWeight: FontWeight.w600)),
                    ],
                  ).animate().fadeIn(delay: 150.ms),

                  const Divider(height: 32),

                  Text('About', style: AppTextStyles.category.copyWith(letterSpacing: 2)),
                  const SizedBox(height: 8),
                  Text(event.description, style: AppTextStyles.bodyLarge).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 24),

                  Text('What\'s Included', style: AppTextStyles.category.copyWith(letterSpacing: 2)),
                  const SizedBox(height: 12),
                  ...event.features.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.check, size: 13, color: color),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(entry.value, style: AppTextStyles.bodyMedium)),
                      ],
                    ),
                  ).animate().fadeIn(delay: (250 + entry.key * 50).ms).slideX(begin: 0.1)),

                  const SizedBox(height: 32),

                  // CTA buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse(AppStrings.resyUrl);
                        if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(Icons.calendar_today, size: 18),
                      label: const Text('Book via Resy'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse(AppStrings.emailMailto);
                        if (await canLaunchUrl(uri)) await launchUrl(uri);
                      },
                      icon: const Icon(Icons.email_outlined, size: 18),
                      label: const Text('Send Inquiry'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: color,
                        side: BorderSide(color: color),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ).animate().fadeIn(delay: 550.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'private': return AppColors.trattoriaRed;
      case 'family': return AppColors.warmWood;
      case 'catering': return AppColors.goldenYellowDark;
      default: return AppColors.warmWood;
    }
  }
}
