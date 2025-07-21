import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/core/utils/secure_storage_helper.dart';
import 'package:sinflix/features/auth/data/auth_repository.dart';
import 'package:sinflix/features/auth/presentation/cubit/auth_state.dart';
import 'package:sinflix/core/services/logger_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final logger = LoggerService();

  AuthCubit(this.repository) : super(AuthState());
  Future<void> login(String email, String password) async {
    emit(
      state.copyWith(isLoading: true, error: null, action: AuthAction.login),
    );
    try {
      final response = await repository.login(email, password);
      await SecureStorageHelper.saveToken(response.token);
      logger.info("Login başarılı. Token: ${response.token}");
      logger.logEvent('login_success', params: {'email': email});
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e, stack) {
      logger.error('Login sırasında hata oluştu', e, stack);
      logger.logEvent('login_failed');
      emit(state.copyWith(isLoading: false, error: 'login_failed'));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(
      state.copyWith(isLoading: true, error: null, action: AuthAction.register),
    );
    try {
      final response = await repository.register(name, email, password);
      await SecureStorageHelper.saveToken(response.token);
      logger.info("Register başarılı. Token: ${response.token}");
      logger.logEvent('register_success', params: {'email': email});
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e, stack) {
      logger.error('Register sırasında hata oluştu', e, stack);
      logger.logEvent('register_failed');
      emit(state.copyWith(isLoading: false, error: 'register_failed'));
    }
  }

  Future<void> logout() async {
    await SecureStorageHelper.deleteToken();
    logger.info("Kullanıcı çıkış yaptı, token silindi.");
    logger.logEvent('logout');
  }
}
