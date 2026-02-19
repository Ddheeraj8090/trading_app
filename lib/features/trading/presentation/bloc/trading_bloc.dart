import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/trading_asset.dart';
import '../../domain/usecases/get_price_updates.dart';
import 'trading_event.dart';
import 'trading_state.dart';

class TradingBloc extends Bloc<TradingEvent, TradingState> {
  final GetPriceUpdates getPriceUpdates;
  StreamSubscription<List<TradingAsset>>? _subscription;
  List<TradingAsset> _allAssets = [];
  String? _selectedSymbol;
  String _searchQuery = '';
  int _selectedCategoryIndex = 0;
  int _selectedTabIndex = 0;
  int _selectedBottomNavIndex = 2;

  TradingBloc(this.getPriceUpdates) : super(TradingInitial()) {
    on<StartTrading>((event, emit) async {
      emit(TradingLoading());
      await _subscription?.cancel();
      _subscription = getPriceUpdates().listen(
        (assets) => add(PricesUpdated(assets)),
        onError: (error) => addError(error),
      );
    });

    on<PricesUpdated>((event, emit) {
      _allAssets = event.assets;
      _emitLoaded(emit);
    });

    on<SelectAsset>((event, emit) {
      _selectedSymbol = event.symbol;
      if (_allAssets.isNotEmpty) {
        _emitLoaded(emit);
      }
    });

    on<SearchQueryChanged>((event, emit) {
      _searchQuery = event.query.trim();
      if (_allAssets.isNotEmpty) {
        _emitLoaded(emit);
      }
    });

    on<CategoryChanged>((event, emit) {
      _selectedCategoryIndex = event.index;
      if (_allAssets.isNotEmpty) {
        _emitLoaded(emit);
      }
    });

    on<TabChanged>((event, emit) {
      _selectedTabIndex = event.index;
      if (_allAssets.isNotEmpty) {
        _emitLoaded(emit);
      }
    });

    on<BottomNavChanged>((event, emit) {
      _selectedBottomNavIndex = event.index;
      if (_allAssets.isNotEmpty) {
        _emitLoaded(emit);
      }
    });
  }

  void _emitLoaded(Emitter<TradingState> emit) {
    final filteredAssets = _filterAssets(_allAssets, _searchQuery);
    final selected = _resolveSelectedAsset(_allAssets);

    emit(
      TradingLoaded(
        allAssets: _allAssets,
        assets: filteredAssets,
        selectedAsset: selected,
        selectedCategoryIndex: _selectedCategoryIndex,
        selectedTabIndex: _selectedTabIndex,
        selectedBottomNavIndex: _selectedBottomNavIndex,
        searchQuery: _searchQuery,
      ),
    );
  }

  List<TradingAsset> _filterAssets(List<TradingAsset> assets, String query) {
    if (query.isEmpty) return assets;
    final lowercaseQuery = query.toLowerCase();
    return assets.where((asset) {
      return asset.symbol.toLowerCase().contains(lowercaseQuery) ||
          asset.name.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  TradingAsset? _resolveSelectedAsset(List<TradingAsset> assets) {
    if (assets.isEmpty) return null;
    if (_selectedSymbol == null) {
      return assets.first;
    }
    return assets.firstWhere(
      (asset) => asset.symbol == _selectedSymbol,
      orElse: () => assets.first,
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
