import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camovies/core/blocs/appearance/appearance_bloc_bloc.dart';
import 'package:camovies/core/services/storage_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<StorageService>(StorageService(prefs));

  // Blocs
  getIt.registerFactory<AppearanceBloc>(
    () => AppearanceBloc(getIt<StorageService>()),
  );
}
