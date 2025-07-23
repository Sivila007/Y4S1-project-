// import 'package:camovies/core/constants/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:camovies/config/themes/app_theme.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeManager extends ChangeNotifier {
//   final SharedPreferences _prefs;
//   late ThemeMode _themeMode;

//   ThemeManager(this._prefs) {
//     _loadThemeMode();
//   }

//   ThemeMode get themeMode => _themeMode;
//   ThemeData get theme => _themeMode == ThemeMode.dark
//       ? AppTheme.getDarkTheme()
//       : AppTheme.getLightTheme();

//   void _loadThemeMode() {
//     final savedTheme = _prefs.getString(AppConstants.themeModeKey);
//     _themeMode = switch (savedTheme) {
//       AppConstants.themeModeDark => ThemeMode.dark,
//       AppConstants.themeModeLight => ThemeMode.light,
//       _ => ThemeMode.system,
//     };
//     notifyListeners();
//   }

//   Future<void> setThemeMode(ThemeMode mode) async {
//     if (_themeMode == mode) return;

//     _themeMode = mode;
//     await _prefs.setString(AppConstants.themeModeKey, mode.name);
//     notifyListeners();
//   }

//   Future<void> toggleTheme() async {
//     await setThemeMode(
//       _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
//     );
//   }
// }

import 'package:camovies/config/themes/app_theme.dart';
import 'package:camovies/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeMode getThemeMode(String themeMode) {
    return switch (themeMode) {
      AppConstants.themeModeDark => ThemeMode.dark,
      AppConstants.themeModeLight => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  static ThemeData getTheme(String themeMode) {
    return switch (themeMode) {
      AppConstants.themeModeDark => AppTheme.getDarkTheme(),
      AppConstants.themeModeLight => AppTheme.getLightTheme(),
      _ => AppTheme.getLightTheme(),
    };
  }
}
