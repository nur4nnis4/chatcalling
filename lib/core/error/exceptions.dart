class PlatformException implements Exception {
  final String message;

  PlatformException({required this.message});
}

class CacheException implements Exception {}

class PluginException implements Exception {}
