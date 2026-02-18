import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/trading_asset.dart';
import '../../domain/usecases/get_price_updates.dart';
import 'trading_event.dart';
import 'trading_state.dart';

class TradingBloc extends Bloc<TradingEvent, TradingState> {
  final GetPriceUpdates getPriceUpdates;
  StreamSubscription? _subscription;
  String? _selectedSymbol;

  TradingBloc(this.getPriceUpdates) : super(TradingInitial()) {
    on<StartTrading>((event, emit) async {
      await emit.forEach<List<TradingAsset>>(
        getPriceUpdates(),
        onData: (assets) {
          final selected = _selectedSymbol != null
              ? assets.firstWhere(
                  (a) => a.symbol == _selectedSymbol,
                  orElse: () => assets.first,
                )
              : assets.first;
          return TradingLoaded(assets, selectedAsset: selected);
        },
      );
    });

    on<SelectAsset>((event, emit) {
      _selectedSymbol = event.symbol;
      if (state is TradingLoaded) {
        final currentState = state as TradingLoaded;
        final selected = currentState.assets.firstWhere(
          (a) => a.symbol == event.symbol,
          orElse: () => currentState.assets.first,
        );
        emit(TradingLoaded(currentState.assets, selectedAsset: selected));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
