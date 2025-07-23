import 'package:bloc/bloc.dart';
import 'package:camovies/core/constants/app_constants.dart';
import 'package:camovies/core/enum/app_language.dart';
import 'package:camovies/core/services/storage_service.dart';
import 'package:equatable/equatable.dart';

part 'appearance_event.dart';
part 'appearance_state.dart';

class AppearanceBloc extends Bloc<AppearanceEvent, AppearanceState> {
  AppearanceBloc(this._storageService)
      : super(
          AppearanceState(
            status: AppearanceStatus.initial,
            language: _storageService.getLanguage(),
            themeMode: _storageService.getString(AppConstants.themeModeKey),
          ),
        ) {
    on<ChangeLanguage>(_onChangeLanguage);
    on<ChangeThemeMode>(_onChangeThemeMode);
  }

  final StorageService _storageService;

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<AppearanceState> emit,
  ) async {
    emit(state.copyWith(status: AppearanceStatus.loading));

    try {
      _storageService.setLanguage(event.language);

      emit(state.copyWith(
        status: AppearanceStatus.success,
        language: event.language,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AppearanceStatus.failure,
      ));
    }
  }

  Future<void> _onChangeThemeMode(
    ChangeThemeMode event,
    Emitter<AppearanceState> emit,
  ) async {
    emit(state.copyWith(status: AppearanceStatus.loading));

    try {
      _storageService.setString(
        AppConstants.themeModeKey,
        event.themeMode,
      );

      emit(state.copyWith(
        status: AppearanceStatus.success,
        themeMode: event.themeMode,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AppearanceStatus.failure,
      ));
    }
  }
}
