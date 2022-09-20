import 'dart:async';

import 'package:crypto_coins_tracker_flutter/apis/coin_gec_ko_api.dart';
import 'package:crypto_coins_tracker_flutter/models/crypto_coin.dart';
import 'package:crypto_coins_tracker_flutter/models/local_storage.dart';
import 'package:crypto_coins_tracker_flutter/models/price_chart_data_item.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCoin> markets = [];
  List<PriceChartDataItem> priceChartData = [];
  Color priceChartLineColor = Colors.black;

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> data = await CoinGecKoApi.getMarkets();

    List<String> favorites = await LocalStorage.fetchFavorites();

    List<CryptoCoin> result = [];
    for (var market in data) {
      CryptoCoin newCryptoCoin = CryptoCoin.fromJSON(market);

      // check whether this coin id present in favorites list
      if (favorites.contains(newCryptoCoin.id)) {
        newCryptoCoin.isFavorite = true;
      }
      result.add(newCryptoCoin);
    }

    isLoading = false;
    markets = result;
    notifyListeners();

    // Make sure the api will update in every 3 seconds
    // Timer(const Duration(seconds: 3), () => fetchData());
  }

  CryptoCoin getCoinDetails(String id) {
    final CryptoCoin coinDetails =
        markets.where((element) => element.id == id).toList()[0];
    return coinDetails;
  }

  void addFavorite(CryptoCoin coin) async {
    int coinIdx = markets.indexOf(coin);
    markets[coinIdx].isFavorite = true;
    await LocalStorage.addFavorite(coin.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCoin coin) async {
    int coinIdx = markets.indexOf(coin);
    markets[coinIdx].isFavorite = false;
    await LocalStorage.removeFavorite(coin.id!);
    notifyListeners();
  }

  Future<void> getPriceChart(String coinId) async {
    // get price change data in [[int date in timestamp, int price], [int, int], ...[int, int]]
    final List data = await CoinGecKoApi.getPriceChart(coinId);
    final List<PriceChartDataItem> result = [];

    for (List element in data) {
      final DateTime date = DateTime.fromMillisecondsSinceEpoch(element[0]);
      final String day = convertToDayName(date.weekday);
      final double price = element[1];
      // add to result list
      result.add(PriceChartDataItem(day, price));
    }
    priceChartData = result;
    priceChartLineColor = getPriceChartLineColor(priceChartData);
    notifyListeners();
  }
}

Color getPriceChartLineColor(List<PriceChartDataItem> priceChartData) {
  final PriceChartDataItem latestPriceChangeData =
      priceChartData.elementAt(priceChartData.length - 1);
  final PriceChartDataItem yesterdayPriceChangeData =
      priceChartData.elementAt(priceChartData.length - 2);

  double priceDifference =
      latestPriceChangeData.price - yesterdayPriceChangeData.price;

  if (priceDifference > 0) {
    // for increments in price of currency
    return Colors.green;
  } else if (priceDifference < 0) {
    // for decrements in price of currency
    return Colors.red;
  } else {
    // for no change in price of currency
    return Colors.yellow;
  }
}

String convertToDayName(int day) {
  late String dayName;
  switch (day) {
    case 1:
      dayName = "Mon";
      break;
    case 2:
      dayName = "Tus";
      break;
    case 3:
      dayName = "Wed";
      break;
    case 4:
      dayName = "Thu";
      break;
    case 5:
      dayName = "Fri";
      break;
    case 6:
      dayName = "Sat";
      break;
    case 7:
      dayName = "Sun";
      break;
    default:
  }
  return dayName;
}
