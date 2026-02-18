import 'package:equatable/equatable.dart';
import '../../domain/entities/trading_asset.dart';

abstract class TradingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TradingInitial extends TradingState {}

class TradingLoading extends TradingState {}

class TradingLoaded extends TradingState {
  final List<TradingAsset> assets;
  final TradingAsset? selectedAsset;

  TradingLoaded(this.assets, {this.selectedAsset});

  @override
  List<Object?> get props => [assets, selectedAsset];
}

class TradingError extends TradingState {
  final String message;

  TradingError(this.message);

  @override
  List<Object?> get props => [message];
}
