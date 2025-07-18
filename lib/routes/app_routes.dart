import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sinflix/features/home/presentation/view/home_page.dart';
import 'package:sinflix/features/auth/presentation/view/login_page.dart';
import 'package:sinflix/features/auth/presentation/view/register_page.dart';
import 'package:sinflix/features/profile_photo/presentation/view/profile_photo_page.dart';
import 'package:sinflix/features/splash/presentation/view/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/upload', builder: (context, state) => const ProfilePhotoPage()),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: LoginPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          );
        },
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child:RegisterPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          );
        },
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          );
        },
      ),
    ],
  );
}
