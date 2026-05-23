import 'dart:io';

Future<void> makeApi({required String projectName}) async {
  final basePath = '$projectName/lib/core/network';

  final interceptorPath = '$basePath/interceptors';

  Directory(basePath).createSync(recursive: true);
  Directory(interceptorPath).createSync(recursive: true);

  // 🌐 DIO CLIENT (PRO SAFE)
  File('$basePath/dio_client.dart').writeAsStringSync(_dioClient());

  // 📡 API ENDPOINTS
  File('$basePath/api_endpoints.dart').writeAsStringSync(_apiEndpoints());

  // 📦 API RESULT WRAPPER
  File('$basePath/response_wrapper.dart').writeAsStringSync(_responseWrapper());

  // ⚠️ EXCEPTIONS
  File('$basePath/network_exceptions.dart').writeAsStringSync(_exceptions());

  // 🪵 LOGGING INTERCEPTOR
  File('$interceptorPath/logging_interceptor.dart')
      .writeAsStringSync(_loggingInterceptor());

  print('🌐 API PRO SAFE SYSTEM GENERATED SUCCESSFULLY');
}

String _dioClient() => '''
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
''';

String _apiEndpoints() => '''
class ApiEndpoints {
  static const baseUrl = "https://api.example.com";

  static const login = "/login";
  static const register = "/register";
}
''';

String _responseWrapper() => '''
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
''';

String _exceptions() => '''
class NetworkExceptions {
  static String handleError(dynamic error) {
    if (error is Exception) {
      return error.toString();
    }
    return "Unknown error occurred";
  }
}
''';

String _loggingInterceptor() => '''
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
''';