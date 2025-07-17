import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sinflix/features/auth/presentation/cubit/auth_state.dart';
import 'package:sinflix/l10n/app_localizations.dart';
import 'package:sinflix/core/widgets/custom_textfield_widget.dart';
import 'package:sinflix/core/widgets/primary_button_widget.dart';
import 'package:sinflix/core/widgets/social_icon_button_widget.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isSuccess) {
            final snackBar = SnackBar(content: Text(l10n.login_success));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            debugPrint('kayıt başarılı.');
            Future.delayed(const Duration(seconds: 1), () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.go('/home');
            });
          }
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.register_failed)));
          }
        },

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
            ),
            child: Column(
              children: [
                const SizedBox(height: 64),
                Text(
                  l10n.register_title,
                  style: const TextStyle(
                    fontFamily: AppConstants.fontFamily,
                    fontSize: AppConstants.titleFontSize,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                // Alt başlık
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: Text(
                      l10n.register_subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppConstants.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: AppConstants.subtitleFontSize,
                        color: AppColors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Ad Soyad
                CustomTextField(
                  controller: nameController,
                  hintText: l10n.register_name_hint,
                  iconPath: "assets/icons/person.svg",
                ),
                const SizedBox(height: 13),
                // E-posta
                CustomTextField(
                  controller: emailController,
                  hintText: l10n.register_email_hint,
                  iconPath: "assets/icons/message.svg",
                ),
                const SizedBox(height: 16),
                // Şifre
                CustomTextField(
                  controller: passwordController,
                  hintText: l10n.register_password_hint,
                  iconPath: "assets/icons/unlock.svg",
                  obscureText: true,
                  showEyeIcon: true,
                ),
                const SizedBox(height: 13),
                // Şifre Tekrar
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: l10n.register_confirm_password_hint,
                  iconPath: "assets/icons/unlock.svg",
                  obscureText: true,
                  showEyeIcon: false,
                ),
                const SizedBox(height: 16),
                // Kullanıcı sözleşmesi
                RichText(
                  text: TextSpan(
                    text: l10n.register_agreement_prefix,
                    style: const TextStyle(
                      color: AppColors.white50,
                      fontFamily: AppConstants.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: l10n.register_agreement_link,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                          decorationThickness: 0.8,
                        ),
                      ),
                      TextSpan(
                        text: l10n.register_agreement_suffix,
                        style: const TextStyle(color: AppColors.white50),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 38),
                PrimaryButton(
                  text: l10n.register_button,
                  onTap: () {
                    print("kayıt ol butonuna basıldı");
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      context.read<AuthCubit>().register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.register_passwords_not_match),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialIconButton(
                      assetPath: "assets/icons/google.svg",
                      buttonSize: AppConstants.socialIconButtonSize,
                      iconWidth: AppConstants.socialIconGoogle,
                      iconHeight: AppConstants.socialIconGoogle,
                      onTap: () {},
                    ),
                    const SizedBox(width: 9),
                    SocialIconButton(
                      assetPath: "assets/icons/apple.svg",
                      buttonSize: AppConstants.socialIconButtonSize,
                      iconWidth: AppConstants.socialIconAppleW,
                      iconHeight: AppConstants.socialIconAppleH,
                      onTap: () {},
                    ),
                    const SizedBox(width: 9),
                    SocialIconButton(
                      assetPath: "assets/icons/facebook.svg",
                      buttonSize: AppConstants.socialIconButtonSize,
                      iconWidth: AppConstants.socialIconFacebookW,
                      iconHeight: AppConstants.socialIconFacebookH,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.register_already_have_account,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.white50,
                        fontFamily: AppConstants.fontFamily,
                        fontSize: AppConstants.bottomTextFontSize,
                        height: 1.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                      child: Text(
                        l10n.register_login,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: AppConstants.fontFamily,
                          fontSize: AppConstants.bottomTextFontSize,
                          height: 1.5,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
