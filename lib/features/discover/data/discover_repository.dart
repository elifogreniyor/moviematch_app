import 'package:sinflix/features/discover/domain/movie_model.dart';
import 'discover_api_service.dart';

class DiscoverRepository {
  final DiscoverApiService apiService;

  DiscoverRepository(this.apiService);

  Future<List<MovieModel>> getMovies(int page) async {
    return await apiService.fetchMovies(page);
  }

  Future<void> toggleFavorite(String movieId) async {
    await apiService.toggleFavorite(movieId);
  }
}
