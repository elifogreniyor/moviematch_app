import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sinflix/features/splash/presentation/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final FlutterSecureStorage storage;

  SplashCubit(this.storage) : super(SplashInitial());

  Future<void> checkAuthStatus() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(milliseconds: 1000));

    final token = await storage.read(key: 'access_token');

    if (token != null && token.isNotEmpty) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}