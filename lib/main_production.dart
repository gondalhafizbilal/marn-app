import 'package:firebase_core/firebase_core.dart';
import 'package:marn/bootstrap.dart';
import 'package:marn/core/config/app_flavor.dart';

Future<void> main() async {
  await bootstrap(
    flavor: AppFlavor.production,
    envFile: '.env.production',
    firebaseOptions: const FirebaseOptions(
      apiKey: 'production-placeholder',
      appId: '1:000000000000:android:production',
      messagingSenderId: 'production',
      projectId: 'marn-production',
    ),
  );
}
