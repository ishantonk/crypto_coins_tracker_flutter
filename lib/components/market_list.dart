import 'package:crypto_coins_tracker_flutter/components/crypto_coin_tile.dart';
import 'package:crypto_coins_tracker_flutter/models/crypto_coin.dart';
import 'package:crypto_coins_tracker_flutter/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketList extends StatelessWidget {
  const MarketList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, value, child) {
        if (value.isLoading == true) {
          // Data is loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Data is loaded
          if (value.markets.isNotEmpty) {
            // Data found
            return RefreshIndicator(
              onRefresh: () async {
                await value.fetchData();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: value.markets.length,
                itemBuilder: (context, index) {
                  CryptoCoin currentCryptoCoin = value.markets[index];
                  return CryptoCoinTile(currentCryptoCoin: currentCryptoCoin);
                },
              ),
            );
          } else {
            // No data found
            return Center(
              child: Text(
                "No data found",
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
