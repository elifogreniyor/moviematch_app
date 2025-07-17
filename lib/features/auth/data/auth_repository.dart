import 'package:flutter/material.dart';
import 'package:sinflix/features/auth/data/auth_api_service.dart';
import 'package:sinflix/features/auth/domain/models/auth_response.dart';

class AuthRepository {
  final AuthApiService apiService;
  AuthRepository(this.apiService);

  Future<AuthResponse> login(String email, String password) async {
    final data = await apiService.login(email: email, password: password);
    debugPrint("Login API Response: $data");
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> register(
    String name,
    String email,
    String password,
  ) async {
    final data = await apiService.register(
      name: name,
      email: email,
      password: password,
    );
    debugPrint("Register API Response: $data");
    return AuthResponse.fromJson(data);
  }
}
