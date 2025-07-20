import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;
  LoggerService._internal();

  final Logger _logger = Logger();

  void info(String message) => _logger.i(message);

  void warning(String message) => _logger.w(message);

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (error != null && stackTrace != null) {
      _logger.e('$message – $error\n$stackTrace');
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: message,
      );
    } else {
      _logger.e(message);
      FirebaseCrashlytics.instance.log(message);
    }
  }

  void logEvent(String name, {Map<String, Object?>? params}) {
    _logger.i('Analytics event: $name – $params');
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: params?.map((k, v) => MapEntry(k, v as Object)),
    );
  }
}
