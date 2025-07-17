import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> register() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const RegisterState(isLoading: false));
    } catch (e) {
      emit(RegisterState(isLoading: false, error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
