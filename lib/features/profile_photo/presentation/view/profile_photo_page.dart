import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/utils/secure_storage_helper.dart';
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

  Future<File?> compressImage(File file) async {
    final targetPath = file.path.replaceFirst('.jpg', '_compressed.jpg');
    final XFile? xfile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 35,
      minWidth: 600,
      minHeight: 600,
    );
    return xfile != null ? File(xfile.path) : null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File file = File(picked.path);
      File? compressed = await compressImage(file); // burada çağır!
      setState(() {
        _selectedImage =
            compressed ??
            file; // compress başarılıysa sıkıştırılmışı, yoksa orijinali ata
      });
      final bytes = (_selectedImage?.length() ?? 0);
      debugPrint('[DEBUG] Yüklenecek dosya boyutu: $bytes bytes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<PhotoUploadCubit, PhotoUploadState>(
      listener: (context, state) async {
        if (state is PhotoUploadSuccess) {
          // Başarı mesajı göster
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.photo_upload_success)));
          await Future.delayed(const Duration(seconds: 1));
          context.go('/discover'); // veya context.go('/discover')
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
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
                                  l10n.photo_upload_appBar_title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: AppConstants.appBarTitleFontSize,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppConstants.fontFamily,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: AppConstants.appBarBackButtonSize,
                                ),
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
                              fontWeight: FontWeight.w600,
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
                                  height: 1.2,
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
                          // Flexible alan, boşluğu doldurur
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
                if (_selectedImage == null) return;
                context.read<PhotoUploadCubit>().uploadPhoto(_selectedImage!);
              },
            ),
          ),
        );
      },
    );
  }
}
