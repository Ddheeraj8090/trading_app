import 'package:equatable/equatable.dart';
import '../../domain/entities/trading_asset.dart';

abstract class TradingEvent extends Equatable {
  const TradingEvent();

  @override
  List<Object> get props => [];
}

class StartTrading extends TradingEvent {}

class PricesUpdated extends TradingEvent {
  final List<TradingAsset> assets;

  const PricesUpdated(this.assets);

  @override
  List<Object> get props => [assets];
}

class SelectAsset extends TradingEvent {
  final String symbol;

  const SelectAsset(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class SearchQueryChanged extends TradingEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class CategoryChanged extends TradingEvent {
  final int index;

  const CategoryChanged(this.index);

  @override
  List<Object> get props => [index];
}

class TabChanged extends TradingEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object> get props => [index];
}

class BottomNavChanged extends TradingEvent {
  final int index;

  const BottomNavChanged(this.index);

  @override
  List<Object> get props => [index];
}
