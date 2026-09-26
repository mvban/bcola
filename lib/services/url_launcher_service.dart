import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/app_text_styles.dart';

class UrlLauncherService {
  UrlLauncherService._();

  static const String resyPackage = 'com.resy.android.prod';
  static const String toastPackage = 'com.toasttab.consumer';

  /// Generic external link launcher with fallback error handling
  static Future<void> openUrl(BuildContext context, String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        final fallbackLaunched = await launchUrl(uri, mode: LaunchMode.platformDefault);
        if (!fallbackLaunched && context.mounted) {
          _showErrorSnackBar(context, 'Could not open link in browser');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Could not open link: $e');
      }
    }
  }

  /// Phone call dialer launcher
  static Future<void> makeCall(BuildContext context, String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(scheme: 'tel', path: cleanPhone);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        _showErrorSnackBar(context, 'Unable to open phone dialer');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Unable to open phone dialer: $e');
      }
    }
  }

  /// Mail app launcher
  static Future<void> sendEmail(BuildContext context, String email, {String? subject}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: subject != null ? {'subject': subject} : null,
    );
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        _showErrorSnackBar(context, 'Unable to open email client');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Unable to open email client: $e');
      }
    }
  }

  /// Directions / Map launcher
  static Future<void> openDirections(BuildContext context, String address) async {
    final encoded = Uri.encodeComponent(address);
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$encoded';
    await openUrl(context, googleMapsUrl);
  }

  /// Resy App Launcher with Play Store & Browser Fallback Modal
  static Future<void> openResy(
    BuildContext context, {
    String webUrl = 'https://resy.com/cities/new-york-ny/venues/briscola-trattoria',
  }) async {
    // Show option modal to launch via app / Play Store or web browser
    await _showAppLaunchModal(
      context: context,
      appName: 'Resy',
      appIcon: Icons.calendar_month,
      accentColor: AppColors.trattoriaRed,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=$resyPackage',
      webUrl: webUrl,
      appScheme: 'resy://',
      packageName: resyPackage,
    );
  }

  /// Toast App Launcher with Play Store & Browser Fallback Modal
  static Future<void> openToast(
    BuildContext context, {
    String webUrl = 'https://order.toasttab.com/online/briscola-trattoria-798a-franklin-avenue',
  }) async {
    await _showAppLaunchModal(
      context: context,
      appName: 'Toast Takeout',
      appIcon: Icons.restaurant,
      accentColor: AppColors.goldenYellowDark,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=$toastPackage',
      webUrl: webUrl,
      appScheme: 'toasttab://',
      packageName: toastPackage,
    );
  }

  static Future<void> _showAppLaunchModal({
    required BuildContext context,
    required String appName,
    required IconData appIcon,
    required Color accentColor,
    required String playStoreUrl,
    required String webUrl,
    required String appScheme,
    required String packageName,
  }) async {
    // Try direct native app launch first if possible
    final appUri = Uri.parse(appScheme);
    if (await canLaunchUrl(appUri)) {
      final launched = await launchUrl(appUri, mode: LaunchMode.externalNonBrowserApplication);
      if (launched) return;
    }

    if (!context.mounted) return;

    // Show modal with clear options: Open App / Play Store OR Open Web
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.warmCream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.warmWood.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(appIcon, color: accentColor, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Open $appName',
                          style: AppTextStyles.headlineMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Choose how you would like to proceed:',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Option 1: Native App / Play Store
              ElevatedButton.icon(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  final marketUri = Uri.parse('market://details?id=$packageName');
                  if (await canLaunchUrl(marketUri)) {
                    await launchUrl(marketUri, mode: LaunchMode.externalApplication);
                  } else if (context.mounted) {
                    await openUrl(context, playStoreUrl);
                  }
                },
                icon: const Icon(Icons.android),
                label: Text('Open or Install $appName App'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              // Option 2: Web Browser
              OutlinedButton.icon(
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  if (context.mounted) {
                    await openUrl(context, webUrl);
                  }
                },
                icon: const Icon(Icons.language),
                label: const Text('Open in Web Browser'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.espressoBrown,
                  side: const BorderSide(color: AppColors.warmWoodLight),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
