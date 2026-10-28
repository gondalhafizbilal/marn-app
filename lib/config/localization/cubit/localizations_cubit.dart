import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/core/cache/cache_helper.dart';
import 'package:marn/core/constants/app_defaults.dart';
import 'package:marn/core/services/service_locator.dart';

class LocalizationsCubit extends Cubit<Locale> {
  LocalizationsCubit()
      : super(const Locale(AppDefaults.defaultLanguageCode));

  Future<void> hydrate() async {
    final saved = sl<CacheHelper>().getDataString(key: 'languageCode');
    if (saved != null && saved.trim().isNotEmpty) {
      emit(Locale(saved.trim()));
    }
  }

  Future<void> setLanguage(String code) async {
    await sl<CacheHelper>().saveData(key: 'languageCode', value: code);
    emit(Locale(code));
  }
}
