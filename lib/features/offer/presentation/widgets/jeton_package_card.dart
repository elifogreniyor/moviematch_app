import 'package:flutter/material.dart';
import 'package:sinflix/features/offer/models/jeton_package_model.dart';

class JetonPackageCard extends StatelessWidget {
  final JetonPackage p;
  const JetonPackageCard(this.p, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 112,
      height: 218,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [p.color1, p.color2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 15,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 38),
                Text(
                  p.oldAmount,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  p.amount,
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
                const Spacer(),
                Divider(
                  color: Colors.white.withOpacity(0.19),
                  height: 1,
                  thickness: 1,
                  indent: 14,
                  endIndent: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        p.price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        "Başına haftalık",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 61,
              height: 25,
              decoration: BoxDecoration(
                color: p.color1,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  p.discount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
