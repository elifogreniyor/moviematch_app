import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/presentation/register/viewmodel/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  Future<void> register(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await Future.delayed(Duration(seconds: 2)); 

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Kayıt başarısız."));
    }
  }
}
