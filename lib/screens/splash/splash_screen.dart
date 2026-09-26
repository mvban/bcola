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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache logo image for instant rendering
    precacheImage(const AssetImage('assets/icons/app_icon.png'), context);
  }

  Future<void> _navigateToHome() async {
    // Crisp & fast splash screen duration (1.2s total)
    await Future.delayed(const Duration(milliseconds: 1200));
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
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withOpacity(0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
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
                      .fadeIn(duration: 300.ms)
                      .scale(
                        begin: const Offset(0.85, 0.85),
                        end: const Offset(1.0, 1.0),
                        duration: 400.ms,
                        curve: Curves.easeOutBack,
                      ),
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    'Briscola',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.trattoriaRed,
                      letterSpacing: -0.5,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 150.ms, duration: 300.ms)
                      .slideY(begin: 0.15, end: 0.0),
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
                      .fadeIn(delay: 250.ms, duration: 300.ms),
                  const SizedBox(height: 14),
                  // Tagline
                  Text(
                    '“Old-school charm. Modern twist.”',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: AppColors.espressoBrown,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 350.ms, duration: 300.ms)
                      .slideY(begin: 0.15, end: 0.0),
                ],
              ),
            ),

            // Accent at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.trattoriaRed,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.monetization_on,
                          color: AppColors.goldenYellow,
                          size: 18,
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
                  .fadeIn(delay: 450.ms, duration: 300.ms),
            ),
          ],
        ),
      ),
    );
  }
}
