import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<void> fetchAuth() async {
    // TODO: implement API call
    // final response = await dio.get('/endpoint');
  }
}
