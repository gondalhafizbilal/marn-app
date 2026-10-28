import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marn/core/cache/cache_helper.dart';
import 'package:marn/core/cache/secure_cache_storage.dart';
import 'package:marn/core/constants/app_defaults.dart';

class SessionState extends Equatable {
  const SessionState({
    required this.languageCode,
    required this.currencyCode,
    required this.isLoggedIn,
  });

  final String languageCode;
  final String currencyCode;
  final bool isLoggedIn;

  @override
  List<Object> get props => [languageCode, currencyCode, isLoggedIn];

  SessionState copyWith({
    String? languageCode,
    String? currencyCode,
    bool? isLoggedIn,
  }) {
    return SessionState(
      languageCode: languageCode ?? this.languageCode,
      currencyCode: currencyCode ?? this.currencyCode,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required this.cache, required this.secureCache})
      : super(
          const SessionState(
            languageCode: AppDefaults.defaultLanguageCode,
            currencyCode: AppDefaults.defaultCurrencyCode,
            isLoggedIn: false,
          ),
        );

  final CacheHelper cache;
  final SecureCacheHelper secureCache;

  Future<void> hydrate() async {
    final language = cache.getDataString(key: 'languageCode') ??
        AppDefaults.defaultLanguageCode;
    final currency = cache.getDataString(key: 'currencyCode') ??
        AppDefaults.defaultCurrencyCode;
    final token = (await secureCache.getData(key: 'token')) ?? '';
    emit(
      state.copyWith(
        languageCode: language,
        currencyCode: currency,
        isLoggedIn: token.trim().isNotEmpty,
      ),
    );
  }

  Future<void> setLanguage(String languageCode) async {
    await cache.saveData(key: 'languageCode', value: languageCode);
    emit(state.copyWith(languageCode: languageCode));
  }

  Future<void> setCurrency(String currencyCode) async {
    await cache.saveData(key: 'currencyCode', value: currencyCode);
    emit(state.copyWith(currencyCode: currencyCode));
  }

  Future<void> setLoggedIn(bool value) async {
    emit(state.copyWith(isLoggedIn: value));
  }
}
