import 'package:get_it/get_it.dart';
import 'package:marn/config/localization/cubit/localizations_cubit.dart';
import 'package:marn/core/services/dependencies/init_core.dart';
import 'package:marn/core/services/dependencies/init_networking.dart';
import 'package:marn/core/services/dependencies/init_repositories.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await initCore();
  await initNetworking();
  await initRepositories();
  sl.registerSingleton<LocalizationsCubit>(LocalizationsCubit());
}
