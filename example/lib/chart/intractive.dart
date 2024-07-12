import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';
import './mock_data.dart';
class Intractive extends StatefulWidget {
  const Intractive({super.key});

  @override
  State<Intractive> createState() => _IntractiveState();
}

class _IntractiveState extends State<Intractive> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          minimum: const EdgeInsets.all(24.0),
          child: InteractiveChart(
            /** Only [candles] is required */
            candles: MockDataTesla.candles,
            
            style: ChartStyle(
              priceGainColor: Colors.teal[200]!,
              priceLossColor: Colors.blueGrey,
              volumeColor: Colors.teal.withOpacity(0.8),
              trendLineStyles: [
                Paint()
                  ..strokeWidth = 2.0
                  ..strokeCap = StrokeCap.round
                  ..color = Colors.deepOrange,
                Paint()
                  ..strokeWidth = 4.0
                  ..strokeCap = StrokeCap.round
                  ..color = Colors.orange,
              ],
              priceGridLineColor: Colors.blue[200]!,
              priceLabelStyle: TextStyle(color: Colors.blue[200]),
              timeLabelStyle: TextStyle(color: Colors.blue[200]),
              selectionHighlightColor: Colors.red.withOpacity(0.2),
              overlayBackgroundColor: Colors.red[900]!.withOpacity(0.6),
              overlayTextStyle: TextStyle(color: Colors.red[100]),
              timeLabelHeight: 32,
              volumeHeightFactor: 0.2, // volume area is 20% of total height
            ),
            
            timeLabel: (timestamp, visibleDataCount) => "📅",
            priceLabel: (price) => "${price.round()} 💎",
           
            overlayInfo: (candle) => {
              "💎": "🤚    ",
              "Hi": "${candle.high?.toStringAsFixed(2)}",
              "Lo": "${candle.low?.toStringAsFixed(2)}",
            },
          
            onTap: (candle) => print("user tapped on $candle"),
            onCandleResize: (width) => print("each candle is $width wide"),
          ),
        );
      
  }
}