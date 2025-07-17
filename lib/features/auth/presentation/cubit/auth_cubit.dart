import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null, action: AuthAction.login));
    try {
      await Future.delayed(Duration(seconds: 2));
      // Burada API çağrısı olacak, token kaydedilecek
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'login_failed'));
    }
  }

  Future<void> register(String name,String email, String password, String confirmPassword) async {
    emit(state.copyWith(isLoading: true, error: null, action: AuthAction.register));
    try {
      await Future.delayed(Duration(seconds: 2));
      // Burada API çağrısı olacak, token kaydedilecek
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'register_failed'));
    }
  }
}