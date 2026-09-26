import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/menu/menu_screen.dart';
import '../../screens/menu/dish_detail_screen.dart';
import '../../screens/wine_cocktails/wine_list_screen.dart';
import '../../screens/wine_cocktails/wine_detail_screen.dart';
import '../../screens/dessert_cart/dessert_cart_screen.dart';
import '../../screens/events/events_screen.dart';
import '../../screens/events/event_detail_screen.dart';
import '../../screens/reservations/reservation_screen.dart';
import '../../widgets/main_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/menu',
          builder: (context, state) => const MenuScreen(),
          routes: [
            GoRoute(
              path: 'dish/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return DishDetailScreen(dishId: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/wine',
          builder: (context, state) => const WineListScreen(),
          routes: [
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return WineDetailScreen(wineId: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/dessert',
          builder: (context, state) => const DessertCartScreen(),
        ),
        GoRoute(
          path: '/events',
          builder: (context, state) => const EventsScreen(),
          routes: [
            GoRoute(
              path: 'detail/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return EventDetailScreen(eventId: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/reservations',
          builder: (context, state) => const ReservationScreen(),
        ),
      ],
    ),
  ],
);
