import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../componants/language_type.dart';

const String pressKeyLanguage = "PREFS_KEY_LANG";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(pressKeyLanguage);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.arabic.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      // set english
      _sharedPreferences.setString(
          pressKeyLanguage, LanguageType.english.getValue());
    } else {
      // set arabic
      _sharedPreferences.setString(
          pressKeyLanguage, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocal;
    } else {
      return englishLocal;
    }
  }

  static late SharedPreferences cacheHelper;

  static init() async {
    cacheHelper = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData(String key, value) async {
    if (value is bool) {
      return await cacheHelper.setBool(key, value);
    }
    if (value is String) {
      return await cacheHelper.setString(key, value);
    }
    if (value is int) {
      return await cacheHelper.setInt(key, value);
    }
    return null;
  }

  static  getData(String? key) {
    return  cacheHelper.get(key!);
  }


  static Future<bool> removeData(String? key) {
    return cacheHelper.remove(key!);
  }
}