import 'package:camovies/core/constants/app_constants.dart';
import 'package:camovies/core/enum/app_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> setLanguage(AppLanguage language) async {
    await setString(AppConstants.languageKey, language.code);
  }

  AppLanguage getLanguage() {
    final languageCode = getString(AppConstants.languageKey);

    return AppLanguage.getLanguage(languageCode);
  }
}
