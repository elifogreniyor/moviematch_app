import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/widgets/appbar_back_button_widget.dart';
import 'package:sinflix/core/widgets/primary_button_widget.dart';
import 'package:sinflix/features/profile_photo/presentation/cubit/photo_upload_cubit.dart';
import 'package:sinflix/features/profile_photo/presentation/cubit/photo_upload_state.dart';
import 'package:sinflix/l10n/app_localizations.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});

  @override
  State<ProfilePhotoPage> createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  File? _selectedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<PhotoUploadCubit, PhotoUploadState>(
      listener: (context, state) {
        if (state is PhotoUploadSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.photo_upload_success)));
        } else if (state is PhotoUploadFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.photo_upload_failed)));
        }
      },
      builder: (context, state) {
        final isLoading = state is PhotoUploadLoading;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalPadding,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      AppBarBackButton(
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      const Spacer(),
                      Text(
                        l10n.photo_upload_appBar_title, // "Profil Detayı"
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppConstants.appBarTitleFontSize,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppConstants.fontFamily,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: AppConstants.appBarBackButtonSize),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  l10n.photo_upload_title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppConstants.titleFontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Subtitle
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 220),
                    child: Text(
                      l10n.photo_upload_subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppConstants.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: AppConstants.subtitleFontSize,
                        color: AppColors.white,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                // Photo Box
                GestureDetector(
                  onTap: isLoading ? null : _pickImage,
                  child: Container(
                    width: AppConstants.photoBoxSize,
                    height: AppConstants.photoBoxSize,
                    decoration: BoxDecoration(
                      color: AppColors.white10,
                      borderRadius: BorderRadius.circular(
                        AppConstants.photoBoxBorderRadius,
                      ),
                      border: Border.all(
                        color: _selectedImage == null
                            ? AppColors.white10
                            : AppColors.primaryColor.withOpacity(0.5),
                        width: AppConstants.photoBoxBorderWidth,
                      ),
                    ),
                    child: _selectedImage == null
                        ? Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white54,
                              size: AppConstants.photoBoxIconSize,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppConstants.photoBoxBorderRadius - 4,
                            ),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              left: AppConstants.horizontalPadding,
              right: AppConstants.horizontalPadding,
              bottom: AppConstants.pageBottomPadding,
            ),
            child: PrimaryButton(
              text: l10n.photo_upload_button,
              onTap: () {
                context.read<PhotoUploadCubit>().uploadPhoto(
                  _selectedImage!,
                  "TOKEN_BURAYA_GELECEK", // TODO: Token/userId ekle
                );
              },
            ),
          ),
        );
      },
    );
  }
}
