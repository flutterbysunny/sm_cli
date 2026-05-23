import 'dart:io';

/// Generates a complete API layer using Dio for the given Flutter project.
///
/// Creates the following files:
/// - `dio_client.dart` — singleton Dio instance
/// - `api_endpoints.dart` — API endpoint constants
/// - `response_wrapper.dart` — typed response wrapper
/// - `network_exceptions.dart` — error handler
/// - `interceptors/logging_interceptor.dart` — request/response logger
///
/// Example:
/// ```bash
/// sm make api my_app
/// ```

Future<void> generateApi({required String projectName}) async {
  final basePath = '$projectName/lib/core/network';
  final interceptorPath = '$basePath/interceptors';

  Directory(basePath).createSync(recursive: true);
  Directory(interceptorPath).createSync(recursive: true);

  File('$basePath/dio_client.dart').writeAsStringSync('''
import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(LoggingInterceptor());
  }
}
''');

  File('$basePath/api_endpoints.dart').writeAsStringSync('''
class ApiEndpoints {
  static const baseUrl = "https://api.example.com";

  static const login = "/login";
  static const register = "/register";
}
''');

  File('$basePath/response_wrapper.dart').writeAsStringSync('''
class ResponseWrapper<T> {
  final T? data;
  final String? error;
  final int? statusCode;

  ResponseWrapper({
    this.data,
    this.error,
    this.statusCode,
  });

  bool get isSuccess => error == null;
}
''');

  File('$basePath/network_exceptions.dart').writeAsStringSync('''
class NetworkExceptions {
  static String handleError(dynamic error) {
    if (error is Exception) {
      return error.toString();
    }
    return "Unknown error occurred";
  }
}
''');

  File('$interceptorPath/logging_interceptor.dart').writeAsStringSync('''
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, handler) {
    print("➡️ REQUEST: \${options.method} \${options.path}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, handler) {
    print("✅ RESPONSE: \${response.statusCode}");
    handler.next(response);
  }

  @override
  void onError(DioException err, handler) {
    print("❌ ERROR: \${err.message}");
    handler.next(err);
  }
}
''');

  print('🌐 API layer generated successfully');
}