import 'package:camovies/core/blocs/appearance/appearance_bloc_bloc.dart';
import 'package:camovies/core/enum/app_language.dart';
import 'package:camovies/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camovies/config/di/di.dart';
import 'package:camovies/config/l10n/arb/app_localizations.dart';
import 'package:camovies/config/routes/app_router.dart';
import 'package:camovies/config/themes/theme_manager.dart';

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
          create: (context) => AppearanceBloc(getIt<StorageService>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<AppearanceBloc, AppearanceState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Camovies',
                theme: ThemeManager.getTheme(state.themeMode ?? ''),
                themeMode: ThemeManager.getThemeMode(
                  state.themeMode ?? '',
                ),
                routerConfig: goRouter,
                locale: Locale(
                  state.language?.code ?? AppLanguage.english.code,
                ),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLanguage.values
                    .map(
                      (lang) => Locale(lang.code, lang.countryCode),
                    )
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}
