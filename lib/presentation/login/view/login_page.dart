import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/l10n/app_localizations.dart';
import 'package:sinflix/presentation/widgets/custom_textfield_widget.dart';
import 'package:sinflix/presentation/widgets/primary_button_widget.dart';
import 'package:sinflix/presentation/widgets/social_icon_button_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 200),
              Text(
                l10n.login_title,
                style: const TextStyle(
                  fontFamily: AppConstants.fontFamily,
                  fontSize: AppConstants.titleFontSize,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.login_subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppConstants.fontFamily,
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                hintText: l10n.login_email_hint,
                iconPath: "assets/icons/message.svg",
              ),
              const SizedBox(height: 13),
              CustomTextField(
                hintText: l10n.login_password_hint,
                iconPath: "assets/icons/unlock.svg",
                obscureText: true,
              ),

              const SizedBox(height: 4),

              // Şifremi Unuttum
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(0, 0),
                    foregroundColor: AppColors.white,
                  ),
                  child: Text(
                    l10n.login_forgot_password,
                    style: TextStyle(
                      fontFamily: AppConstants.fontFamily,
                      fontSize: AppConstants.forgotPasswordFontSize,
                      color: AppColors.white,
                      decoration: TextDecoration.underline,
                      decorationThickness: 0.8,
                      decorationColor: AppColors.white,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Giriş Yap Butonu
              SizedBox(
                width: double.infinity,
                height: AppConstants.buttonHeight,
                child: PrimaryButton(
                  text: l10n.login_button,
                  onTap: () {
                    /* login işlemleri */
                  },
                ),
              ),
              const SizedBox(height: 36.92),

              // Social Icons
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
                  const SizedBox(width: AppConstants.betweenSocialIcons),
                  SocialIconButton(
                    assetPath: "assets/icons/apple.svg",
                    buttonSize: AppConstants.socialIconButtonSize,
                    iconWidth: AppConstants.socialIconAppleW,
                    iconHeight: AppConstants.socialIconAppleH,
                    onTap: () {},
                  ),
                  const SizedBox(width: AppConstants.betweenSocialIcons),
                  SocialIconButton(
                    assetPath: "assets/icons/facebook.svg",
                    buttonSize: AppConstants.socialIconButtonSize,
                    iconWidth: AppConstants.socialIconFacebookW,
                    iconHeight: AppConstants.socialIconFacebookH,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32.27),
              // Alt yazı
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.login_no_account,
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
                      context.go('/register');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                    child: Text(
                      l10n.login_register,
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
