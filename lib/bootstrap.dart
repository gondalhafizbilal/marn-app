import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marn/core/cache/cache_helper.dart';
import 'package:marn/core/config/app_config.dart';
import 'package:marn/core/config/app_flavor.dart';
import 'package:marn/core/services/service_locator.dart';
import 'package:marn/config/localization/cubit/localizations_cubit.dart';
import 'package:marn/core/services/session_cubit.dart';
import 'package:marn/marn_app.dart';

Future<void> bootstrap({
  required AppFlavor flavor,
  required String envFile,
  required FirebaseOptions firebaseOptions,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: envFile);
  AppConfig.initialize(flavor: flavor, envFile: envFile);
  await setupServiceLocator();
  await sl<CacheHelper>().init();
  await sl<LocalizationsCubit>().hydrate();
  await sl<SessionCubit>().hydrate();
  unawaited(Firebase.initializeApp(options: firebaseOptions));
  runApp(const MarnApp());
}
