import 'package:sinflix/core/services/logger_service.dart';
import 'package:sinflix/features/auth/data/auth_api_service.dart';
import 'package:sinflix/features/auth/domain/models/auth_response.dart';

class AuthRepository {
  final AuthApiService apiService;
  final logger = LoggerService();
  AuthRepository(this.apiService);

  Future<AuthResponse> login(String email, String password) async {
    logger.info("Login API call: $email");
    final data = await apiService.login(email: email, password: password);
    logger.info("Login API Response: $data");
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> register(
    String name,
    String email,
    String password,
  ) async {
    logger.info("Register API call: $email");
    final data = await apiService.register(
      name: name,
      email: email,
      password: password,
    );
    logger.info("Register API Response: $data");
    return AuthResponse.fromJson(data);
  }
}
