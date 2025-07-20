import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'package:sinflix/firebase_options.dart';
import 'package:sinflix/l10n/app_localizations.dart';
import 'package:sinflix/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
  final secureStorage = FlutterSecureStorage();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit(secureStorage)),
        BlocProvider(
          create: (_) => AuthCubit(AuthRepository(AuthApiService(dio))),
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;
  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: _locale,
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
