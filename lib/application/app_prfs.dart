import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_maneger.dart';

const String prefsKeyLangPrefsKey = "appLangPrefsKey";
const String prefsKeyOnBoardingScreenViewed = "appOnBoardingScreenViewed";
const String prefsKeyUserLoggedIn = "appUserLoggedIn";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLang() async {
    String? language = _sharedPreferences.getString(prefsKeyLangPrefsKey);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // default lang
      return LangaugeType.english.getLanguage();
    }
  }
   // onBoarding
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnBoardingScreenViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnBoardingScreenViewed) ?? false;
  }

  // login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyUserLoggedIn) ?? false;
  }



}
