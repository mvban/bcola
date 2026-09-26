import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/constants/app_strings.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Prenota un Tavolo', style: AppTextStyles.displaySmallOnDark),
            backgroundColor: AppColors.trattoriaRed,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.trattoriaRedDark, AppColors.trattoriaRed],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text('🍷', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text('Make a Reservation', style: AppTextStyles.displayMedium.copyWith(color: AppColors.warmCream)),
                        const SizedBox(height: 8),
                        Text(
                          'We use Resy for all table reservations. Please note our 15-minute grace period.',
                          style: AppTextStyles.tagline,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _launch(AppStrings.resyUrl),
                            icon: const Icon(Icons.calendar_today),
                            label: const Text('Reserve on Resy'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.goldenYellow,
                              foregroundColor: AppColors.espressoBrown,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2),

                  const SizedBox(height: 24),

                  Text('Hours', style: AppTextStyles.headlineLarge),
                  const SizedBox(height: 12),
                  _HourRow('Mon – Thu', AppStrings.hoursMonThu),
                  _HourRow('Friday', AppStrings.hoursFri),
                  _HourRow('Saturday', AppStrings.hoursSat),
                  _HourRow('Sunday', AppStrings.hoursSun),

                  const SizedBox(height: 24),

                  Text('Getting Here', style: AppTextStyles.headlineLarge),
                  const SizedBox(height: 12),
                  _LocationCard(onLaunch: _launch),

                  const SizedBox(height: 24),

                  Text('Order for Delivery', style: AppTextStyles.headlineLarge),
                  const SizedBox(height: 12),

                  _DeliveryRow('Toast (Pickup & Delivery)', Icons.storefront, AppColors.trattoriaRed, AppStrings.toastUrl, _launch),
                  const SizedBox(height: 8),
                  _DeliveryRow('DoorDash', Icons.delivery_dining, Colors.red.shade700, AppStrings.doorDashUrl, _launch),
                  const SizedBox(height: 8),
                  _DeliveryRow('Uber Eats', Icons.electric_scooter, Colors.green.shade700, AppStrings.uberEatsUrl, _launch),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HourRow extends StatelessWidget {
  final String day;
  final String hours;
  const _HourRow(this.day, this.hours);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(day, style: AppTextStyles.labelLarge)),
          Text(hours, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final Future<void> Function(String) onLaunch;
  const _LocationCard({required this.onLaunch});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onLaunch(AppStrings.mapsUrl),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: AppColors.trattoriaRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.map_outlined, color: AppColors.trattoriaRed),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.restaurantAddress, style: AppTextStyles.headlineSmall),
                  Text('Crown Heights, Brooklyn · Tap for directions', style: AppTextStyles.bodySmall),
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

class _DeliveryRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final String url;
  final Future<void> Function(String) onLaunch;

  const _DeliveryRow(this.label, this.icon, this.color, this.url, this.onLaunch);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onLaunch(url),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 6)],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Text(label, style: AppTextStyles.headlineSmall.copyWith(color: color)),
            const Spacer(),
            const Icon(Icons.open_in_new, size: 14, color: AppColors.warmWood),
          ],
        ),
      ),
    );
  }
}
