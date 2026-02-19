import 'package:equatable/equatable.dart';
import '../../domain/entities/trading_asset.dart';

abstract class TradingState extends Equatable {
  const TradingState();

  @override
  List<Object?> get props => [];
}

class TradingInitial extends TradingState {}

class TradingLoading extends TradingState {}

class TradingLoaded extends TradingState {
  final List<TradingAsset> allAssets;
  final List<TradingAsset> assets;
  final TradingAsset? selectedAsset;
  final int selectedCategoryIndex;
  final int selectedTabIndex;
  final int selectedBottomNavIndex;
  final String searchQuery;

  const TradingLoaded({
    required this.allAssets,
    required this.assets,
    required this.selectedAsset,
    required this.selectedCategoryIndex,
    required this.selectedTabIndex,
    required this.selectedBottomNavIndex,
    required this.searchQuery,
  });

  TradingLoaded copyWith({
    List<TradingAsset>? allAssets,
    List<TradingAsset>? assets,
    TradingAsset? selectedAsset,
    int? selectedCategoryIndex,
    int? selectedTabIndex,
    int? selectedBottomNavIndex,
    String? searchQuery,
  }) {
    return TradingLoaded(
      allAssets: allAssets ?? this.allAssets,
      assets: assets ?? this.assets,
      selectedAsset: selectedAsset ?? this.selectedAsset,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedBottomNavIndex:
          selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    allAssets,
    assets,
    selectedAsset,
    selectedCategoryIndex,
    selectedTabIndex,
    selectedBottomNavIndex,
    searchQuery,
  ];
}

class TradingError extends TradingState {
  final String message;

  const TradingError(this.message);

  @override
  List<Object?> get props => [message];
}
