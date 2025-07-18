import 'package:equatable/equatable.dart';

abstract class PhotoUploadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhotoUploadInitial extends PhotoUploadState {}
class PhotoUploadLoading extends PhotoUploadState {}
class PhotoUploadSuccess extends PhotoUploadState {
  final String photoUrl;
  PhotoUploadSuccess(this.photoUrl);
  @override
  List<Object?> get props => [photoUrl];
}
class PhotoUploadFailure extends PhotoUploadState {
  final String error;
  PhotoUploadFailure(this.error);
  @override
  List<Object?> get props => [error];
}