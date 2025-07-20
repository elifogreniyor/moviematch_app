import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio;
  AuthApiService(this.dio);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/user/login',
        data: {'email': email, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/user/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
