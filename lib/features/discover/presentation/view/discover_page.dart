import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/widgets/favorite_button_widget.dart';
import 'package:sinflix/core/widgets/custom_bottom_navigation_bar.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.movieCardRadius),
              child: Stack(
                children: [
                  // Görsel (tam ekran)
                  Positioned.fill(
                    child: Image.network(
                      "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Alt gradient
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 170,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blackLinearGradient,
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
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
                              children: const [
                                Text(
                                  "Günahkar Adam",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppConstants.fontFamily,
                                    fontSize: AppConstants.titleFontSize,
                                    height: 1.0,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      color: AppColors.white50,
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppConstants.subtitleFontSize,
                                      fontFamily: AppConstants.fontFamily,
                                      height: 1,
                                      letterSpacing: 0.5,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            "Community every territories dagpile so. Last they investigation model ",
                                      ),
                                      TextSpan(
                                        text: "Daha Fazlası",
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              AppConstants.subtitleFontSize,
                                          fontFamily: AppConstants.fontFamily,
                                          height: 1,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
            ),
          ),
          //Favorite button
          Positioned(
            right: 16,
            bottom: 180,
            child: FavoriteButtonWidget(
              isFavorite: isFavorite,
              onTap: () => setState(() => isFavorite = !isFavorite),
            ),
          ),
          // Alt Navigation Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: CustomBottomNavigationBar(currentIndex: 0),
          ),
        ],
      ),
    );
  }
}
