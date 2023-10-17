 import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_maneger.dart';
 const String appPrefsKey = "ppPrefsKey";
class AppPreferences{
  final SharedPreferences _sharedPreferences;

   AppPreferences(this._sharedPreferences);

   Future <String> getAppLang()async{

    String? language =  _sharedPreferences.getString(appPrefsKey);

    if(language!=null && language.isNotEmpty){
      return language;
    }else{
      // default lang
      return LangaugeType.english.getLanguage();
    }

   }
 }