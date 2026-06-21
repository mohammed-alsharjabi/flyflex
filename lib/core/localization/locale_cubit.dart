import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(this._prefs)
      : super(const LocaleState(locale: Locale('ar'))) {
    _loadSaved();
  }

  final SharedPreferences _prefs;

  static const _prefKey = 'app_locale';

  static const supportedLocales = [Locale('ar'), Locale('en')];

  void _loadSaved() {
    final saved = _prefs.getString(_prefKey);
    if (saved != null && saved.isNotEmpty) {
      emit(LocaleState(locale: Locale(saved)));
    }
    // Falls through to default Arabic when no pref is stored
  }

  /// Switch to a specific locale and persist the preference.
  void setLocale(Locale locale) {
    assert(
      supportedLocales.any((l) => l.languageCode == locale.languageCode),
      'Locale ${locale.languageCode} is not in supportedLocales',
    );
    _prefs.setString(_prefKey, locale.languageCode);
    emit(LocaleState(locale: locale));
  }

  /// Toggle between Arabic and English.
  void toggleLocale() {
    setLocale(state.isArabic ? const Locale('en') : const Locale('ar'));
  }
}
