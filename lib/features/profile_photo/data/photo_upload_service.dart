import 'dart:io';
import 'package:dio/dio.dart';

class PhotoUploadService {
  final Dio dio;
  PhotoUploadService(this.dio);

  Future<String> uploadProfilePhoto(File file, String token) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: 'profile.jpg'),
    });
    final response = await dio.post(
      '/user/upload_photo',
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response.data['photoUrl'];
  }
}
