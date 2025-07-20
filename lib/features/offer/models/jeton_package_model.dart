import 'dart:ui';

class JetonPackage {
  final String discount;
  final String amount;
  final String oldAmount;
  final String price;
  final Color color1;
  final Color color2;

  const JetonPackage({
    required this.discount,
    required this.amount,
    required this.oldAmount,
    required this.price,
    required this.color1,
    required this.color2,
  });
}