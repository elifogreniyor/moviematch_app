import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';
import 'package:sinflix/l10n/app_localizations.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieModel movie;
  final bool isExpanded;
  final VoidCallback? onFavoriteToggle;

  const MovieCardWidget({
    super.key,
    required this.movie,
    this.isExpanded = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    if (isExpanded) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.movieCardRadius),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                movie.posterUrl.replaceFirst("http://", "https://"),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(230, 0, 0, 0), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/movie.svg',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstants.fontFamily,
                              fontSize: AppConstants.titleFontSize,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 3),
                          ExpandableText(
                            movie.description,
                            expandText: l10n.expand_text,
                            collapseText: l10n.collapse_text,
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
                              color: AppColors.white,
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

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 0.72,
              child: Image.network(
                movie.posterUrl.replaceFirst("http://", "https://"),
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.movie,
                    size: 38,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: AppConstants.fontFamily,
                fontSize: AppConstants.movieTitleFontSize,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Text(
              movie.director,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white50,
                fontWeight: FontWeight.w400,
                fontFamily: AppConstants.fontFamily,
                height: 1.5,
                fontSize: AppConstants.movieTitleFontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
