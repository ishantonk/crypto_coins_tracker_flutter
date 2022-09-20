import 'package:crypto_coins_tracker_flutter/constants/themes.dart';
import 'package:crypto_coins_tracker_flutter/models/local_storage.dart';
import 'package:crypto_coins_tracker_flutter/pages/home_page.dart';
import 'package:crypto_coins_tracker_flutter/providers/market_provider.dart';
import 'package:crypto_coins_tracker_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentThemeMode = await LocalStorage.getTheme() ?? 'system';
  runApp(MyApp(themeMode: currentThemeMode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeMode});

  final String themeMode;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),

        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(themeMode),
        )

        //  More providers
      ],
      child: Consumer<ThemeProvider>(
        builder: ((context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: value.currentThemeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const HomePage(),
          );
        }),
      ),
    );
  }
}
