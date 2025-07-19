import 'package:equatable/equatable.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object?> get props => [];
}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoading extends DiscoverState {
  final List<MovieModel> movies;
  final bool isRefresh;

  const DiscoverLoading(this.movies, {this.isRefresh = false});

  @override
  List<Object?> get props => [movies, isRefresh];
}

class DiscoverLoaded extends DiscoverState {
  final List<MovieModel> movies;
  final bool hasMore;

  const DiscoverLoaded(this.movies, {this.hasMore = true});

  @override
  List<Object?> get props => [movies, hasMore];
}

class DiscoverError extends DiscoverState {
  final String message;

  const DiscoverError(this.message);

  @override
  List<Object?> get props => [message];
}
