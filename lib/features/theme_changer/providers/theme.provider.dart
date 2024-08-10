import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lead_center/config/config.dart';

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// Un simple boolean
final isDarkModeProvider = StateProvider<bool>((ref) => false);

// Un simple int
final selectedColorProvider = StateProvider((ref) => 0);

// Un objeto de tipo AppTheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);


class ThemeNotifier extends StateNotifier<AppTheme> {
  
  // STATE = Estado = new AppTheme();
  ThemeNotifier(): super( AppTheme() );

  void toogleDarkMode() {
    state = state.copyWith( isDarkMode: !state.isDarkMode );
  }

  void changeColorIndex( int colorIndex ) {
    state = state.copyWith( selectedColor: colorIndex );
  }

}