import 'package:marn/core/api/api_consumer.dart';
import 'package:marn/core/api/dio_consumer.dart';
import 'package:marn/core/services/service_locator.dart';

Future<void> initNetworking() async {
  sl.registerSingleton<ApiConsumer>(DioConsumer(dio: sl()));
}
