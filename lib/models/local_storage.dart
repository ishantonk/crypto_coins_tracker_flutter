import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> storeTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString('theme', theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currentThemeMode = sharedPreferences.getString('theme');
    return currentThemeMode;
  }

  static Future<List<String>> fetchFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // get favorites list from sharedPreferences
    List<String> favorites = sharedPreferences.getStringList('favorites') ?? [];
    return favorites;
  }

  static Future<bool> addFavorite(String coinId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList('favorites') ?? [];
    // adding a new favorite
    favorites.add(coinId);

    return await sharedPreferences.setStringList("favorites", favorites);
  }

  static Future<bool> removeFavorite(String coinId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList('favorites') ?? [];
    // adding a new favorite
    favorites.remove(coinId);

    return await sharedPreferences.setStringList("favorites", favorites);
  }
}
