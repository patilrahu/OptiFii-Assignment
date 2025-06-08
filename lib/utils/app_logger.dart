import 'dart:developer' as developer;

class AppLogger {
  static void info(String message, {String tag = 'INFO'}) {
    developer.log(
      message,
      name: tag,
      level: 800,
    );
  }

  static void error(String message,
      {String tag = 'ERROR', dynamic error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
