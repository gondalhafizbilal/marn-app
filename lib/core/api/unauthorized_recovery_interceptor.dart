import 'package:dio/dio.dart';

class UnauthorizedRecoveryInterceptor extends Interceptor {
  UnauthorizedRecoveryInterceptor();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    if (status == 401 || status == 403) {
      handler.next(err);
      return;
    }
    handler.next(err);
  }
}
