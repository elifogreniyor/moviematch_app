import 'dart:io';

import 'package:sinflix/features/auth/domain/models/user_model.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';
import 'package:sinflix/features/profile/data/profile_api_service.dart';

class ProfileRepository {
  final ProfileApiService apiService;

  ProfileRepository(this.apiService);

  // Kullanıcı profilini getir
  Future<UserModel> fetchUserProfile(String token) async {
    final data = await apiService.getProfile(token);
    // API response: {"response": {...}, "data": {...}}
    return UserModel.fromJson(data['data']);
  }

  // Favori filmleri getir
  Future<List<MovieModel>> fetchFavoriteMovies(String token) async {
    final data = await apiService.getFavoriteMovies(token);
    // API response: {"movies": [...]}
    final movies = (data['movies'] as List<dynamic>?)
        ?.map((e) => MovieModel.fromJson(e))
        .toList();
    return movies ?? [];
  }

  // Profil fotoğrafı yükle/güncelle
  Future<String> uploadProfilePhoto(File file, String token) async {
    return await apiService.uploadProfilePhoto(file, token);
  }
}