import 'package:flutter_test/flutter_test.dart';
import 'package:trading_app/features/trading/presentation/bloc/trading_bloc.dart';
import 'package:trading_app/features/trading/presentation/bloc/trading_event.dart';
import 'package:trading_app/features/trading/presentation/bloc/trading_state.dart';
import 'package:trading_app/injection_container.dart' as di;

void main() {
  setUp(() async {
    await di.sl.reset();
    await di.init();
  });

  test('dependency injection resolves TradingBloc', () async {
    final bloc = di.sl<TradingBloc>();
    expect(bloc, isA<TradingBloc>());
    await bloc.close();
  });

  test('TradingBloc emits TradingLoaded after StartTrading', () async {
    final bloc = di.sl<TradingBloc>();
    bloc.add(StartTrading());

    await expectLater(
      bloc.stream,
      emitsThrough(isA<TradingLoaded>()),
    );

    await bloc.close();
  }, timeout: const Timeout(Duration(seconds: 8)));
}
