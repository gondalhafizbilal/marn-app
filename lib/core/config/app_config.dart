import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marn/core/config/app_flavor.dart';

class AppConfig {
  const AppConfig._({
    required this.flavor,
    required this.envFile,
    required this.baseUrl,
    required this.chatbotBaseUrl,
    required this.googleMapsApiKey,
    required this.enableNetworkLogs,
  });

  final AppFlavor flavor;
  final String envFile;
  final String baseUrl;
  final String chatbotBaseUrl;
  final String googleMapsApiKey;
  final bool enableNetworkLogs;

  static late final AppConfig instance;

  static void initialize({required AppFlavor flavor, required String envFile}) {
    instance = AppConfig._(
      flavor: flavor,
      envFile: envFile,
      baseUrl: dotenv.env['BASE_URL']?.trim().isNotEmpty == true
          ? dotenv.env['BASE_URL']!.trim()
          : 'https://api.example.com',
      chatbotBaseUrl: dotenv.env['CHATBOT_BASE_URL']?.trim().isNotEmpty == true
          ? dotenv.env['CHATBOT_BASE_URL']!.trim()
          : 'https://chat.example.com',
      googleMapsApiKey: dotenv.env['GOOGLE_MAPS_API_KEY']?.trim() ?? '',
      enableNetworkLogs:
          dotenv.env['ENABLE_NETWORK_LOGS']?.toLowerCase() == 'true',
    );
  }

  String get runtimeEnvironmentMarker => '${flavor.name}:$envFile';
}
