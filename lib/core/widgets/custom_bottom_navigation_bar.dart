import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _BottomNavItem(
                iconPath: 'assets/icons/home.svg',
                label: 'Anasayfa',
                selected: currentIndex == 0,
                onTap: () {
                  if (currentIndex != 0) context.go('/discover');
                },
              ),
              const SizedBox(width: 16),
              _BottomNavItem(
                iconPath: 'assets/icons/profile.svg',
                label: 'Profil',
                selected: currentIndex == 1,
                onTap: () {
                  if (currentIndex != 1) context.go('/profile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.iconPath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 125, // Sabit genişlik
        height: 40, // Sabit yükseklik
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20), // Tasarımdaki radius 20
          border: Border.all(
            color: AppColors.white20, // Sabit border rengi
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // İçerik merkeze
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28,
              height: 28,
              colorFilter: const ColorFilter.mode(
                Colors.white, // sabit beyaz renk
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white, // sabit beyaz renk
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
