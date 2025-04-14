import 'package:chat_bot_c2/core/di/di.dart';
import 'package:chat_bot_c2/core/l10n/localizations/app_localizations.dart';
import 'package:chat_bot_c2/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppConfigProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  AppConfigProvider(this.sharedPreferences);

  ThemeMode _themeMode = ThemeMode.dark;
  String _locale = "en";

  late AppLocalizations localizations;

  Future<void> changeThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await sharedPreferences.setBool(
      Constants.themeKey,
      _themeMode == ThemeMode.dark,
    );
    notifyListeners();
  }

  Future<void> changeLocale(String locale) async {
    _locale = locale;
    localizations = await AppLocalizations.delegate.load(Locale(locale));
    if(getIt.isRegistered<AppLocalizations>()){
      getIt.unregister<AppLocalizations>();
    }
    getIt.registerSingleton<AppLocalizations>(localizations);
    await sharedPreferences.setString(
      Constants.localeKey,
      _locale,
    );
    notifyListeners();
  }

  String getLocale(){
    return _locale;
  }

  ThemeMode getThemeMode(){
    return _themeMode;
  }

  bool isEn(){
    return _locale == "en";
  }

  bool isDark(){
    return _themeMode == ThemeMode.dark;
  }
}
