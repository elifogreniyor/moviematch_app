import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:sinflix/core/widgets/favorite_button_widget.dart';
import 'package:sinflix/core/widgets/floating_language_button_widget.dart';
import 'package:sinflix/features/discover/presentation/cubit/discover_cubit.dart';
import 'package:sinflix/features/discover/presentation/cubit/discover_state.dart';
import 'package:sinflix/core/widgets/movie_card_widget.dart';
import 'package:sinflix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sinflix/l10n/app_localizations.dart';
import 'package:sinflix/main.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<DiscoverCubit>().fetchMovies();
    _pageController.addListener(() {
      final idx = _pageController.page?.round() ?? 0;
      if (idx != currentPage) {
        setState(() {
          currentPage = idx;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    final discoverCubit = context.read<DiscoverCubit>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 90,
            child: BlocBuilder<DiscoverCubit, DiscoverState>(
              builder: (context, state) {
                if (state is DiscoverInitial ||
                    (state is DiscoverLoading && state.movies.isEmpty)) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DiscoverError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (state is DiscoverLoaded ||
                    state is DiscoverLoading) {
                  final movies = (state is DiscoverLoaded)
                      ? state.movies
                      : (state as DiscoverLoading).movies;
                  final hasMore = (state is DiscoverLoaded)
                      ? state.hasMore
                      : true;

                  return PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: null,
                    onPageChanged: (index) {
                      if (index == movies.length - 1 &&
                          hasMore &&
                          !discoverCubit.isLoading) {
                        discoverCubit.fetchMovies();
                      }
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final movie = movies[index % movies.length];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 24.0,
                        ),
                        child: MovieCardWidget(
                          movie: movie,
                          isExpanded: true,
                          onFavoriteToggle: () async {
                            await context.read<DiscoverCubit>().toggleFavorite(
                              movie.id,
                            );
                            if (!mounted) return;
                            final closed = ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.favorite_updated),
                                  ),
                                )
                                .closed;
                            context.read<ProfileCubit>().fetchProfile();
                            closed.then((_) {
                              if (!mounted) return;
                            });
                          },
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          BlocBuilder<DiscoverCubit, DiscoverState>(
            builder: (context, state) {
              bool isFavorite = false;
              String? movieId;

              if ((state is DiscoverLoaded || state is DiscoverLoading) &&
                  ((state is DiscoverLoaded &&
                          state.movies.length > currentPage) ||
                      (state is DiscoverLoading &&
                          state.movies.length > currentPage))) {
                final movies = (state is DiscoverLoaded)
                    ? state.movies
                    : (state as DiscoverLoading).movies;
                isFavorite = movies[currentPage].isFavorite;
                movieId = movies[currentPage].id;
              }

              return Positioned(
                right: 16,
                bottom: 180,
                child: FavoriteButtonWidget(
                  isFavorite: isFavorite,
                  onTap: movieId != null
                      ? () => context.read<DiscoverCubit>().toggleFavorite(
                          movieId!,
                        )
                      : null,
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: CustomBottomNavigationBar(currentIndex: 0),
          ),
          Positioned(
            top: 60,
            right: 16,
            child: FloatingLanguageButton(
              currentLocale: currentLocale,
              onLocaleChanged: (locale) {
                (context.findAncestorStateOfType<MyAppState>())?.setLocale(
                  locale,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
