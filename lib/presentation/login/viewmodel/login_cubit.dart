import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:popcorndate/presentation/login/viewmodel/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const LoginState());
    } catch (e) {
      emit(LoginState(isLoading: false, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
