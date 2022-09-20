import 'package:crypto_coins_tracker_flutter/models/crypto_coin.dart';
import 'package:crypto_coins_tracker_flutter/pages/details_page.dart';
import 'package:crypto_coins_tracker_flutter/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({Key? key, required this.currentCryptoCoin})
      : super(key: key);

  final CryptoCoin currentCryptoCoin;

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, value, child) {
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          value.getPriceChart(currentCryptoCoin.id!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(id: currentCryptoCoin.id!),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // leading icon
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 4, bottom: 4, right: 4, left: 0),
                  child: Row(
                    children: [
                      // favorite switch
                      currentCryptoCoin.isFavorite == false
                          ? InkWell(
                              onTap: () {
                                value.addFavorite(currentCryptoCoin);
                              },
                              child: const Icon(
                                Icons.favorite_border_rounded,
                                size: 28,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                value.removeFavorite(currentCryptoCoin);
                              },
                              child: const Icon(
                                Icons.favorite_rounded,
                                size: 28,
                                color: Colors.red,
                              ),
                            ),
                      const SizedBox(width: 8),
                      // logo
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(currentCryptoCoin.image!),
                      ),
                    ],
                  ),
                ),
              ),

              // title and subtitle
              Container(
                width: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      currentCryptoCoin.name!,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    // subtitle
                    Text(
                      currentCryptoCoin.symbol!.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // details
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${currentCryptoCoin.currentPrice!.toString()}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Builder(builder: (context) {
                    double priceChange = currentCryptoCoin.priceChange24h!;
                    double priceChangePercentage =
                        currentCryptoCoin.priceChangePercentage24h!;
                    if (priceChange < 0) {
                      // Navigate
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${priceChangePercentage.toStringAsFixed(2)}%",
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            priceChange.toStringAsFixed(4),
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Positive
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "+${priceChangePercentage.toStringAsFixed(2)}%",
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "+${priceChange.toStringAsFixed(4)}",
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }
                  })
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
