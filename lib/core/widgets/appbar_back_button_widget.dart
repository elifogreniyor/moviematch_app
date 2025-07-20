import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class AppBarBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const AppBarBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: AppConstants.appBarBackButtonSize,
        height: AppConstants.appBarBackButtonSize,
        decoration: BoxDecoration(
          color: AppColors.white10,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.white20,
            width: 1,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            width: AppConstants.appBarBackIconSize,
            height: AppConstants.appBarBackIconSize,
            color: AppColors.white, 
          ),
        ),
      ),
    );
  }
}
