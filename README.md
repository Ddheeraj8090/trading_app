# Trading App - Flutter Assignment

A professional Flutter trading application demonstrating real-time market price fluctuations using Clean Architecture, BLoC state management, and best practices.

## 🏗️ Architecture

This project strictly follows **Clean Architecture** with three distinct layers:

### 1. Domain Layer (`lib/features/trading/domain/`)
- **Entities**: Pure business objects (`TradingAsset`)
- **Repositories**: Abstract interfaces defining contracts
- **Use Cases**: Business logic encapsulation (`GetPriceUpdates`)
- No dependencies on external frameworks

### 2. Data Layer (`lib/features/trading/data/`)
- **Models**: Data transfer objects extending entities (`TradingAssetModel`)
- **Repository Implementations**: Concrete implementations of domain contracts
- Handles data simulation and transformations

### 3. Presentation Layer (`lib/features/trading/presentation/`)
- **BLoC**: State management (Events, States, BLoC)
- **Pages**: Screen-level widgets (`TradingPage`)
- **Widgets**: Reusable UI components
- Only layer that depends on Flutter framework

### Core Layer (`lib/core/`)
- **Constants**: Colors, text styles
- **Theme**: App-wide theming
- **Utils**: Formatters and helpers

## 🔄 State Management Flow

```
User Action → Event → BLoC → Use Case → Repository → Stream → BLoC → State → UI Update
```

### BLoC Implementation:
1. **Events**: 
   - `StartTrading` - Initiates price streaming
   - `SelectAsset` - Selects specific asset for detailed view

2. **States**: 
   - `TradingInitial` - Initial state
   - `TradingLoading` - Loading state
   - `TradingLoaded` - Data loaded with assets list and selected asset
   - `TradingError` - Error state with message

3. **BLoC**: Manages business logic and state transitions using `emit.forEach` for stream handling

## 💉 Dependency Injection

Using **GetIt** for service locator pattern:

```dart
// All dependencies are registered in injection_container.dart
sl.registerLazySingleton<TradingRepository>(() => TradingRepositoryImpl());
sl.registerLazySingleton(() => GetPriceUpdates(sl()));
sl.registerFactory(() => TradingBloc(sl()));
```

**Benefits:**
- Loose coupling
- Easy testing
- Single responsibility
- No direct instantiation in widgets

## 📈 Trading Logic (Frontend Simulation)

### Price Update Mechanism:
- **Update Interval**: Every 2 seconds
- **Price Fluctuation**: ±2% random change
- **Multiple Assets**: BTC, ETH, BNB, SOL, ADA, XRP
- **Tracked Metrics**:
  - Current price
  - Percentage change
  - 24h high/low
  - Volume
  - Up/down trend

### Implementation:
```dart
// Simulates realistic market behavior
final changePercent = (_random.nextDouble() * 4 - 2); // -2% to +2%
final changeAmount = currentPrice * (changePercent / 100);
currentPrice += changeAmount;

// Track 24h high/low
data.high24h = max(data.high24h, data.currentPrice);
data.low24h = min(data.low24h, data.currentPrice);
```

## ♻️ Reusability

### Reusable Widgets:
- **`AssetListItem`** - Displays asset in list with price and change
- **`InfoCard`** - Shows labeled information (24h high/low, volume)
- **`CustomButton`** - Styled action buttons (Buy/Sell)
- **`ChartPlaceholder`** - Chart visualization with trend line

### Reusable Classes:
- **`Formatters`** - Price, percentage, number formatting utilities
- **`AppColors`** - Centralized color palette
- **`AppTextStyles`** - Typography system
- **`AppTheme`** - Theme configuration

### Benefits:
- DRY principle
- Consistent UI/UX
- Easy maintenance
- Scalable codebase

## 📱 UI Features

### Responsive Design:
- **Mobile Layout**: Vertical scrolling with asset list below details
- **Desktop Layout**: Side-by-side panel view (asset list | details)
- **Breakpoint**: 800px width
- **Adaptive**: Works on all screen sizes

### UI Components:
- Real-time price updates every 2 seconds
- Asset selection with visual feedback
- Price charts with trend visualization
- Market statistics (24h high/low, volume, market cap)
- Buy/Sell action buttons
- Color-coded trends (green for up, red for down)
- Smooth animations and transitions

## 🎨 Design System

### Colors:
- **Background**: `#0A0E27` - Dark blue background
- **Card Background**: `#1A1F3A` - Lighter card background
- **Success**: `#00C853` - Green for positive changes
- **Error**: `#FF1744` - Red for negative changes
- **Primary**: `#1E88E5` - Blue for primary actions
- **Text Primary**: `#FFFFFF` - White text
- **Text Secondary**: `#8E92BC` - Gray text
- **Border**: `#2A2F4F` - Border color

### Typography (Poppins Font):
- **H1**: 32px Bold - Main price display
- **H2**: 24px Bold - Asset symbol
- **H3**: 20px Semi-bold - Section headers
- **Body**: 16px Regular - General text
- **Caption**: 14px Regular - Secondary info
- **Small**: 12px Regular - Labels

## 🚀 Getting Started

### Prerequisites:
- Flutter SDK (3.11.0+)
- Dart SDK (3.11.0+)

### Installation:

```bash
# Clone the repository
git clone <repository-url>

# Navigate to project
cd trading_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.1    # State management
  equatable: ^2.0.8       # Value equality
  get_it: ^9.2.0          # Dependency injection
  intl: ^0.20.2           # Internationalization & formatting
```

## 🧪 Testing

The architecture supports easy testing:
- **Unit Tests**: Use cases and BLoC logic
- **Widget Tests**: UI components
- **Integration Tests**: Full app flow

Example test structure:
```dart
// Test use case
test('GetPriceUpdates returns stream of assets', () async {
  // Arrange
  final repository = MockTradingRepository();
  final useCase = GetPriceUpdates(repository);
  
  // Act & Assert
  expect(useCase(), emits(isA<List<TradingAsset>>()));
});
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart          # Color constants
│   │   └── app_text_styles.dart     # Text style constants
│   ├── theme/
│   │   └── app_theme.dart           # App theme configuration
│   └── utils/
│       └── formatters.dart          # Formatting utilities
├── features/
│   └── trading/
│       ├── data/
│       │   ├── models/
│       │   │   └── trading_asset_model.dart    # Data model
│       │   └── repositories/
│       │       └── trading_repository_impl.dart # Repository implementation
│       ├── domain/
│       │   ├── entities/
│       │   │   └── trading_asset.dart          # Business entity
│       │   ├── repositories/
│       │   │   └── trading_repository.dart     # Repository interface
│       │   └── usecases/
│       │       └── get_price_updates.dart      # Use case
│       └── presentation/
│           ├── bloc/
│           │   ├── trading_bloc.dart           # BLoC logic
│           │   ├── trading_event.dart          # Events
│           │   └── trading_state.dart          # States
│           ├── pages/
│           │   └── trading_page.dart           # Main trading screen
│           └── widgets/
│               ├── asset_list_item.dart        # Asset list item widget
│               ├── chart_placeholder.dart      # Chart widget
│               ├── custom_button.dart          # Button widget
│               └── info_card.dart              # Info card widget
├── injection_container.dart                     # DI setup
└── main.dart                                    # App entry point
```

## ✅ Assignment Checklist

- [x] Clean Architecture (3 layers: Domain, Data, Presentation)
- [x] BLoC state management (flutter_bloc)
- [x] Dependency Injection (GetIt)
- [x] Reusable widgets (AssetListItem, InfoCard, CustomButton, ChartPlaceholder)
- [x] Reusable classes (Formatters, AppColors, AppTextStyles, AppTheme)
- [x] Centralized styling (colors, text styles, theme)
- [x] Responsive UI (mobile and desktop layouts)
- [x] Real-time price simulation (updates every 2 seconds)
- [x] Multiple assets (BTC, ETH, BNB, SOL, ADA, XRP)
- [x] No API calls (pure frontend simulation)
- [x] Proper widget tree structure (clean and maintainable)
- [x] Professional code quality (well-documented and organized)

## 🎯 Key Highlights

1. **Strict Clean Architecture**: Clear separation of concerns with Domain, Data, and Presentation layers
2. **Professional BLoC**: Proper event/state management with stream handling
3. **Scalable**: Easy to add new features, assets, or data sources
4. **Maintainable**: Reusable components and centralized configuration
5. **Responsive**: Adaptive layouts for mobile and desktop
6. **Type-safe**: Strong typing throughout the codebase
7. **Well-documented**: Clear code structure and comprehensive README

## 📝 Implementation Details

### Price Simulation Logic
The app simulates realistic market behavior:
- Each asset starts with a base price
- Prices fluctuate randomly within ±2% range
- 24h high/low values are tracked and updated
- Volume is calculated based on price and random multiplier
- Trend direction (up/down) is determined by price change

### State Management
BLoC pattern ensures:
- Unidirectional data flow
- Predictable state changes
- Easy debugging and testing
- Separation of business logic from UI

### Dependency Injection
GetIt provides:
- Centralized dependency management
- Lazy initialization for performance
- Factory pattern for BLoC instances
- Easy mocking for tests

## 🔧 Future Enhancements

Potential improvements:
- Add real-time chart with historical data
- Implement order book functionality
- Add portfolio tracking
- Include price alerts
- Support for more cryptocurrencies
- Dark/Light theme toggle
- Multi-language support
- Persistent storage for favorites

## 📄 License

This project is created for educational purposes as part of a Flutter technical assignment.

## 👨‍💻 Author

Built with ❤️ following Flutter best practices and Clean Architecture principles.

---

**Note**: This is a demo application with simulated data. No real trading or API calls are made.
