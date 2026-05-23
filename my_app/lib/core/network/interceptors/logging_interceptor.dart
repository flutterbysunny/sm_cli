import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, handler) {
    print("➡️ REQUEST: ${options.method} ${options.path}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, handler) {
    print("✅ RESPONSE: ${response.statusCode}");
    handler.next(response);
  }

  @override
  void onError(DioException err, handler) {
    print("❌ ERROR: ${err.message}");
    handler.next(err);
  }
}
