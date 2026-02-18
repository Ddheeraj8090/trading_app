import '../../domain/entities/trading_asset.dart';

class TradingAssetModel extends TradingAsset {
  const TradingAssetModel({
    required super.symbol,
    required super.name,
    required super.price,
    required super.percentageChange,
    required super.high24h,
    required super.low24h,
    required super.volume,
    required super.isUp,
  });

  factory TradingAssetModel.fromEntity(TradingAsset entity) {
    return TradingAssetModel(
      symbol: entity.symbol,
      name: entity.name,
      price: entity.price,
      percentageChange: entity.percentageChange,
      high24h: entity.high24h,
      low24h: entity.low24h,
      volume: entity.volume,
      isUp: entity.isUp,
    );
  }
}
