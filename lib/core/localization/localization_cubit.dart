import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../locator.dart' as di;
import '../services/cach_services.dart';

class LocalizationCubit extends Cubit<Locale?> {
  LocalizationCubit() : super(null);

  static const _key = 'app_locale_code';

  Future<void> loadSaved() async {
    final code = di.getIt<CacheService>().storage.getString(_key);
    if (code == null || code.isEmpty) {
      emit(null); // system locale
    } else {
      emit(Locale(code));
    }
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await di.getIt<CacheService>().storage.remove(_key);
      emit(null);
    } else {
      await di.getIt<CacheService>().storage.setString(_key, locale.languageCode);
      emit(locale);
    }
  }
}
