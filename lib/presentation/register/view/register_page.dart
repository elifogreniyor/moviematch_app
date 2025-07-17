import 'package:flutter/material.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/l10n/app_localizations.dart';
import 'package:sinflix/presentation/widgets/custom_textfield_widget.dart';
import 'package:sinflix/presentation/widgets/primary_button_widget.dart';
import 'package:sinflix/presentation/widgets/social_icon_button_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
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
                hintText: l10n.register_name_hint,
                iconPath: "assets/icons/person.svg",
              ),
              const SizedBox(height: 13),
              // E-posta
              CustomTextField(
                hintText: l10n.register_email_hint,
                iconPath: "assets/icons/message.svg",
              ),
              const SizedBox(height: 16),
              // Şifre
              CustomTextField(
                hintText: l10n.register_password_hint,
                iconPath: "assets/icons/unlock.svg",
                obscureText: true,
              ),
              const SizedBox(height: 13),
              // Şifre Tekrar
              CustomTextField(
                hintText: l10n.register_confirm_password_hint,
                iconPath: "assets/icons/unlock.svg",
                obscureText: false,
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
                      // onTap ile şartları gösterilebilir.
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
                  // Kayıt işlemi
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
                      // Giriş Yap sayfasına yönlendir
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
    );
  }
}
