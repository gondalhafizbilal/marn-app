import 'package:dio/dio.dart';
import 'package:marn/core/api/api_consumer.dart';
import 'package:marn/core/api/request_context_interceptor.dart';
import 'package:marn/core/api/unauthorized_recovery_interceptor.dart';
import 'package:marn/core/config/app_config.dart';

class DioConsumer implements ApiConsumer {
  DioConsumer({required this.dio}) {
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.sendTimeout = const Duration(seconds: 30);
    dio.interceptors.add(RequestContextInterceptor());
    dio.interceptors.add(UnauthorizedRecoveryInterceptor());
    if (AppConfig.instance.enableNetworkLogs) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  final Dio dio;

  @override
  Future<Response<dynamic>> delete(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) {
    return dio.delete(path,
        data: data, queryParameters: queryParameters, options: Options(headers: headers));
  }

  @override
  Future<Response<dynamic>> get(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) {
    return dio.get(path,
        data: data, queryParameters: queryParameters, options: Options(headers: headers));
  }

  @override
  Future<Response<dynamic>> patch(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) {
    return dio.patch(path,
        data: data, queryParameters: queryParameters, options: Options(headers: headers));
  }

  @override
  Future<Response<dynamic>> post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) {
    return dio.post(path,
        data: data, queryParameters: queryParameters, options: Options(headers: headers));
  }

  @override
  Future<Response<dynamic>> put(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) {
    return dio.put(path,
        data: data, queryParameters: queryParameters, options: Options(headers: headers));
  }
}
