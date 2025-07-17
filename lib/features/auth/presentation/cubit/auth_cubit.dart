import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sinflix/features/auth/data/auth_repository.dart';
import 'package:sinflix/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final FlutterSecureStorage storage;
  AuthCubit(this.repository, this.storage) : super(AuthState());
  Future<void> login(String email, String password) async {
    emit(
      state.copyWith(isLoading: true, error: null, action: AuthAction.login),
    );
    try {
      final response = await repository.login(email, password);
      await storage.write(key: 'token', value: response.token);
      final test = await storage.read(key: 'token');
      debugPrint("Login sonrası kaydedilen token: $test");
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'login_failed'));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(
      state.copyWith(isLoading: true, error: null, action: AuthAction.register),
    );
    try {
      final response = await repository.register(name, email, password);
      await storage.write(key: 'token', value: response.token);
      final test = await storage.read(key: 'token');
      debugPrint("Register sonrası kaydedilen token: $test");
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'register_failed'));
    }
  }

  Future<void> logout() async {
  await storage.delete(key: 'token');
  debugPrint("Token silindi, kullanıcı çıkış yaptı.");
}
}
