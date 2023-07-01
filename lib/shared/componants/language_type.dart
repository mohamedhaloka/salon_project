import 'package:flutter/material.dart';

enum LanguageType { arabic, english }

const String arabic = "ar";
const String english = "en";
const String assetPathLocation = "assets/translations";

const Locale arabicLocal = Locale("ar", "SA");
const Locale englishLocal = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.arabic:
        return arabic;
      case LanguageType.english:
        return english;
    }
  }
}
