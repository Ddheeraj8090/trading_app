import 'package:equatable/equatable.dart';

class TradingAsset extends Equatable {
  final String symbol;
  final String name;
  final double price;
  final double percentageChange;
  final double high24h;
  final double low24h;
  final double volume;
  final bool isUp;

  const TradingAsset({
    required this.symbol,
    required this.name,
    required this.price,
    required this.percentageChange,
    required this.high24h,
    required this.low24h,
    required this.volume,
    required this.isUp,
  });

  @override
  List<Object> get props => [symbol, name, price, percentageChange, high24h, low24h, volume, isUp];
}
