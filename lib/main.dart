import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/size_config.dart';
import 'injection_container.dart' as di;
import 'features/trading/presentation/bloc/trading_bloc.dart';
import 'features/trading/presentation/bloc/trading_event.dart';
import 'features/trading/presentation/pages/trading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trading App',
      theme: AppTheme.lightTheme,
      home: Builder(
        builder: (context) {
          SizeConfig.initialize(
            context: context,
            draftWidth: 430,
            draftHeight: 932,
          );
          return BlocProvider(
            create: (_) => di.sl<TradingBloc>()..add(StartTrading()),
            child: const TradingPage(),
          );
        },
      ),
    );
  }
}
