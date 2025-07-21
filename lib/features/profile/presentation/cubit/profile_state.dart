import 'package:equatable/equatable.dart';
import 'package:sinflix/features/auth/domain/models/user_model.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<MovieModel> favoriteMovies;

  ProfileLoaded({required this.user, required this.favoriteMovies});

  @override
  List<Object?> get props => [user, favoriteMovies];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfilePhotoUploading extends ProfileState {}

class ProfilePhotoUploadSuccess extends ProfileState {
  final String photoUrl;
  ProfilePhotoUploadSuccess(this.photoUrl);

  @override
  List<Object?> get props => [photoUrl];
}

class ProfilePhotoUploadFailure extends ProfileState {
  final String error;
  ProfilePhotoUploadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
