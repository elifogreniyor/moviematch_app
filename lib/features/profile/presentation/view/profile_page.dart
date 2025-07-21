import 'dart:math';
import 'dart:ui';

import 'package:sinflix/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:sinflix/core/widgets/limited_offer_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/widgets/appbar_back_button_widget.dart';
import 'package:sinflix/core/widgets/movie_card_widget.dart';
import 'package:sinflix/core/widgets/primary_button_widget.dart';
import 'package:sinflix/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sinflix/features/offer/presentation/widgets/limited_offer_bottom_sheet.dart';
import 'package:sinflix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sinflix/features/profile/presentation/cubit/profile_state.dart';
import 'package:sinflix/l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfileLoaded) {
          final user = state.user;
          final movies = state.favoriteMovies;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: AppConstants.appBarBackButtonSize + 25,
              leading: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.center,
                  child: AppBarBackButton(onTap: () => context.go('/discover')),
                ),
              ),
              centerTitle: true,
              title: Text(
                l10n.profile_appBar_title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: AppConstants.appBarTitleFontSize,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: LimitedOfferButton(
                    onTap: () => showLimitedOfferSheet(context),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.backgroundColor,
            bottomNavigationBar: const CustomBottomNavigationBar(
              currentIndex: 1,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 31,
                            backgroundImage:
                                (user.photoUrl != null &&
                                    user.photoUrl!.isNotEmpty)
                                ? NetworkImage(user.photoUrl!)
                                : null,
                            backgroundColor: Colors.white24,
                            child:
                                (user.photoUrl == null ||
                                    user.photoUrl!.isEmpty)
                                ? const Icon(
                                    Icons.person,
                                    size: 32,
                                    color: Colors.white70,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: AppConstants.profileNameFontSize,
                                    fontWeight: FontWeight.w500, // Medium
                                    fontFamily: AppConstants.fontFamily,
                                    height: 1, // 100%
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "ID: ",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(
                                            ClipboardData(text: user.id),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                l10n.copy_id_message,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          maskId(user.id),
                                          style: const TextStyle(
                                            color: AppColors.white50,
                                            fontSize:
                                                AppConstants.profileIdFontSize,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: AppConstants.fontFamily,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => context.go('/profile/photo'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 19,
                                vertical: 10,
                              ),
                              minimumSize: const Size(121, 36),
                              elevation: 0,
                            ),
                            child: Text(
                              l10n.profile_add_photo,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstants.fontFamily,
                                color: AppColors.white,
                                fontSize: AppConstants.subtitleFontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        l10n.profile_favorite_movies,
                        style: TextStyle(
                          fontFamily: AppConstants.fontFamily,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppConstants.subtitleFontSize,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 0.59,
                            ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return MovieCardWidget(
                            movie: movie,
                            isExpanded: false, // Grid minik kutu
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: PrimaryButton(
                          text: l10n.exit_button_text,
                          onTap: () {
                            context.read<AuthCubit>().logout();
                            context.go('/login');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(
              child: Text(
                l10n.error_message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SizedBox.shrink(),
          );
        }
      },
    );
  }

  String maskId(String id) {
    if (id.length <= 10) return id;
    return '${id.substring(0, 8)}...${id.substring(id.length - 8)}';
  }

  void showLimitedOfferSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Stack(
          children: [
            // Blur overlay
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(color: Colors.black.withOpacity(0.22)),
              ),
            ),
            // Sheet content
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width > 420 ? 402 : width,
                height: min(height * 0.95, 700),
                margin: const EdgeInsets.only(bottom: 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
                  gradient: LinearGradient(
                    colors: [AppColors.gradientTop, AppColors.gradientBottom],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const LimitedOfferBottomSheet(),
              ),
            ),
          ],
        );
      },
    );
  }
}
