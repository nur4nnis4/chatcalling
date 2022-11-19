import 'package:flutter/foundation.dart';

abstract class CheckPlatform {
  bool isWeb();
}

class CheckPlatformImpl implements CheckPlatform {
  @override
  bool isWeb() {
    return kIsWeb;
  }
}
