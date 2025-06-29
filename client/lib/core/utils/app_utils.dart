import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppUtils {
  /// Exits the application gracefully.
  static void exitApp() {
    if (Platform.isAndroid || Platform.isIOS) {
      SystemNavigator.pop();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS || Platform.isFuchsia) {
      exit(0);
    }
  }

  /// Checks if the current platform is a mobile platform (Android or iOS).
  static bool isMobilePlatform() {
    return Platform.isAndroid || Platform.isIOS;
  }

  /// Checks if the current platform is a desktop platform (Windows, Linux, MacOS, or Fuchsia).
  static bool isDesktopPlatform() {
    return Platform.isWindows || Platform.isLinux || Platform.isMacOS || Platform.isFuchsia;
  }

  /// Checks if the current platform is a web platform.
  static bool isWebPlatform() {
    return kIsWeb;
  }

  /// Checks if the current platform is valid for the app.
  static bool isValidPlatform() {
    return isMobilePlatform() || isDesktopPlatform() || isWebPlatform();
  }
}
