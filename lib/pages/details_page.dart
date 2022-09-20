import 'package:crypto_coins_tracker_flutter/components/card_with_title_and_detail.dart';
import 'package:crypto_coins_tracker_flutter/components/price_chart_card.dart';
import 'package:crypto_coins_tracker_flutter/models/crypto_coin.dart';
import 'package:crypto_coins_tracker_flutter/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Consumer<MarketProvider>(
            builder: (context, value, child) {
              final CryptoCoin currentCryptoCoin = value.getCoinDetails(id);
              return RefreshIndicator(
                onRefresh: () async {
                  await value.fetchData();
                },
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            // logo
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(currentCryptoCoin.image!),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // title and subtitle
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentCryptoCoin.name!,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                    overflow: TextOverflow.fade,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),
                                Text(
                                  currentCryptoCoin.symbol!.toUpperCase(),
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                          ),
                          // Coin details
                          child: Column(
                            children: [
                              // title
                              const Text(
                                "Coin details",
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                // price information
                                children: [
                                  // current price
                                  Row(
                                    children: [
                                      const SizedBox(width: 4),
                                      Text(
                                        "Price:",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "₹${currentCryptoCoin.currentPrice!.toString()}",
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // price change in 24 hours
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // title
                                            Text(
                                              "Price change 24 hrs",
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            // detail
                                            Text(
                                              "₹${currentCryptoCoin.priceChange24h!.toString()}",
                                              style: TextStyle(
                                                color: currentCryptoCoin
                                                            .priceChange24h! <
                                                        0
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // price change in 24 hours by percentage
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // title
                                            Text(
                                              "Price change %",
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            // detail
                                            Text(
                                              "${currentCryptoCoin.priceChangePercentage24h!.toString()}%",
                                              style: TextStyle(
                                                color: currentCryptoCoin
                                                            .priceChange24h! <
                                                        0
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                              // price change chart
                              PriceChartCard(coinId: id),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // market information
                                children: [
                                  // current market cap
                                  CardWithTitleAndDetail(
                                    title: "Market cap",
                                    detail:
                                        "₹${currentCryptoCoin.marketCap!.toString()}",
                                    side: "left",
                                  ),

                                  // market cap rank
                                  CardWithTitleAndDetail(
                                    title: "Market cap rank",
                                    detail: currentCryptoCoin.marketCapRank!
                                        .toString(),
                                    side: "right",
                                  ),
                                ],
                              ),
                              const Divider(),
                              Column(
                                children: [
                                  // low and high information
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // low in 24 hours
                                      CardWithTitleAndDetail(
                                        title: "Low in 24 hrs",
                                        detail:
                                            "₹${currentCryptoCoin.low24h!.toString()}",
                                        side: "left",
                                      ),
                                      // high in 24 hours
                                      CardWithTitleAndDetail(
                                        title: "High in 24 hrs",
                                        detail:
                                            "₹${currentCryptoCoin.high24h!.toString()}",
                                        side: "right",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // all time low
                                      CardWithTitleAndDetail(
                                        title: "All time low",
                                        detail:
                                            currentCryptoCoin.atl!.toString(),
                                        side: "left",
                                      ),

                                      // all time high
                                      CardWithTitleAndDetail(
                                        title: "All time high",
                                        detail:
                                            currentCryptoCoin.ath!.toString(),
                                        side: "right",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                // supply information
                                children: [
                                  // circulating supply
                                  CardWithTitleAndDetail(
                                    title: "Circulating supply",
                                    detail: currentCryptoCoin.circulatingSupply!
                                        .toString(),
                                    side: "left",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
