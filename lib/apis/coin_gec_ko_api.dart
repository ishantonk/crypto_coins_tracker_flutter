import 'dart:convert';

import 'package:http/http.dart' as http;

class CoinGecKoApi {
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri requestUri = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=50&page=1&sparkline=false");

      var response = await http.get(requestUri);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch (e) {
      return [];
    }
  }

  static Future<List> getPriceChart(String coinId) async {
    try {
      Uri requestUri = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=inr&days=7&interval=daily");

      var response = await http.get(requestUri);
      var decodedResponse = jsonDecode(response.body);

      List priceChart = decodedResponse['prices'];
      return priceChart;
    } catch (e) {
      return [];
    }
  }
}
