import 'package:firebase_core/firebase_core.dart';
import 'package:marn/bootstrap.dart';
import 'package:marn/core/config/app_flavor.dart';

Future<void> main() async {
  await bootstrap(
    flavor: AppFlavor.development,
    envFile: '.env.development',
    firebaseOptions: const FirebaseOptions(
      apiKey: 'development-placeholder',
      appId: '1:000000000000:android:development',
      messagingSenderId: 'development',
      projectId: 'marn-development',
    ),
  );
}
