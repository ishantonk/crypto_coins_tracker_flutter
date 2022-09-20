import 'package:crypto_coins_tracker_flutter/models/local_storage.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode currentThemeMode;

  ThemeProvider(String theme) {
    if (theme == "system") {
      currentThemeMode = ThemeMode.system;
    } else if (theme == "light") {
      currentThemeMode = ThemeMode.light;
    } else {
      currentThemeMode = ThemeMode.dark;
    }
  }

  void changeTheme(changedThemeMode) async {
    if (changedThemeMode == "system") {
      // sync with phone theme
      currentThemeMode = ThemeMode.system;
      await LocalStorage.storeTheme('system');
    } else if (changedThemeMode == "light") {
      // changed to light theme
      currentThemeMode = ThemeMode.light;
      await LocalStorage.storeTheme('light');
    } else {
      // changed to dark theme
      currentThemeMode = ThemeMode.dark;
      await LocalStorage.storeTheme('dark');
    }

    notifyListeners();
  }
}
