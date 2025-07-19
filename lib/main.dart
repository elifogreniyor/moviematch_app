import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/features/auth/data/auth_api_service.dart';
import 'package:sinflix/features/auth/data/auth_repository.dart';
import 'package:sinflix/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sinflix/features/discover/data/discover_api_service.dart';
import 'package:sinflix/features/discover/presentation/cubit/discover_cubit.dart';
import 'package:sinflix/features/profile/data/profile_api_service.dart';
import 'package:sinflix/features/profile/data/profile_repository.dart';
import 'package:sinflix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sinflix/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sinflix/l10n/app_localizations.dart';
import 'package:sinflix/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
  final secureStorage = FlutterSecureStorage();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit(secureStorage)),
        BlocProvider(
          create: (_) =>
              AuthCubit(AuthRepository(AuthApiService(dio)), secureStorage),
        ),
        BlocProvider(create: (_) => DiscoverCubit(DiscoverApiService(dio))),
        BlocProvider(
          create: (_) => ProfileCubit(
            ProfileRepository(ProfileApiService(dio)),
            secureStorage,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SinFlix',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
