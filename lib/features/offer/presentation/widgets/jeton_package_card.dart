import 'package:flutter/material.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/l10n/app_localizations.dart';

class JetonPackageCard extends StatelessWidget {
  final String discount;
  final String oldAmount;
  final String amount;
  final String label;
  final String price;
  final bool isFeatured;
  final VoidCallback? onTap;

  const JetonPackageCard({
    super.key,
    required this.discount,
    required this.oldAmount,
    required this.amount,
    required this.label,
    required this.price,
    this.isFeatured = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 112,
        height: 218,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // spacing/4 Figma'da ~20px
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.3,
            colors: isFeatured
                ? [
                    Color(0xFF7B57F6),
                    Color(0xFFE50914),
                  ] 
                : [
                    Color(0xFF6F060B),
                    Color(0xFFE50914),
                  ], // Kırmızı ve koyu kırmızı
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.40), // %40 opacity, 1px
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.30), // İç gölge için
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(4, 4), // Figma: 4px 4px
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -13,
              child: Container(
                width: 61,
                height: 25,
                decoration: BoxDecoration(
                  color: isFeatured
                      ? Color(0xFF5949E6).withOpacity(0.9)
                      : Color(0xFF6F060B).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.50),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    discount,
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            // Kart içeriği
            Positioned.fill(
              top: 48,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      oldAmount,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppConstants.fontFamily,
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      amount,
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: AppConstants.fontFamily2,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1),
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: AppConstants.fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 35),
                    Container(
                      height: 1.1,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.13),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      price,
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: AppConstants.fontFamily2,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      l10n.weeklyPerHead,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
