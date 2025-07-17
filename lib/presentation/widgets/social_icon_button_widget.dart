import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popcorndate/core/constants/app_constants.dart';

class SocialIconButton extends StatelessWidget {
  final String assetPath;
  final double buttonSize;
  final double iconWidth;
  final double iconHeight;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.assetPath,
    required this.buttonSize,
    required this.iconWidth,
    required this.iconHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: AppColors.white20,
            width: AppConstants.borderWidth,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: iconWidth,
            height: iconHeight,
        
          ),
        ),
      ),
    );
  }
}
