enum AppFlavor { development, production }

extension AppFlavorX on AppFlavor {
  bool get isProduction => this == AppFlavor.production;

  String get name => switch (this) {
    AppFlavor.development => 'development',
    AppFlavor.production => 'production',
  };
}
