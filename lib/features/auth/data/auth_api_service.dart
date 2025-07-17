import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class AuthApiService {
  final Dio dio;

  AuthApiService() : dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/user/login',
        data: {'email': email, 'password': password},
      );
      debugPrint("API LOGIN response: ${response.data}");
      return response.data as Map<String, dynamic>;
    } catch (e) {
      if (e is DioException) {
        debugPrint("API LOGIN ERROR: ${e.response?.data}");
      } else {
        debugPrint("API LOGIN ERROR: $e");
      }
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
      debugPrint("API REGISTER response: ${response.data}");
      return response.data as Map<String, dynamic>;
    } catch (e) {
      if (e is DioException) {
        debugPrint("API REGISTER ERROR: ${e.response?.data}");
      } else {
        debugPrint("API REGISTER ERROR: $e");
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await dio.get(
      '/user/profile',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response.data as Map<String, dynamic>;
  }
}
