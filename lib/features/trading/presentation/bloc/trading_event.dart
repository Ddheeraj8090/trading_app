import 'package:equatable/equatable.dart';

abstract class TradingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartTrading extends TradingEvent {}

class SelectAsset extends TradingEvent {
  final String symbol;

  SelectAsset(this.symbol);

  @override
  List<Object> get props => [symbol];
}
