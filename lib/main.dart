import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lead_center/config/config.dart';
import 'package:lead_center/features/theme_changer/providers/theme.provider.dart';

void main() async {
  await Environment.initEnvironment();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting();

    // final isDarkMode = ref.watch(isDarkModeProvider);
    // final selectedColor = ref.watch(selectedColorProvider);

    final AppTheme appTheme = ref.watch( themeNotifierProvider );

    final appRouter = ref.watch( goRouterProvider );

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: appTheme.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
