import 'package:talker/talker.dart';

class AppLogger {
  AppLogger({Talker? talker}) : _talker = talker ?? _sharedTalker;

  static final Talker _sharedTalker = Talker();

  final Talker _talker;

  void logInfo(String message, [Map<String, Object?>? data]) {
    _talker.info(_format(message, data));
  }

  void logError(
    String message,
    Object error,
    StackTrace stackTrace, [
    Map<String, Object?>? data,
  ]) {
    _talker.error(_format(message, data), error, stackTrace);
  }

  void logTransactionStart(String action, Map<String, Object?> data) {
    logInfo('Transaction start: $action', data);
  }

  void logTransactionSuccess(String action, Map<String, Object?> data) {
    logInfo('Transaction success: $action', data);
  }

  void logTransactionError(
    String action,
    Object error,
    StackTrace stackTrace,
    Map<String, Object?> data,
  ) {
    logError('Transaction error: $action', error, stackTrace, data);
  }

  String _format(String message, Map<String, Object?>? data) {
    if (data == null || data.isEmpty) return message;
    return '$message | data=${_sanitize(data)}';
  }

  Map<String, Object?> _sanitize(Map<String, Object?> data) {
    return Map.unmodifiable(
      Map.fromEntries(data.entries.where((entry) => entry.value != null)),
    );
  }
}
