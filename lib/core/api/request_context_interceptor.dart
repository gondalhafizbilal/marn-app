import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:marn/core/cache/cache_helper.dart';
import 'package:marn/core/cache/secure_cache_storage.dart';
import 'package:marn/core/constants/app_defaults.dart';
import 'package:marn/core/services/service_locator.dart';
import 'package:uuid/uuid.dart';

class RequestContextInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final guestId = await _guestId();
    options.headers.putIfAbsent('x-guest-id', () => guestId);

    final token = await sl<SecureCacheHelper>().getData(key: 'token');
    if (token != null && token.trim().isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer ${token.trim()}');
    }

    final cache = sl<CacheHelper>();
    final language = cache.getDataString(key: 'languageCode')?.trim();
    final currency = cache.getDataString(key: 'currencyCode')?.trim();

    final query = Map<String, dynamic>.from(options.queryParameters);
    if (language != null && language.isNotEmpty) {
      query.putIfAbsent('lang', () => language);
      query.putIfAbsent('language', () => language);
    } else {
      query.putIfAbsent('lang', () => AppDefaults.defaultLanguageCode);
    }
    if (currency != null && currency.isNotEmpty) {
      query.putIfAbsent('currency', () => currency.toLowerCase());
    } else {
      query.putIfAbsent('currency', () => AppDefaults.defaultCurrencyCode);
    }
    options.queryParameters = query;

    if (options.data is Map || (options.data is String && options.data.toString().isNotEmpty)) {
      final body = _decodeBody(options.data);
      if (body.isNotEmpty && currency != null && currency.isNotEmpty) {
        body.putIfAbsent('currency', () => currency.toLowerCase());
      }
      options.data = body.isEmpty ? options.data : body;
    }

    handler.next(options);
  }

  Future<String> _guestId() async {
    final secure = sl<SecureCacheHelper>();
    final existing = await secure.getData(key: 'guestId');
    if (existing != null && existing.trim().isNotEmpty) return existing.trim();
    final guestId = const Uuid().v4();
    await secure.saveData(key: 'guestId', value: guestId);
    return guestId;
  }

  Map<String, dynamic> _decodeBody(dynamic data) {
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) {
          return decoded.map((key, value) => MapEntry(key.toString(), value));
        }
      } catch (_) {}
    }
    return <String, dynamic>{};
  }
}
