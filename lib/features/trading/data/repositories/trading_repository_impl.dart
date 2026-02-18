import 'dart:async';
import 'dart:math';
import '../../domain/entities/trading_asset.dart';
import '../../domain/repositories/trading_repository.dart';
import '../models/trading_asset_model.dart';

class TradingRepositoryImpl implements TradingRepository {
  final Map<String, _AssetData> _assets = {
    'BTC': _AssetData('BTC', 'Bitcoin', 45000.0),
    'ETH': _AssetData('ETH', 'Ethereum', 3200.0),
    'BNB': _AssetData('BNB', 'Binance Coin', 420.0),
    'SOL': _AssetData('SOL', 'Solana', 98.0),
    'ADA': _AssetData('ADA', 'Cardano', 0.52),
    'XRP': _AssetData('XRP', 'Ripple', 0.68),
  };

  final Random _random = Random();

  @override
  Stream<List<TradingAsset>> getPriceUpdates() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      
      final assets = _assets.entries.map((entry) {
        final data = entry.value;
        final changePercent = (_random.nextDouble() * 4 - 2);
        final isUp = changePercent >= 0;
        final changeAmount = data.currentPrice * (changePercent / 100);
        
        data.currentPrice += changeAmount;
        data.high24h = max(data.high24h, data.currentPrice);
        data.low24h = min(data.low24h, data.currentPrice);
        
        return TradingAssetModel(
          symbol: data.symbol,
          name: data.name,
          price: data.currentPrice,
          percentageChange: changePercent,
          high24h: data.high24h,
          low24h: data.low24h,
          volume: data.basePrice * (_random.nextDouble() * 1000000 + 500000),
          isUp: isUp,
        );
      }).toList();

      yield assets;
    }
  }
}

class _AssetData {
  final String symbol;
  final String name;
  final double basePrice;
  double currentPrice;
  double high24h;
  double low24h;

  _AssetData(this.symbol, this.name, this.basePrice)
      : currentPrice = basePrice,
        high24h = basePrice * 1.05,
        low24h = basePrice * 0.95;
}
