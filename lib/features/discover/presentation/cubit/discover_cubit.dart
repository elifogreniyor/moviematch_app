import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';
import '../../data/discover_api_service.dart';
import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final DiscoverApiService apiService;

  List<MovieModel> _movies = [];
  int _page = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  DiscoverCubit(this.apiService) : super(DiscoverInitial());

  Future<void> fetchMovies({bool refresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;

    if (refresh) {
      _movies = [];
      _page = 1;
      _hasMore = true;
      emit(DiscoverLoading(_movies, isRefresh: true));
    } else {
      emit(DiscoverLoading(_movies));
    }

    try {
      final newMovies = await apiService.fetchMovies(_page);// Burada kaç film geldiğini görürsün
      final favoriteIds = await apiService.fetchFavoriteIds();
      for (var m in newMovies) {
        m.isFavorite = favoriteIds.contains(m.id);
      }

      if (newMovies.length < 5) {
        _hasMore = false;
      }

      _movies.addAll(newMovies);
      _page++;
      emit(DiscoverLoaded(List.unmodifiable(_movies), hasMore: _hasMore));
    } catch (e) {
      print('Fetch error: $e'); // Hata varsa konsola yazar
      emit(DiscoverError(e.toString()));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> toggleFavorite(String movieId) async {
    try {
      await apiService.toggleFavorite(movieId);
      _movies = _movies
          .map(
            (m) => m.id == movieId ? m.copyWith(isFavorite: !m.isFavorite) : m,
          )
          .toList();
      emit(DiscoverLoaded(List.unmodifiable(_movies), hasMore: _hasMore));
    } catch (e) {}
  }
}
