import 'package:dio/dio.dart';
import 'package:marn/core/cache/cache_helper.dart';
import 'package:marn/core/cache/secure_cache_storage.dart';
import 'package:marn/core/services/session_cubit.dart';
import 'package:marn/core/services/service_locator.dart';

Future<void> initCore() async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<CacheHelper>(CacheHelper());
  sl.registerSingleton<SecureCacheHelper>(SecureCacheHelper());
  sl.registerSingleton<SessionCubit>(
    SessionCubit(cache: sl<CacheHelper>(), secureCache: sl<SecureCacheHelper>()),
  );
}
