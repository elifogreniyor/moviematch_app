import 'package:flutter/material.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/widgets/primary_button_widget.dart';
import 'package:sinflix/features/offer/presentation/widgets/jeton_package_card.dart';
import 'package:sinflix/l10n/app_localizations.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final List bonusList = [
      {"img": "assets/icons/like.png", "label": l10n.premium_account},
      {"img": "assets/icons/match.png", "label": l10n.more_matches},
      {"img": "assets/icons/up.png", "label": l10n.up_more},
      {"img": "assets/icons/hearth.png", "label": l10n.like_more},
    ];

    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          l10n.limited_offer_title,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.limited_offer_subTitle,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 12,
            height: 1.5,
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            width: 367,
            height: 174,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withOpacity(0.20)),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Başlık
                Positioned(
                  top: 22,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      l10n.get_your_bonus,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: AppConstants.fontFamily,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: bonusList
                        .map(
                          (b) => _BonusIconText(
                            img: b["img"]!,
                            label: b["label"]!,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          l10n.unlock_with_token_package,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: AppConstants.fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: JetonPackageCard(
                discount: "+10%",
                oldAmount: "200",
                amount: "330",
                label: "Jeton",
                price: "₺99,99",
                onTap: () {},
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: JetonPackageCard(
                discount: "+70%",
                oldAmount: "2.000",
                amount: "3.375",
                label: "Jeton",
                price: "₺799,99",
                isFeatured: true,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: JetonPackageCard(
                discount: "+35%",
                oldAmount: "1.000",
                amount: "1.350",
                label: "Jeton",
                price: "₺399,99",
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        PrimaryButton(text: l10n.see_all_tokens, onTap: () {}),
      ],
    );
  }
}

// PNG ile ikonu gösteren widget
class _BonusIconText extends StatelessWidget {
  final String img;
  final String label;
  const _BonusIconText({required this.img, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF6F060B),
            border: Border.all(color: Colors.white.withOpacity(0.10), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.10), // Hafif beyaz
                blurRadius: 8,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Center(child: Image.asset(img, width: 33, height: 33)),
        ),
        const SizedBox(height: 13),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
