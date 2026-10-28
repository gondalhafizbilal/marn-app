import 'package:dio/dio.dart';
import 'package:marn/core/api/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(Object error) {
    if (error is DioException) {
      return ApiErrorModel(
        message: error.message ?? 'Network request failed',
        statusCode: error.response?.statusCode,
      );
    }
    return ApiErrorModel(message: error.toString());
  }
}
