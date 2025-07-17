import 'package:sinflix/features/auth/data/auth_api_service.dart';
import 'package:sinflix/features/auth/domain/models/auth_response.dart';

class AuthRepository {
  final AuthApiService apiService;
  AuthRepository(this.apiService);

  Future<AuthResponse> login(String email, String password) async {
    final data = await apiService.login(email: email, password: password);
    return AuthResponse.fromJson(data);
  }

  // Register için de benzer fonksiyon, istersen sonra ekleriz.
}
