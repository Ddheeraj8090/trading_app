import 'package:get_it/get_it.dart';
import 'features/trading/data/repositories/trading_repository_impl.dart';
import 'features/trading/domain/repositories/trading_repository.dart';
import 'features/trading/domain/usecases/get_price_updates.dart';
import 'features/trading/presentation/bloc/trading_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<TradingRepository>(
        () => TradingRepositoryImpl(),
  );

  sl.registerLazySingleton(
        () => GetPriceUpdates(sl()),
  );

  sl.registerFactory(
        () => TradingBloc(sl()),
  );
}
