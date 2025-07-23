part of 'appearance_bloc_bloc.dart';

abstract class AppearanceEvent extends Equatable {
  const AppearanceEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends AppearanceEvent {
  final AppLanguage language;

  const ChangeLanguage(this.language);

  @override
  List<Object> get props => [language];
}

class ChangeThemeMode extends AppearanceEvent {
  final String themeMode;

  const ChangeThemeMode(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}
