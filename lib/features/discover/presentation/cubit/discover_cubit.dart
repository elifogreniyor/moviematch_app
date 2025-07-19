import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';
import '../../data/discover_api_service.dart';
import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final DiscoverApiService apiService;

  List<MovieModel> _movies = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

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
      // 1. Yeni film sayfasını çek
      final newMovies = await apiService.fetchMovies(_page);

      // 2. Favori ID listesini çek
      final favoriteIds = await apiService.fetchFavoriteIds();

      // 3. Her filme favori durumunu set et
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
      emit(DiscoverError(e.toString()));
    } finally {
      _isLoading = false;
    }
  }

  Future<void> toggleFavorite(String movieId) async {
    try {
      await apiService.toggleFavorite(movieId);

      // Güncel favori ID listesini tekrar çek ve hepsine uygula (optimistic update ile anlık UI)
      final favoriteIds = await apiService.fetchFavoriteIds();

      _movies = _movies
          .map((m) => m.copyWith(isFavorite: favoriteIds.contains(m.id)))
          .toList();
      emit(DiscoverLoaded(List.unmodifiable(_movies), hasMore: _hasMore));
    } catch (e) {
      // Hata yönetimi (opsiyonel toast/snackbar)
    }
  }
}
