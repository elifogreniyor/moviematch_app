import 'user_model.dart';

class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AuthResponse(
      token: data['token'] ?? '',
      user: UserModel.fromJson(data),
    );
  }
}
