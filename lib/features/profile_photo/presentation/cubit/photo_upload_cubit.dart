import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/core/utils/secure_storage_helper.dart';
import 'package:sinflix/features/profile_photo/data/photo_upload_service.dart';
import 'package:sinflix/features/profile_photo/presentation/cubit/photo_upload_state.dart';

class PhotoUploadCubit extends Cubit<PhotoUploadState> {
  final PhotoUploadService service;
  PhotoUploadCubit(this.service) : super(PhotoUploadInitial());

  Future<void> uploadPhoto(File file) async {
    emit(PhotoUploadLoading());
    try {
      final token = await SecureStorageHelper.getToken();
      if (token == null || token.isEmpty) {
        emit(PhotoUploadFailure("Oturum bulunamadı, tekrar giriş yapın!"));
        return;
      }
      final url = await service.uploadProfilePhoto(file, token);
      emit(PhotoUploadSuccess(url));
    } catch (e) {
      emit(PhotoUploadFailure("Fotoğraf yüklenemedi."));
    }
  }
}
