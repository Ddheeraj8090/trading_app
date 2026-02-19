# Trading App (Flutter Tech Assignment - Round 2)

A production-style Flutter trading demo focused on frontend market simulation, architecture quality, and scalable code organization.

## Overview
- Real-time price movement simulation using dummy data only (no APIs).
- Clean Architecture with strict layer separation (Domain, Data, Presentation).
- Flutter BLoC for predictable state flow and testable business logic.
- GetIt-based dependency injection with no direct widget-level wiring.

## SDK Requirements
- Flutter SDK: Stable channel (version compatible with Dart `^3.11.0`)
- Dart SDK: `>=3.11.0 <4.0.0`

## Tech Stack
- Flutter
- `flutter_bloc`
- `equatable`
- `get_it`
- `intl`
- `flutter_svg`

## Project Structure
```text
lib/
  core/
    constants/
      app_colors.dart
      app_strings.dart
    theme/
      app_theme.dart
    utils/
      formatters.dart
      size_config.dart
      drawables/
        icons.dart
        images.dart
      fonts/
        font_family.dart
  features/
    trading/
      data/
        models/
          trading_asset_model.dart
        repositories/
          trading_repository_impl.dart
      domain/
        entities/
          trading_asset.dart
        repositories/
          trading_repository.dart
        usecases/
          get_price_updates.dart
      presentation/
        bloc/
          trading_bloc.dart
          trading_event.dart
          trading_state.dart
        pages/
          trading_page.dart
        widgets/
          asset_card_widget.dart
          asset_list_item.dart
          market_category_item.dart
          price_card_widget.dart
          bottom_navigation/
            curved_navigation_bar.dart
            curved_navigation_bar_item.dart
            nav_bar_item_widget.dart
            nav_custom_clipper.dart
            nav_custom_painter.dart
  injection_container.dart
  main.dart
```

## Architecture
### Domain
- `TradingAsset` entity
- `TradingRepository` contract
- `GetPriceUpdates` use case

### Data
- `TradingAssetModel` model
- `TradingRepositoryImpl` as dummy-data source and price simulation engine

### Presentation
- `TradingBloc` for all screen state transitions
- UI in `TradingPage` and reusable widgets

## State Management Flow
`StartTrading` -> repository stream subscription -> `PricesUpdated` -> `TradingLoaded` -> UI rebuild.

Supported UI events:
- `SearchQueryChanged`
- `CategoryChanged`
- `TabChanged`
- `BottomNavChanged`

## Dependency Injection
All major dependencies are registered in `lib/injection_container.dart`:
- `TradingRepository` -> `TradingRepositoryImpl`
- `GetPriceUpdates`
- `TradingBloc`

No direct BLoC/use case/repository instantiation is done inside UI widgets.

## Dummy Trading Logic
Implemented in `lib/features/trading/data/repositories/trading_repository_impl.dart`:
- Price stream emits every 2 seconds
- Random fluctuation in range `-2%` to `+2%`
- Tracks 24h high/low
- Derives trend direction (`isUp`)
- Generates synthetic volume

## Reusability and Centralization
- Colors centralized in `app_colors.dart`
- Static UI strings centralized in `app_strings.dart`
- Formatting helpers in `formatters.dart`
- Shared widgets for list rows, cards, category items, and custom bottom nav

## Responsiveness
- Uses `SizeConfig` scaling helpers (`.w`, `.h`, `.sp`, `.r`)
- UI adapts to varying screen sizes with proportional spacing and type scaling

## Assignment Compliance
- Clean Architecture with clear Domain, Data, and Presentation separation
- Flutter BLoC based state management (no Provider, Riverpod, or GetX)
- Dependency Injection using GetIt for repository, use case, and BLoC wiring
- Frontend-only real-time trading simulation using dummy data (no API calls)
- Reusable components and centralized constants/utilities for scalability
- Responsive behavior tuned for mobile and tablet layouts

### Partially met / Improvement required
- Responsive requirement asks explicit small + large screen layouts; current app uses scaling but not dedicated desktop/tablet layout branching.
- Error UX is not surfaced; `TradingError` state exists but UI does not render a dedicated error view.

## Run Locally
```bash
flutter pub get
flutter run
```

## Notes
- This is a demo app for assessment purposes.
- Market prices are simulated and not connected to real trading systems.
