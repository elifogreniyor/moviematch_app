import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sinflix/features/discover/presentation/view/discover_page.dart';
import 'package:sinflix/features/auth/presentation/view/login_page.dart';
import 'package:sinflix/features/auth/presentation/view/register_page.dart';
import 'package:sinflix/features/offer/presentation/widgets/limited_offer_bottom_sheet.dart';
import 'package:sinflix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sinflix/features/profile/presentation/view/profile_page.dart';
import 'package:sinflix/features/profile/presentation/view/profile_photo_page.dart';
import 'package:sinflix/features/splash/presentation/view/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/profile/photo',
        builder: (context, state) => const ProfilePhotoPage(),
      ),
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
            child: RegisterPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          );
        },
      ),
      GoRoute(
        path: '/discover',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const DiscoverPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          );
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) =>
            MaterialPage(child: const ProfilePage()),
        redirect: (context, state) {
          context.read<ProfileCubit>().fetchProfile();
          return null;
        },
      ),
      GoRoute(
        path: '/offer',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const LimitedOfferBottomSheet(),
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 280),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final tween = Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeOutCubic));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          );
        },
      ),
    ],
  );
}
