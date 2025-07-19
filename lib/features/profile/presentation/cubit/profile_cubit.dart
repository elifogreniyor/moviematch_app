import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sinflix/features/profile/data/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  final FlutterSecureStorage storage;

  ProfileCubit(this.repository, this.storage) : super(ProfileInitial());

  // Token'ı secure storage'dan otomatik çekmek istersen:
  Future<void> fetchProfile() async {
    try {
      emit(ProfileLoading());
      final token = await storage.read(key: 'token');
      if (token == null) {
        emit(ProfileError("Token bulunamadı, lütfen tekrar giriş yapın."));
        return;
      }
      final user = await repository.fetchUserProfile(token);
      final favorites = await repository.fetchFavoriteMovies(token);
      emit(ProfileLoaded(user: user, favoriteMovies: favorites));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> uploadProfilePhoto(File file) async {
    try {
      emit(ProfilePhotoUploading());
      final token = await storage.read(key: 'token');
      if (token == null) {
        emit(
          ProfilePhotoUploadFailure(
            "Token bulunamadı, lütfen tekrar giriş yapın.",
          ),
        );
        return;
      }
      final photoUrl = await repository.uploadProfilePhoto(file, token);
      emit(ProfilePhotoUploadSuccess(photoUrl));
      await fetchProfile(); // Foto sonrası profil güncelle
    } catch (e) {
      emit(ProfilePhotoUploadFailure(e.toString()));
    }
  }
}
