class LoginState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  LoginState({this.isLoading = false, this.error, this.isSuccess = false});

  LoginState copyWith({bool? isLoading, String? error, bool? isSuccess}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
