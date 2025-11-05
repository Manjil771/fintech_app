import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTimeInterceptor extends Interceptor {
  static const String _lastTimeKey = "last_request_time";

  Future<DateTime?> _getStoredTime() async {
    final prefs = await SharedPreferences.getInstance();
    final millis = prefs.getInt(_lastTimeKey);
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  Future<void> _storeTime(DateTime dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastTimeKey, dateTime.millisecondsSinceEpoch);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final now = DateTime.now();
    final storedTime = await _getStoredTime();

    if (storedTime != null) {
      final difference = now.difference(storedTime);

      if (difference.inSeconds >= 10) {
        handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              data: {
                "code": 'SESSION_TIMEOUT',
                "responseStatus": 'SESSION_TIMEOUT'
              },
              statusCode: 403,
            ),
            type: DioExceptionType.unknown,
          ),
        );
        print("⏰ More than 5 minutes passed! Triggering action...");
      } else {
        print("⏱ Less than 5 minutes, updating stored time.");
        await _storeTime(now);
      }
    } else {
      await _storeTime(now);
    }

    return handler.next(options);
  }
}
