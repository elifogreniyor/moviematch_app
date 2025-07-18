import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/features/profile_photo/data/photo_upload_service.dart';
import 'package:sinflix/features/profile_photo/presentation/cubit/photo_upload_state.dart';

class PhotoUploadCubit extends Cubit<PhotoUploadState> {
  final PhotoUploadService service;
  PhotoUploadCubit(this.service) : super(PhotoUploadInitial());

  Future<void> uploadPhoto(File file, String token) async {
    emit(PhotoUploadLoading());
    try {
      final url = await service.uploadProfilePhoto(file, token);
      emit(PhotoUploadSuccess(url));
    } catch (e) {
      emit(PhotoUploadFailure("Fotoğraf yüklenemedi."));
    }
  }
}
