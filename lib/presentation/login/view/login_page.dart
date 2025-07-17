import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/login_cubit.dart';
import '../viewmodel/login_state.dart';
import 'package:popcorndate/l10n/app_localizations.dart'; // yolunu kendi projenle güncelle

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return Scaffold(
            backgroundColor: const Color(0xFF090909),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      l10n.login_title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.login_subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: cubit.emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF232323),
                        hintText: l10n.login_email_hint,
                        hintStyle: const TextStyle(color: Color(0xFF757575)),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white70,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: cubit.passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF232323),
                        hintText: l10n.login_password_hint,
                        hintStyle: const TextStyle(color: Color(0xFF757575)),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.white70,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.white54,
                          ),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFAAAAAA),
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                        ),
                        child: Text(
                          l10n.login_forgot_password,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    if (state.error != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: state.isLoading ? null : cubit.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE50914),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                l10n.login_button,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIconButton(icon: Icons.g_mobiledata),
                        const SizedBox(width: 16),
                        _SocialIconButton(icon: Icons.apple),
                        const SizedBox(width: 16),
                        _SocialIconButton(icon: Icons.facebook),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.login_no_account,
                          style: const TextStyle(color: Color(0xFFAAAAAA)),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            l10n.login_register,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  const _SocialIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
