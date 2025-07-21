import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/core/services/logger_service.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';
import '../../data/discover_api_service.dart';
import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final DiscoverApiService apiService;
  final logger = LoggerService();

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
      logger.info('Discover: Refresh başlatıldı');
    } else {
      emit(DiscoverLoading(_movies));
      logger.info('Discover: Yeni sayfa yükleniyor (page: $_page)');
    }

    try {
      final newMovies = await apiService.fetchMovies(_page);
      final favoriteIds = await apiService.fetchFavoriteIds();

      logger.info('Discover: Favori film ID\'leri: $favoriteIds');
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
      _movies = _movies
          .map(
            (m) => m.id == movieId ? m.copyWith(isFavorite: !m.isFavorite) : m,
          )
          .toList();
      emit(DiscoverLoaded(List.unmodifiable(_movies), hasMore: _hasMore));
      logger.logEvent('favorite_toggled', params: {'movieId': movieId});
      logger.info('Discover: Favori değişti (movieId: $movieId)');
    } catch (e, stack) {
      logger.error('Discover: toggleFavorite hatası', e, stack);
    }
  }
}
