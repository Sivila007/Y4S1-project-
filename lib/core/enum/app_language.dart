enum AppLanguage {
  english(code: 'en', countryCode: 'US', languageName: 'English'),
  khmer(code: 'km', countryCode: 'KH', languageName: 'Khmer');

  const AppLanguage({
    required this.code,
    required this.countryCode,
    required this.languageName,
  });

  final String code;
  final String countryCode;
  final String languageName;

  static AppLanguage getLanguage(String? languageCode) {
    return AppLanguage.values.firstWhere(
      (language) => language.code == languageCode,
      orElse: () => AppLanguage.english,
    );
  }
}
