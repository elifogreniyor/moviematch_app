import 'package:dio/dio.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class AuthApiService {
  final Dio dio;

  AuthApiService() : dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/user/login',
      data: {'email': email, 'password': password},
    );
    return response.data as Map<String, dynamic>;
  }
}
