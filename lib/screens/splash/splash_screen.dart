import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: SafeArea(
        child: Stack(
          children: [
            // Centered Logo & Tagline
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/app_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 400.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.0, 1.0),
                        delay: 200.ms,
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      ),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    'Briscola',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: AppColors.trattoriaRed,
                      letterSpacing: -0.5,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 400.ms)
                      .slideY(begin: 0.2, end: 0.0),
                  Text(
                    'TRATTORIA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.warmWood,
                      letterSpacing: 6,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 400.ms),
                  const SizedBox(height: 16),
                  // Tagline
                  Text(
                    '“Old-school charm. Modern twist.”',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: AppColors.espressoBrown,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 400.ms)
                      .slideY(begin: 0.2, end: 0.0),
                ],
              ),
            ),

            // Accent: Small Denari (coin) suit icon at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.trattoriaRed,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.monetization_on,
                          color: AppColors.goldenYellow,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Crown Heights · Brooklyn',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.warmWood.withOpacity(0.8),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 400.ms)
                  .slideY(begin: 0.3, end: 0.0),
            ),
          ],
        ),
      ),
    );
  }
}
