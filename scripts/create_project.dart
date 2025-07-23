// *******************************************************
// **************** Sopheap Om ****************
// **************** www.sopheap.dev ****************
// **************** 2025-07-05 ****************
// *******************************************************

import 'dart:io';

void main() async {
  // Get project name from pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    throw Exception(
        'pubspec.yaml not found. Please run this script from your project root.');
  }

  final pubspecContent = await pubspecFile.readAsString();
  final nameMatch = RegExp(r'name:\s*"?([^"\n]+)"?').firstMatch(pubspecContent);
  if (nameMatch == null) {
    throw Exception('Project name not found in pubspec.yaml');
  }

  final projectName = nameMatch.group(1)!;
  print('Detected project name: $projectName');
  print('Generating folder structure...');

  // Delete existing lib folder if it exists
  final libDir = Directory('lib');
  if (await libDir.exists()) {
    await libDir.delete(recursive: true);
    print('Deleted existing lib folder');
  }

  // Create directory structure
  final directories = [
    // Config layer
    'lib/config/env',
    'lib/config/routes',
    'lib/config/themes',
    'lib/config/di',
    'lib/config/l10n',
    'lib/config/l10n/arb',

    // Core layer
    'lib/core/constants',
    'lib/core/extensions',
    'lib/core/utils',
    'lib/core/services',
    'lib/core/widgets',
    'lib/core/blocs',

    // Data layer
    'lib/data/datasources',
    'lib/data/models',
    'lib/data/repositories',

    // Domain layer
    'lib/domain/entities',
    'lib/domain/repositories',
    'lib/domain/usecases',

    // Screens (feature modules)
    'lib/screens/auth/view',
    'lib/screens/auth/widgets',
    'lib/screens/auth/bloc',

    'lib/screens/home/view',
    'lib/screens/home/widgets',
    'lib/screens/home/bloc',

    'lib/screens/profile/view',
    'lib/screens/profile/widgets',
    'lib/screens/profile/bloc',

    'lib/screens/setting/view',
    'lib/screens/setting/widgets',
    'lib/screens/setting/bloc',

    'lib/screens/splash/view',
    'lib/screens/splash/widgets',
    'lib/screens/splash/bloc',

    // Assets
    'assets/images',
    'assets/icons',
    'assets/fonts',
  ];

  for (final dir in directories) {
    final directory = Directory(dir);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      print('Created $dir');
    } else {
      print('Directory already exists: $dir');
    }
  }

  // Function to replace project name in imports
  String replaceProjectName(String content) {
    return content.replaceAll(
      'flutter_project_template',
      projectName,
    );
  }

  // Create theme files
  await _createFile(
    'lib/config/themes/app_colors.dart',
    replaceProjectName('''import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primaryLight = Color(0xFF6750A4);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color primaryContainerLight = Color(0xFFEADDFF);
  static const Color onPrimaryContainerLight = Color(0xFF21005E);

  // Secondary colors
  static const Color secondaryLight = Color(0xFF625B71);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color secondaryContainerLight = Color(0xFFE8DEF8);
  static const Color onSecondaryContainerLight = Color(0xFF1E192B);

  // Tertiary colors
  static const Color tertiaryLight = Color(0xFF7D5260);
  static const Color onTertiaryLight = Color(0xFFFFFFFF);
  static const Color tertiaryContainerLight = Color(0xFFFFD8E4);
  static const Color onTertiaryContainerLight = Color(0xFF31111D);

  // Error colors
  static const Color errorLight = Color(0xFFB3261E);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color errorContainerLight = Color(0xFFF9DEDC);
  static const Color onErrorContainerLight = Color(0xFF410E0B);

  // Background colors
  static const Color backgroundLight = Color(0xFFFFFBFE);
  static const Color onBackgroundLight = Color(0xFF1C1B1F);

  // Surface colors
  static const Color surfaceLight = Color(0xFFFFFBFE);
  static const Color onSurfaceLight = Color(0xFF1C1B1F);
  static const Color surfaceVariantLight = Color(0xFFE7E0EC);
  static const Color onSurfaceVariantLight = Color(0xFF49454F);

  // Outline colors
  static const Color outlineLight = Color(0xFF79747E);
  static const Color outlineVariantLight = Color(0xFFCAC4D0);

  // Additional colors
  static const Color shadowLight = Color(0xFF000000);
  static const Color scrimLight = Color(0xFF000000);
  static const Color inverseSurfaceLight = Color(0xFF313033);
  static const Color onInverseSurfaceLight = Color(0xFFF4EFF4);
  static const Color inversePrimaryLight = Color(0xFFD0BCFF);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF1C1B1F);
  static const Color textSecondaryLight = Color(0xFF49454F);

  // Dark theme colors
  // Primary colors
  static const Color primaryDark = Color(0xFFD0BCFF);
  static const Color onPrimaryDark = Color(0xFF381E72);
  static const Color primaryContainerDark = Color(0xFF4F378B);
  static const Color onPrimaryContainerDark = Color(0xFFEADDFF);

  // Secondary colors
  static const Color secondaryDark = Color(0xFFCCC2DC);
  static const Color onSecondaryDark = Color(0xFF332D41);
  static const Color secondaryContainerDark = Color(0xFF4A4458);
  static const Color onSecondaryContainerDark = Color(0xFFE8DEF8);

  // Tertiary colors
  static const Color tertiaryDark = Color(0xFFEFB8C8);
  static const Color onTertiaryDark = Color(0xFF492532);
  static const Color tertiaryContainerDark = Color(0xFF633B48);
  static const Color onTertiaryContainerDark = Color(0xFFFFD8E4);

  // Error colors
  static const Color errorDark = Color(0xFFF2B8B5);
  static const Color onErrorDark = Color(0xFF601410);
  static const Color errorContainerDark = Color(0xFF8C1D18);
  static const Color onErrorContainerDark = Color(0xFFF9DEDC);

  // Background colors
  static const Color backgroundDark = Color(0xFF1C1B1F);
  static const Color onBackgroundDark = Color(0xFFE6E1E5);

  // Surface colors
  static const Color surfaceDark = Color(0xFF1C1B1F);
  static const Color onSurfaceDark = Color(0xFFE6E1E5);
  static const Color surfaceVariantDark = Color(0xFF49454F);
  static const Color onSurfaceVariantDark = Color(0xFFCAC4D0);

  // Outline colors
  static const Color outlineDark = Color(0xFF938F99);
  static const Color outlineVariantDark = Color(0xFF49454F);

  // Additional colors
  static const Color shadowDark = Color(0xFF000000);
  static const Color scrimDark = Color(0xFF000000);
  static const Color inverseSurfaceDark = Color(0xFFE6E1E5);
  static const Color onInverseSurfaceDark = Color(0xFF313033);
  static const Color inversePrimaryDark = Color(0xFF6750A4);

  // Text colors
  static const Color textPrimaryDark = Color(0xFFE6E1E5);
  static const Color textSecondaryDark = Color(0xFFCAC4D0);
}'''),
  );

  await _createFile(
    'lib/config/themes/app_text_styles.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
import 'package:$projectName/config/themes/app_colors.dart';

class AppTextStyles {
  static TextTheme getLightTextTheme() {
    return const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: AppColors.textPrimaryLight,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.textPrimaryLight,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.textPrimaryLight,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimaryLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimaryLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimaryLight,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: AppColors.textPrimaryLight,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.textPrimaryLight,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.textPrimaryLight,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.textPrimaryLight,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.textPrimaryLight,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.textPrimaryLight,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: AppColors.textPrimaryLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.textPrimaryLight,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.textSecondaryLight,
      ),
    );
  }

  static TextTheme getDarkTextTheme() {
    return const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: AppColors.textPrimaryDark,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.textPrimaryDark,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.textPrimaryDark,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimaryDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimaryDark,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.textPrimaryDark,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: AppColors.textPrimaryDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.textPrimaryDark,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.textPrimaryDark,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.textPrimaryDark,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.textPrimaryDark,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.textPrimaryDark,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: AppColors.textPrimaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.textPrimaryDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.textSecondaryDark,
      ),
    );
  }
}'''),
  );

  await _createFile(
    'lib/config/themes/app_theme.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
    import 'package:$projectName/config/themes/app_colors.dart';
    import 'package:$projectName/config/themes/app_text_styles.dart';

    class AppTheme {
      static ThemeData getLightTheme() {
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorScheme: ColorScheme.light(
            primary: AppColors.primaryLight,
            onPrimary: AppColors.onPrimaryLight,
            primaryContainer: AppColors.primaryContainerLight,
            onPrimaryContainer: AppColors.onPrimaryContainerLight,
            secondary: AppColors.secondaryLight,
            onSecondary: AppColors.onSecondaryLight,
            secondaryContainer: AppColors.secondaryContainerLight,
            onSecondaryContainer: AppColors.onSecondaryContainerLight,
            tertiary: AppColors.tertiaryLight,
            onTertiary: AppColors.onTertiaryLight,
            tertiaryContainer: AppColors.tertiaryContainerLight,
            onTertiaryContainer: AppColors.onTertiaryContainerLight,
            error: AppColors.errorLight,
            onError: AppColors.onErrorLight,
            errorContainer: AppColors.errorContainerLight,
            onErrorContainer: AppColors.onErrorContainerLight,
            background: AppColors.backgroundLight,
            onBackground: AppColors.onBackgroundLight,
            surface: AppColors.surfaceLight,
            onSurface: AppColors.onSurfaceLight,
            surfaceVariant: AppColors.surfaceVariantLight,
            onSurfaceVariant: AppColors.onSurfaceVariantLight,
            outline: AppColors.outlineLight,
            outlineVariant: AppColors.outlineVariantLight,
            shadow: AppColors.shadowLight,
            scrim: AppColors.scrimLight,
            inverseSurface: AppColors.inverseSurfaceLight,
            onInverseSurface: AppColors.onInverseSurfaceLight,
            inversePrimary: AppColors.inversePrimaryLight,
          ),
          textTheme: AppTextStyles.getLightTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.surfaceLight,
            foregroundColor: AppColors.onSurfaceLight,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            color: AppColors.surfaceLight,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surfaceVariantLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.outlineLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.errorLight),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.errorLight, width: 2),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryLight,
              foregroundColor: AppColors.onPrimaryLight,
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      }

      static ThemeData getDarkTheme() {
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            primary: AppColors.primaryDark,
            onPrimary: AppColors.onPrimaryDark,
            primaryContainer: AppColors.primaryContainerDark,
            onPrimaryContainer: AppColors.onPrimaryContainerDark,
            secondary: AppColors.secondaryDark,
            onSecondary: AppColors.onSecondaryDark,
            secondaryContainer: AppColors.secondaryContainerDark,
            onSecondaryContainer: AppColors.onSecondaryContainerDark,
            tertiary: AppColors.tertiaryDark,
            onTertiary: AppColors.onTertiaryDark,
            tertiaryContainer: AppColors.tertiaryContainerDark,
            onTertiaryContainer: AppColors.onTertiaryContainerDark,
            error: AppColors.errorDark,
            onError: AppColors.onErrorDark,
            errorContainer: AppColors.errorContainerDark,
            onErrorContainer: AppColors.onErrorContainerDark,
            background: AppColors.backgroundDark,
            onBackground: AppColors.onBackgroundDark,
            surface: AppColors.surfaceDark,
            onSurface: AppColors.onSurfaceDark,
            surfaceVariant: AppColors.surfaceVariantDark,
            onSurfaceVariant: AppColors.onSurfaceVariantDark,
            outline: AppColors.outlineDark,
            outlineVariant: AppColors.outlineVariantDark,
            shadow: AppColors.shadowDark,
            scrim: AppColors.scrimDark,
            inverseSurface: AppColors.inverseSurfaceDark,
            onInverseSurface: AppColors.onInverseSurfaceDark,
            inversePrimary: AppColors.inversePrimaryDark,
          ),
          textTheme: AppTextStyles.getDarkTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.surfaceDark,
            foregroundColor: AppColors.onSurfaceDark,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            color: AppColors.surfaceDark,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surfaceVariantDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.outlineDark),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.errorDark),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.errorDark, width: 2),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              foregroundColor: AppColors.onPrimaryDark,
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      }
    }
    '''),
  );

  await _createFile(
    'lib/config/themes/theme_manager.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
    import 'package:$projectName/config/themes/app_theme.dart';
    import 'package:shared_preferences/shared_preferences.dart';

    class ThemeManager extends ChangeNotifier {
      static const String _themeKey = 'theme_mode';

      final SharedPreferences _prefs;
      late ThemeMode _themeMode;

      ThemeManager(this._prefs) {
        _loadThemeMode();
      }

      ThemeMode get themeMode => _themeMode;
      ThemeData get theme => _themeMode == ThemeMode.dark
          ? AppTheme.getDarkTheme()
          : AppTheme.getLightTheme();

      void _loadThemeMode() {
        final savedTheme = _prefs.getString(_themeKey);
        _themeMode = switch (savedTheme) {
          'dark' => ThemeMode.dark,
          'light' => ThemeMode.light,
          _ => ThemeMode.system,
        };
        notifyListeners();
      }

      Future<void> setThemeMode(ThemeMode mode) async {
        if (_themeMode == mode) return;

        _themeMode = mode;
        await _prefs.setString(_themeKey, mode.name);
        notifyListeners();
      }

      Future<void> toggleTheme() async {
        await setThemeMode(
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
        );
      }
    }
    '''),
  );

  // Create locale bloc first since it's a dependency
  await _createFile(
    'lib/core/blocs/locale/locale_bloc.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/config/l10n/l10n.dart';
import 'package:$projectName/core/services/storage_service.dart';

// Events
abstract class LocaleEvent {
  const LocaleEvent();
}

class LoadLocale extends LocaleEvent {
  const LoadLocale();
}

class ChangeLocale extends LocaleEvent {
  final AppLanguage language;

  const ChangeLocale(this.language);
}

// State
class LocaleState {
  final Locale locale;
  final bool isLoading;
  final String? error;

  const LocaleState({
    required this.locale,
    this.isLoading = false,
    this.error,
  });

  LocaleState copyWith({
    Locale? locale,
    bool? isLoading,
    String? error,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Bloc
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final StorageService _storageService;
  static const String _languageKey = 'app_language';

  LocaleBloc(this._storageService)
      : super(
          LocaleState(
            locale: const Locale('en', 'US'),
          ),
        ) {
    on<LoadLocale>(_onLoadLocale);
    on<ChangeLocale>(_onChangeLocale);
  }

  Future<void> _onLoadLocale(
    LoadLocale event,
    Emitter<LocaleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final languageCode = _storageService.getString(_languageKey) ?? 'en';
      final language = AppLanguage.values.firstWhere(
        (lang) => lang.languageCode == languageCode,
        orElse: () => AppLanguage.english,
      );
      emit(
        state.copyWith(
          locale: Locale(language.languageCode, language.countryCode),
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load locale: \${e.toString()}',
        isLoading: false,
      ));
    }
  }

  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<LocaleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _storageService.setString(_languageKey, event.language.languageCode);
      emit(state.copyWith(
        locale: Locale(event.language.languageCode, event.language.countryCode),
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to change locale: \${e.toString()}',
        isLoading: false,
      ));
    }
  }
}'''),
  );

  // Create settings bloc
  await _createFile(
    'lib/screens/setting/bloc/settings_bloc.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/config/l10n/l10n.dart';
import 'package:$projectName/config/themes/theme_manager.dart';
import 'package:$projectName/core/blocs/locale/locale_bloc.dart';
import 'package:$projectName/screens/setting/bloc/settings_event.dart';
import 'package:$projectName/screens/setting/bloc/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ThemeManager _themeManager;
  final LocaleBloc _localeBloc;

  SettingsBloc(
    this._themeManager,
    this._localeBloc,
  ) : super(
        SettingsState(
          isDarkMode: _themeManager.themeMode == ThemeMode.dark,
          currentLanguage: AppLanguage.values.firstWhere(
            (lang) => lang.languageCode == _localeBloc.state.locale.languageCode,
            orElse: () => AppLanguage.english,
          ),
        ),
      ) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  void _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) {
    try {
      emit(state.copyWith(
        isDarkMode: _themeManager.themeMode == ThemeMode.dark,
        currentLanguage: AppLanguage.values.firstWhere(
          (lang) => lang.languageCode == _localeBloc.state.locale.languageCode,
          orElse: () => AppLanguage.english,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to load settings: \${e.toString()}'));
    }
  }

  void _onToggleTheme(
    ToggleTheme event,
    Emitter<SettingsState> emit,
  ) {
    try {
      _themeManager.toggleTheme();
      emit(state.copyWith(
        isDarkMode: _themeManager.themeMode == ThemeMode.dark,
      ));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to toggle theme: \${e.toString()}'));
    }
  }

  void _onChangeLanguage(
    ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) {
    try {
      _localeBloc.add(ChangeLocale(event.language));
      emit(state.copyWith(currentLanguage: event.language));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to change language: \${e.toString()}'));
    }
  }
}'''),
  );

  // Create settings bloc events
  await _createFile(
    'lib/screens/setting/bloc/settings_event.dart',
    replaceProjectName('''import 'package:$projectName/config/l10n/l10n.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class LoadSettings extends SettingsEvent {
  const LoadSettings();
}

class ToggleTheme extends SettingsEvent {
  const ToggleTheme();
}

class ChangeLanguage extends SettingsEvent {
  final AppLanguage language;

  const ChangeLanguage(this.language);
}'''),
  );

  // Create settings bloc state
  await _createFile(
    'lib/screens/setting/bloc/settings_state.dart',
    replaceProjectName('''import 'package:$projectName/config/l10n/l10n.dart';

class SettingsState {
  final bool isDarkMode;
  final AppLanguage currentLanguage;
  final bool isLoading;
  final String? error;

  const SettingsState({
    required this.isDarkMode,
    required this.currentLanguage,
    this.isLoading = false,
    this.error,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    AppLanguage? currentLanguage,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentLanguage: currentLanguage ?? this.currentLanguage,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}'''),
  );

  // Create dependency injection setup
  await _createFile(
    'lib/config/di/di.dart',
    replaceProjectName('''import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:$projectName/config/themes/theme_manager.dart';
import 'package:$projectName/core/blocs/locale/locale_bloc.dart';
import 'package:$projectName/core/services/storage_service.dart';
import 'package:$projectName/screens/setting/bloc/settings_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<StorageService>(StorageService(prefs));
  getIt.registerSingleton<ThemeManager>(ThemeManager(prefs));

  // Blocs
  getIt.registerFactory<LocaleBloc>(() => LocaleBloc(getIt<StorageService>()));
  getIt.registerFactory<SettingsBloc>(() => SettingsBloc(
        getIt<ThemeManager>(),
        getIt<LocaleBloc>(),
      ));
}'''),
  );

  // Update main.dart to initialize dependencies
  await _createFile(
    'lib/main.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:$projectName/config/di/di.dart';
import 'package:$projectName/config/l10n/l10n.dart';
import 'package:$projectName/config/l10n/arb/app_localizations.dart';
import 'package:$projectName/config/routes/app_router.dart';
import 'package:$projectName/config/themes/theme_manager.dart';
import 'package:$projectName/core/blocs/locale/locale_bloc.dart';
import 'package:$projectName/screens/setting/bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependencies
  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LocaleBloc>()..add(const LoadLocale()),
        ),
        BlocProvider(
          create: (context) => getIt<SettingsBloc>(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => getIt<ThemeManager>(),
        child: Builder(
          builder: (context) {
            final themeManager = context.watch<ThemeManager>();
            
            return BlocBuilder<LocaleBloc, LocaleState>(
              builder: (context, state) {
                return MaterialApp.router(
                  title: 'Flutter Project Template',
                  theme: themeManager.theme,
                  themeMode: themeManager.themeMode,
                  routerConfig: goRouter,
                  locale: state.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppLanguage.values
                      .map((lang) => Locale(lang.languageCode, lang.countryCode))
                      .toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}'''),
  );

  // Create pubspec.yaml with all required dependencies
  await _createFile(
    'pubspec.yaml',
    replaceProjectName('''name: flutter_project_template
description: "A professional Flutter project template with clean architecture"
publish_to: "none"
version: 1.0.0+1

environment:
  sdk: '>=3.2.3 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.4
  equatable: ^2.0.7
  provider: ^6.1.2

  # Dependency Injection
  get_it: ^7.6.7
  injectable: ^2.3.5

  # Navigation
  go_router: ^13.2.0

  # Network
  dio: ^5.4.1
  connectivity_plus: ^5.0.2
  http: ^1.2.0

  # Local Storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # Utils
  logger: ^2.0.2+1
  intl: ^0.20.2
  path_provider: ^2.1.2
  url_launcher: ^6.2.4
  package_info_plus: ^5.0.1
  device_info_plus: ^9.1.2

  # UI Components
  cached_network_image: ^3.3.1
  flutter_svg: ^2.0.9
  shimmer: ^3.0.0
  lottie: ^3.0.0

  # Firebase (Optional, uncomment if needed)
  # firebase_core: ^2.25.4
  # firebase_auth: ^4.17.4
  # firebase_messaging: ^14.7.15
  # firebase_analytics: ^10.8.5
  # cloud_firestore: ^4.15.4

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  build_runner: ^2.4.8
  injectable_generator: ^2.4.1
  hive_generator: ^2.0.1
  mockito: ^5.4.4
  bloc_test: ^9.1.5

flutter:
  uses-material-design: true
  generate: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/
'''),
  );

  // Create bottom navigation widget
  await _createFile(
    'lib/core/widgets/bottom_navigation.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
    import 'package:go_router/go_router.dart';
    import 'package:$projectName/screens/home/view/home_screen.dart';
    import 'package:$projectName/screens/profile/view/profile_screen.dart';
    import 'package:$projectName/screens/setting/view/setting_screen.dart';

    class AppBottomNavigation extends StatelessWidget {
      const AppBottomNavigation({
        super.key,
        required this.currentIndex,
      });

      final int currentIndex;

      @override
      Widget build(BuildContext context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        
        final selectedColor = isDark 
            ? theme.colorScheme.primary 
            : const Color(0xFF6750A4);
        final unselectedColor = isDark 
            ? theme.colorScheme.onSurface.withOpacity(0.7)
            : Colors.black54;
        final indicatorColor = isDark
            ? theme.colorScheme.primaryContainer
            : const Color(0xFFEEE6FF);

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return TextStyle(
                    color: selectedColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  );
                }
                return TextStyle(
                  color: unselectedColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                );
              }),
              iconTheme: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return IconThemeData(
                    color: selectedColor,
                    size: 24,
                  );
                }
                return IconThemeData(
                  color: unselectedColor,
                  size: 24,
                );
              }),
            ),
            child: NavigationBar(
              height: 65,
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    context.go(HomeScreen.routeName);
                  case 1:
                    context.go(ProfileScreen.routeName);
                  case 2:
                    context.go(SettingScreen.routeName);
                }
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorShape: const CircleBorder(),
              indicatorColor: indicatorColor,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      }
    }
    '''),
  );

  // Create shell route widget
  await _createFile(
    'lib/core/widgets/shell_route.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
    import 'package:$projectName/core/widgets/bottom_navigation.dart';

    class AppShell extends StatelessWidget {
      const AppShell({
        super.key,
        required this.child,
        required this.currentIndex,
      });

      final Widget child;
      final int currentIndex;

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: child,
          bottomNavigationBar: AppBottomNavigation(
            currentIndex: currentIndex,
          ),
        );
      }
    }
    '''),
  );

  // Create router configuration with shell route
  await _createFile(
    'lib/config/routes/app_router.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
    import 'package:go_router/go_router.dart';
    import 'package:$projectName/core/widgets/shell_route.dart';
    import 'package:$projectName/screens/auth/view/auth_screen.dart';
    import 'package:$projectName/screens/home/view/home_screen.dart';
    import 'package:$projectName/screens/profile/view/profile_screen.dart';
    import 'package:$projectName/screens/setting/view/setting_screen.dart';
    import 'package:$projectName/screens/splash/view/splash_screen.dart';

    final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

    final goRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: SplashScreen.routeName,
      routes: [
        // Non-shell routes (outside bottom navigation)
        GoRoute(
          path: SplashScreen.routeName,
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AuthScreen.routeName,
          name: 'auth',
          builder: (context, state) => const AuthScreen(),
        ),
        
        // Shell route (with bottom navigation)
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            // Determine current index based on location
            int index = switch (state.matchedLocation) {
              HomeScreen.routeName => 0,
              ProfileScreen.routeName => 1,
              SettingScreen.routeName => 2,
              _ => 0,
            };
            
            return AppShell(
              currentIndex: index,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: HomeScreen.routeName,
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: ProfileScreen.routeName,
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),
            GoRoute(
              path: SettingScreen.routeName,
              name: 'setting',
              builder: (context, state) => const SettingScreen(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Error: \${state.error}'),
        ),
      ),
    );
    '''),
  );

  // Create core service setup
  await _createFile(
    'lib/core/services/api_service.dart',
    replaceProjectName('''import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
'''),
  );

  // Create storage service
  await _createFile(
    'lib/core/services/storage_service.dart',
    replaceProjectName(
        '''import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
'''),
  );

  // Create l10n files
  await _createFile(
    'lib/config/l10n/l10n.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
import 'package:$projectName/config/l10n/arb/app_localizations.dart';

enum AppLanguage { english, khmer }

extension AppLanguageExtension on AppLanguage {
  String get languageCode => switch (this) {
    AppLanguage.english => 'en',
    AppLanguage.khmer => 'km',
  };

  String get countryCode => switch (this) {
    AppLanguage.english => 'US',
    AppLanguage.khmer => 'KH',
  };

  String get languageName => switch (this) {
    AppLanguage.english => 'English',
    AppLanguage.khmer => 'Khmer',
  };
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
'''),
  );

  // Create ARB files
  await _createFile(
    'lib/config/l10n/arb/app_en.arb',
    replaceProjectName('''{
  "@@locale": "en",
  "appTitle": "My App",
  "@appTitle": {
    "description": "The title of the application"
  },
  "helloWorld": "Hello World!",
  "@helloWorld": {
    "description": "A program greeting"
  },
  "splashScreenTitle": "Splash",
  "@splashScreenTitle": {
    "description": "Title for the Splash screen"
  },
  "homeScreenTitle": "Home",
  "@homeScreenTitle": {
    "description": "Title for the Home screen"
  },
  "authScreenTitle": "Authentication",
  "@authScreenTitle": {
    "description": "Title for the Auth screen"
  },
  "profileScreenTitle": "Profile",
  "@profileScreenTitle": {
    "description": "Title for the Profile screen"
  },
  "settingScreenTitle": "Setting",
  "@settingScreenTitle": {
    "description": "Title for the Setting screen"
  }
}'''),
  );

  await _createFile(
    'lib/config/l10n/arb/app_km.arb',
    replaceProjectName('''{
  "@@locale": "km",
  "appTitle": "កម្មវិធីរបស់ខ្ញុំ",
  "helloWorld": "សួស្តី​ពិភពលោក!",
  "splashScreenTitle": "ស្វាគមន៍",
  "homeScreenTitle": "ទំព័រដើម",
  "authScreenTitle": "ការផ្ទៀងផ្ទាត់",
  "profileScreenTitle": "ប្រវត្តិរូប",
  "settingScreenTitle": "ការកំណត់"
}'''),
  );

  // Create l10n.yaml
  await _createFile(
    'l10n.yaml',
    replaceProjectName('''arb-dir: lib/config/l10n/arb
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
nullable-getter: false
untranslated-messages-file: l10n_untranslated_language.txt'''),
  );

  // Create default screen files
  final screens = ['splash', 'home', 'auth', 'profile', 'setting'];
  for (final screen in screens) {
    final screenCapitalized = screen[0].toUpperCase() + screen.substring(1);

    if (screen == 'splash') {
      await _createFile(
        'lib/screens/$screen/view/${screen}_screen.dart',
        replaceProjectName('''import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/config/l10n/l10n.dart';
import 'package:$projectName/screens/home/view/home_screen.dart';

class ${screenCapitalized}Screen extends StatefulWidget {
  const ${screenCapitalized}Screen({super.key});

  static const String routeName = '/$screen';

  @override
  State<${screenCapitalized}Screen> createState() => _${screenCapitalized}ScreenState();
}

class _${screenCapitalized}ScreenState extends State<${screenCapitalized}Screen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    // Navigate to home screen after animation
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        context.go(HomeScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeInAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo or Icon
                    Icon(
                      Icons.flutter_dash,
                      size: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    // App Name
                    Text(
                      context.l10n.appTitle,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    // Loading Indicator
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}'''),
      );
    } else if (screen == 'home') {
      await _createFile(
        'lib/screens/$screen/view/${screen}_screen.dart',
        replaceProjectName('''import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildWelcomeSection(theme),
          _buildQuickActions(theme),
          _buildRecentActivity(theme),
          _buildPopularItems(theme),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(ThemeData theme) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -20,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome back!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'What would you like to do today?',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeData theme) {
    final actions = [
      ('Add New', Icons.add_circle_outline),
      ('Search', Icons.search),
      ('Favorites', Icons.favorite_border),
      ('Settings', Icons.settings_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: actions.map((action) {
              final (title, icon) = action;
              return Column(
                children: [
                  FilledButton.tonal(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Icon(icon),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.history,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text('Activity \${index + 1}'),
                  subtitle: Text('Details about activity \${index + 1}'),
                  trailing: Text(
                    '\${index + 1}h ago',
                    style: theme.textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularItems(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Items',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 160,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              color: theme.colorScheme.primaryContainer,
                              child: Center(
                                child: Icon(
                                  Icons.star,
                                  size: 32,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Item \${index + 1}',
                                    style: theme.textTheme.titleMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Description for item \${index + 1}',
                                    style: theme.textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}'''),
      );
    } else if (screen == 'setting') {
      await _createFile(
        'lib/screens/$screen/view/${screen}_screen.dart',
        replaceProjectName('''import 'package:flutter/material.dart';
import 'package:$projectName/config/l10n/l10n.dart';

class ${screenCapitalized}Screen extends StatelessWidget {
  const ${screenCapitalized}Screen({super.key});

  static const String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingScreenTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implement language selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Theme'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implement theme selection
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implement notification settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy & Security'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implement privacy settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Implement about screen
            },
          ),
        ],
      ),
    );
  }
}'''),
      );
    } else {
      await _createFile(
        'lib/screens/$screen/view/${screen}_screen.dart',
        replaceProjectName('''import 'package:flutter/material.dart';
import 'package:$projectName/config/l10n/l10n.dart';

class ${screenCapitalized}Screen extends StatelessWidget {
  const ${screenCapitalized}Screen({super.key});

  static const String routeName = '/$screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.${screen}ScreenTitle),
      ),
      body: Center(
        child: Text('Body of \${context.l10n.${screen}ScreenTitle}'),
      ),
    );
  }
}'''),
      );
    }
  }

  // Create language screen
  await _createFile(
    'lib/screens/setting/view/language_screen.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';
    import 'package:$projectName/config/l10n/l10n.dart';
    import 'package:$projectName/core/blocs/locale/locale_bloc.dart';
    import 'package:$projectName/screens/setting/bloc/settings_bloc.dart';
    import 'package:$projectName/screens/setting/bloc/settings_event.dart';
    import 'package:$projectName/screens/setting/bloc/settings_state.dart';

    class LanguageScreen extends StatelessWidget {
      const LanguageScreen({super.key});

      static const String routeName = '/language';

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.settingScreenTitle),
          ),
          body: BlocListener<LocaleBloc, LocaleState>(
            listener: (context, localeState) {
              // When locale changes, reload settings to sync the display
              context.read<SettingsBloc>().add(LoadSettings());
            },
            child: BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error!),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: AppLanguage.values.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final language = AppLanguage.values[index];
                    final isSelected = state.currentLanguage == language;

                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          context
                              .read<SettingsBloc>()
                              .add(ChangeLanguage(language));
                        },
                        leading: CircleAvatar(
                          backgroundColor: isSelected
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context).colorScheme.surfaceVariant,
                          child: Text(
                            language.languageCode.toUpperCase(),
                            style: TextStyle(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onPrimaryContainer
                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        title: Text(language.languageName),
                        subtitle: Text(language.countryCode),
                        trailing: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  key: const ValueKey('selected'),
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : const SizedBox(
                                  key: ValueKey('not_selected'),
                                  width: 24,
                                ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      }
    }
    '''),
  );

  // Update settings screen
  await _createFile(
    'lib/screens/setting/view/setting_screen.dart',
    replaceProjectName('''import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';
    import 'package:go_router/go_router.dart';
    import 'package:$projectName/config/di/di.dart';
    import 'package:$projectName/config/l10n/l10n.dart';
    import 'package:$projectName/config/themes/theme_manager.dart';
    import 'package:$projectName/core/blocs/locale/locale_bloc.dart';
    import 'package:$projectName/screens/setting/bloc/settings_bloc.dart';
    import 'package:$projectName/screens/setting/bloc/settings_event.dart';
    import 'package:$projectName/screens/setting/bloc/settings_state.dart';
    import 'package:$projectName/screens/setting/view/language_screen.dart';

    class SettingScreen extends StatelessWidget {
      const SettingScreen({super.key});

      static const String routeName = '/setting';

      @override
      Widget build(BuildContext context) {
        return BlocProvider(
          create: (context) => getIt<SettingsBloc>()..add(LoadSettings()),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: Text(context.l10n.settingScreenTitle),
                ),
                const SliverToBoxAdapter(
                  child: _SettingsContent(),
                ),
              ],
            ),
          ),
        );
      }
    }

    class _SettingsContent extends StatelessWidget {
      const _SettingsContent();

      @override
      Widget build(BuildContext context) {
        final theme = Theme.of(context);

        return BlocListener<LocaleBloc, LocaleState>(
          listener: (context, localeState) {
            // When locale changes, reload settings to sync the display
            context.read<SettingsBloc>().add(LoadSettings());
          },
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    theme,
                    title: 'Preferences',
                    children: [
                      _buildSettingTile(
                        context,
                        leading: const Icon(Icons.language),
                        title: 'Language',
                        subtitle: state.currentLanguage.languageName,
                        onTap: () => context.push(LanguageScreen.routeName),
                      ),
                      _buildSettingTile(
                        context,
                        leading: Icon(
                          context.watch<ThemeManager>().themeMode == ThemeMode.dark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                        ),
                        title: 'Theme',
                        subtitle: context.watch<ThemeManager>().themeMode ==
                                ThemeMode.dark
                            ? 'Dark Mode'
                            : 'Light Mode',
                        trailing: Switch(
                          value: context.watch<ThemeManager>().themeMode ==
                              ThemeMode.dark,
                          onChanged: (value) {
                            context.read<ThemeManager>().toggleTheme();
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildSection(
                    theme,
                    title: 'Notifications',
                    children: [
                      _buildSettingTile(
                        context,
                        leading: const Icon(Icons.notifications_active),
                        title: 'Push Notifications',
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {
                            // TODO: Implement push notifications
                          },
                        ),
                      ),
                      _buildSettingTile(
                        context,
                        leading: const Icon(Icons.email),
                        title: 'Email Notifications',
                        trailing: Switch(
                          value: false,
                          onChanged: (value) {
                            // TODO: Implement email notifications
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildSection(
                    theme,
                    title: 'About',
                    children: [
                      _buildSettingTile(
                        context,
                        leading: const Icon(Icons.info),
                        title: 'Version',
                        subtitle: '1.0.0',
                      ),
                      _buildSettingTile(
                        context,
                        leading: const Icon(Icons.privacy_tip),
                        title: 'Privacy Policy',
                        onTap: () {
                          // TODO: Navigate to privacy policy
                        },
                      ),
                      _buildSettingTile(
                        context,
                        leading: const Icon(Icons.description),
                        title: 'Terms of Service',
                        onTap: () {
                          // TODO: Navigate to terms of service
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      }

      Widget _buildSection(
        ThemeData theme, {
        required String title,
        required List<Widget> children,
      }) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: children,
                ),
              ),
            ],
          ),
        );
      }

      Widget _buildSettingTile(
        BuildContext context, {
        required Widget leading,
        required String title,
        String? subtitle,
        Widget? trailing,
        VoidCallback? onTap,
      }) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            child: leading,
          ),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing:
              trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
          onTap: onTap,
        );
      }
    }
    '''),
  );

  print('\nFolder structure and files generated successfully!');
  print('\nNext steps:');
  print('1. Run "flutter pub get" to install dependencies');
  print('2. Run "flutter gen-l10n" to generate localization files');
  print(
    '3. Run "flutter pub run build_runner build --delete-conflicting-outputs" if using code generation',
  );
  print('4. Register your services and repositories in lib/config/di/di.dart');
}

Future<void> _createFile(String path, String content) async {
  final file = File(path);
  await file.create(recursive: true);
  await file.writeAsString(content);
  print('Created $path');
}
