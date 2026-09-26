import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/theme/app_colors.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/menu')) return 1;
    if (location.startsWith('/wine')) return 2;
    if (location.startsWith('/dessert')) return 3;
    if (location.startsWith('/events')) return 4;
    if (location.startsWith('/reservations')) return 5;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _getIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.softWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                  index: 0,
                  currentIndex: index,
                  onTap: () => context.go('/home'),
                ),
                _NavItem(
                  icon: Icons.restaurant_menu_outlined,
                  activeIcon: Icons.restaurant_menu,
                  label: 'Menu',
                  index: 1,
                  currentIndex: index,
                  onTap: () => context.go('/menu'),
                ),
                _NavItem(
                  icon: Icons.wine_bar_outlined,
                  activeIcon: Icons.wine_bar,
                  label: 'Wines',
                  index: 2,
                  currentIndex: index,
                  onTap: () => context.go('/wine'),
                ),
                _NavItem(
                  icon: Icons.cake_outlined,
                  activeIcon: Icons.cake,
                  label: 'Dolci',
                  index: 3,
                  currentIndex: index,
                  onTap: () => context.go('/dessert'),
                ),
                _NavItem(
                  icon: Icons.event_outlined,
                  activeIcon: Icons.event,
                  label: 'Events',
                  index: 4,
                  currentIndex: index,
                  onTap: () => context.go('/events'),
                ),
                _NavItem(
                  icon: Icons.table_restaurant_outlined,
                  activeIcon: Icons.table_restaurant,
                  label: 'Reserve',
                  index: 5,
                  currentIndex: index,
                  onTap: () => context.go('/reservations'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.trattoriaRed.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.trattoriaRed : AppColors.warmWood,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.trattoriaRed : AppColors.warmWood,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
