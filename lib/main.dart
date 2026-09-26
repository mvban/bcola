import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/theme/app_theme.dart';
import 'app/routes/app_router.dart';
import 'providers/menu_provider.dart';
import 'providers/wine_provider.dart';
import 'providers/game_provider.dart';
import 'providers/event_provider.dart';

void main() {
  runApp(const BriscolaApp());
}

class BriscolaApp extends StatelessWidget {
  const BriscolaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => WineProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp.router(
        title: 'Briscola Trattoria',
        theme: AppTheme.theme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
