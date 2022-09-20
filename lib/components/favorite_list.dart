import 'package:crypto_coins_tracker_flutter/components/crypto_coin_tile.dart';
import 'package:crypto_coins_tracker_flutter/models/crypto_coin.dart';
import 'package:crypto_coins_tracker_flutter/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, value, child) {
        List<CryptoCoin> favCoins =
            value.markets.where((coin) => coin.isFavorite == true).toList();

        if (value.isLoading == true) {
          // Data is loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Data is loaded
          if (favCoins.isNotEmpty) {
            // Data found

            return RefreshIndicator(
              onRefresh: () async {
                await value.fetchData();
              },
              child: ListView.builder(
                itemCount: favCoins.length,
                itemBuilder: (context, index) {
                  CryptoCoin coin = favCoins[index];

                  return CryptoCoinTile(currentCryptoCoin: coin);
                },
              ),
            );
          } else {
            // No data found
            return Center(
              child: Text(
                "No favorites found",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
