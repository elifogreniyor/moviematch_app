import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sinflix/features/splash/presentation/cubit/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final String text = "by Nodelabs Software";
  String displayed = "";
  int _charIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkAuthStatus();
    _startTypewriter();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) context.go('/discover');
          });
        } else if (state is SplashUnauthenticated) {
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) context.go('/login');
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/images/SinFlixSplash.png',
                fit: BoxFit.cover,
              ),
            ),
            // En alta ortalı yazı
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: Center(
                child: Text(
                  displayed.isEmpty ? ' ' : displayed,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    fontFamily: AppConstants.fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startTypewriter() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_charIndex < text.length) {
        setState(() {
          displayed += text[_charIndex];
          _charIndex++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 800), () {
          if (!mounted) return;
          final state = context.read<SplashCubit>().state;
          if (state is SplashAuthenticated) {
            context.go('/discover');
          } else {
            context.go('/login');
          }
        });
      }
    });
  }
}
