import 'package:crypto_coins_tracker_flutter/models/price_chart_data_item.dart';
import 'package:crypto_coins_tracker_flutter/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceChartCard extends StatefulWidget {
  const PriceChartCard({
    Key? key,
    required this.coinId,
  }) : super(key: key);

  @override
  State<PriceChartCard> createState() => _PriceChartCardState();
  final String coinId;
}

class _PriceChartCardState extends State<PriceChartCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, value, child) {
        final List<PriceChartDataItem> priceChangeData = value.priceChartData;
        return Column(
          children: [
            // chart title
            Text(
              "Change in price this week",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SfCartesianChart(
              enableAxisAnimation: true,
              primaryXAxis: CategoryAxis(),
              palette: [value.priceChartLineColor],
              series: <ChartSeries>[
                LineSeries<PriceChartDataItem, String>(
                  dataSource: priceChangeData,
                  xValueMapper: (PriceChartDataItem price, _) => price.day,
                  yValueMapper: (PriceChartDataItem price, _) => price.price,
                  // show maker on price change points
                  markerSettings: const MarkerSettings(isVisible: true),
                  // show the price in the chart
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
