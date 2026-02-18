import '../entities/trading_asset.dart';

abstract class TradingRepository {
  Stream<List<TradingAsset>> getPriceUpdates();
}
