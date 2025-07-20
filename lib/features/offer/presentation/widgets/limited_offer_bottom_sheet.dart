import 'package:flutter/material.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/features/offer/models/jeton_package_model.dart';
import 'package:sinflix/features/offer/presentation/widgets/bonus_panel.dart';
import 'package:sinflix/features/offer/presentation/widgets/jeton_package_card.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bonuses = [
      {"svg": "assets/icons/premium.svg", "label": "Premium Hesap"},
      {"svg": "assets/icons/match.svg", "label": "Daha Fazla Eşleşme"},
      {"svg": "assets/icons/highlight.svg", "label": "Öne Çıkarma"},
      {"svg": "assets/icons/like.svg", "label": "Daha Fazla Beğeni"},
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2C093A), Color(0xFF18111A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          children: [
            // Drag indicator
            Container(
              width: 45,
              height: 5,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.13),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Başlık ve açıklama
            const Text(
              "Sınırlı Teklif",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Jeton paketini seçerek bonus kazanın ve yeni bölümlerin kilidini açın!",
              style: TextStyle(color: Colors.white70, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            // Bonus paneli
            BonusPanel(bonuses: bonuses),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Kilidi açmak için bir jeton paketi seçin",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Jeton kartları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: AppConstants.jetonPackages
                  .map((p) => JetonPackageCard(p))
                  .toList(),
            ),
            const SizedBox(height: 28),
            // Alt buton
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32D4E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Text(
                  "Tüm Jetonları Gör",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
