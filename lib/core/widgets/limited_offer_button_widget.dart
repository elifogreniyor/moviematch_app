import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class LimitedOfferButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LimitedOfferButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(53)),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 0),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/diamond.svg',
            width: 18,
            height: 18, 
          ),
          const SizedBox(width: 6),
          const Text(
            "Sınırlı Teklif",
            style: TextStyle(
              fontFamily: AppConstants.fontFamily2,
              fontWeight: FontWeight.w600,
              fontSize: AppConstants.bottomTextFontSize,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
