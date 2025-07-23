part of 'appearance_bloc_bloc.dart';

enum AppearanceStatus { initial, loading, success, failure }

class AppearanceState extends Equatable {
  const AppearanceState({
    required this.status,
    this.language,
    this.themeMode,
  });

  final AppearanceStatus status;
  final AppLanguage? language;
  final String? themeMode;

  AppearanceState copyWith({
    AppearanceStatus? status,
    AppLanguage? language,
    String? themeMode,
  }) {
    return AppearanceState(
      status: status ?? this.status,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [status, language, themeMode];
}
