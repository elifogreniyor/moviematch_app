import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PhotoUploadService {
  final Dio dio;
  PhotoUploadService(this.dio);

  Future<String> uploadProfilePhoto(File file, String token) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: 'profile.jpg',
        ),
      });
      debugPrint('[DEBUG] FormData hazır, upload başlıyor...');
      final response = await dio.post(
        '/user/upload_photo',
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      debugPrint('[DEBUG] Sunucudan dönen response: ${response.data}');
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
