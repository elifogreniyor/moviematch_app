import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BonusPanel extends StatelessWidget {
  final List<Map<String, String>> bonuses;
  const BonusPanel({required this.bonuses, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          const Text(
            "Alacağınız Bonuslar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: bonuses
                .map(
                  (bonus) => Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [Color(0xFFF46CB1), Colors.transparent],
                            center: Alignment.center,
                            radius: 0.8,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            bonus['svg']!,
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bonus['label']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
