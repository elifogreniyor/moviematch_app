import 'package:bloc/bloc.dart';
import 'package:sinflix/presentation/login/viewmodel/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await Future.delayed(Duration(seconds: 2));

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Giriş başarısız."));
    }
  }
}
