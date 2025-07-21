import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/l10n/app_localizations.dart';

class LimitedOfferButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LimitedOfferButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          Text(
            l10n.limited_offer_title,
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
