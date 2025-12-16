import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late final String environment;
  static late final String apiBaseUrl;

  static Future<void> load() async {
    const env = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'development',
    );

    if (kIsWeb) {
      // Web -> dart-define only
      apiBaseUrl = const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: '',
      );
    } else {
      // Mobile -> dotenv
      await dotenv.load(
        fileName: env == 'production'
            ? '.env.production'
            : '.env.development',
      );

      environment = env;
      apiBaseUrl = dotenv.env['API_BASE_URL']!;
    }
  }
}
