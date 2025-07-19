import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';

class MovieCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const MovieCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.movieCardRadius),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey[900]),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(230, 0, 0, 0), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/icons/movie.svg',
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(width: 10),
                  // Title + description (üst üste)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Başlık
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstants.fontFamily,
                            fontSize: AppConstants.titleFontSize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        // Açıklama + Daha Fazlası
                        ExpandableText(
                          description,
                          expandText: 'Daha Fazlası',
                          collapseText: 'Daha Az',
                          maxLines: 2,
                          linkColor: AppColors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: AppConstants.subtitleFontSize,
                            fontFamily: AppConstants.fontFamily,
                          ),
                          linkStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.white80,
                          ),
                          expandOnTextTap: true,
                          collapseOnTextTap: true,
                          animation: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
