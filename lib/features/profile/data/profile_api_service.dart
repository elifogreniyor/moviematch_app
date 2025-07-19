
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileApiService {
  final Dio dio;

  ProfileApiService(this.dio);

  Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await dio.get(
      '/user/profile',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getFavoriteMovies(String token) async {
    final response = await dio.get(
      '/movie/favorites',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response.data as Map<String, dynamic>;
  }

  Future<String> uploadProfilePhoto(File file, String token) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: 'profile.jpg',
        ),
      });
      final response = await dio.post(
        '/user/upload_photo',
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      final photoUrl = response.data['data']?['photoUrl'];
      if (photoUrl == null) {
        throw Exception("Fotoğraf yükleme başarısız. Sunucudan url dönmedi.");
      }
      return photoUrl;
    } catch (e) {
      if (e is DioException) {
        debugPrint('[ERROR] uploadProfilePhoto error: ${e.response?.data}');
      } else {
        debugPrint('[ERROR] uploadProfilePhoto error: $e');
      }
      rethrow;
    }
  }
}
