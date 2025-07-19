import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback? onTap;

  const FavoriteButtonWidget({super.key, required this.isFavorite, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 49,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Icon(
              //TODO : heart iconunu değiştir
              isFavorite ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(isFavorite),
              color: isFavorite ? Colors.red : Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
