enum AuthAction { login, register }

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final AuthAction? action;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.action,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
    AuthAction? action,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
      action: action,
    );
  }
}
