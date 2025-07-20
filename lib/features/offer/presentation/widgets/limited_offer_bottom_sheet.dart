import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF090909),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Başlık
            const Text(
              "Sınırlı Teklif",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: AppConstants.fontFamily,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Jeton paketini seçerek bonus kazanın ve yeni bölümlerin kilidini açın!",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontFamily: AppConstants.fontFamily,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),

            // Alacağınız Bonuslar
            _BonusesRow(),

            const SizedBox(height: 18),

            // Jeton Paketleri
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Kilidi açmak için bir jeton paketi seçin",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppConstants.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _JetonPackageCard(
                  discount: "+10%",
                  amount: "330",
                  oldAmount: "200",
                  price: "₺99,99",
                  color1: Color(0xFF6F060B),
                  color2: Color(0xFFE50914),
                ),
                _JetonPackageCard(
                  discount: "+70%",
                  amount: "3.375",
                  oldAmount: "2.000",
                  price: "₺799,99",
                  color1: Color(0xFF5949E6),
                  color2: Color(0xFFE50914),
                ),
                _JetonPackageCard(
                  discount: "+35%",
                  amount: "1.350",
                  oldAmount: "1.000",
                  price: "₺399,99",
                  color1: Color(0xFF6F060B),
                  color2: Color(0xFFE50914),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Tüm Jetonları Gör Butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50914),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                ),
                child: const Text(
                  "Tüm Jetonları Gör",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstants.fontFamily,
                    color: Colors.white,
                    fontSize: 16,
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

// Jeton Paketi Kartı (Gradientli ve Border'lı)
class _JetonPackageCard extends StatelessWidget {
  final String discount;
  final String amount;
  final String oldAmount;
  final String price;
  final Color color1;
  final Color color2;

  const _JetonPackageCard({
    required this.discount,
    required this.amount,
    required this.oldAmount,
    required this.price,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 218,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              discount,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              oldAmount,
              style: const TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
            const Text(
              "Jeton",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const Text(
              "Başına haftalık",
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

// Bonuslar Satırı
class _BonusesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SVG isimlerini kendine göre güncelle!
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BonusIconText(
            svg: 'assets/icons/premium.svg',
            label: "Premium\nHesap",
          ),
          _BonusIconText(
            svg: 'assets/icons/match.svg',
            label: "Daha\nFazla Eşleşme",
          ),
          _BonusIconText(svg: 'assets/icons/up.svg', label: "Öne\nÇıkarma"),
          _BonusIconText(
            svg: 'assets/icons/like.svg',
            label: "Daha\nFazla Beğeni",
          ),
        ],
      ),
    );
  }
}

class _BonusIconText extends StatelessWidget {
  final String svg;
  final String label;
  const _BonusIconText({required this.svg, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 33,
          height: 33,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white12, width: 1),
          ),
          child: Center(child: SvgPicture.asset(svg, width: 18, height: 18)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontFamily: AppConstants.fontFamily,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
