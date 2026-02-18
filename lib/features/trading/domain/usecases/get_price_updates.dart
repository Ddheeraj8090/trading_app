import '../entities/trading_asset.dart';
import '../repositories/trading_repository.dart';

class GetPriceUpdates {
  final TradingRepository repository;

  GetPriceUpdates(this.repository);

  Stream<List<TradingAsset>> call() {
    return repository.getPriceUpdates();
  }
}
