import 'package:dio/dio.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/utils/secure_storage_helper.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';

class DiscoverApiService {
  final Dio dio;
  final String baseUrl;

  DiscoverApiService(this.dio, {this.baseUrl = AppConstants.baseUrl});

  Future<List<MovieModel>> fetchMovies(int page) async {
    final token = await SecureStorageHelper.getToken();

    final response = await dio.get(
      '$baseUrl/movie/list',
      queryParameters: {'page': page},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final body = response.data;
      final data = body['data'] ?? {};
      final List moviesJson = data['movies'] is List ? data['movies'] : [];
      return moviesJson.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch movies (${response.statusCode})");
    }
  }

  Future<List<String>> fetchFavoriteIds() async {
    final token = await SecureStorageHelper.getToken();

    final response = await dio.get(
      '$baseUrl/movie/favorites',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final List movies = data['movies'] is List ? data['movies'] : [];
      return movies
          .map<String>((e) => e['id'] ?? e['_id'] ?? '')
          .where((id) => id.isNotEmpty)
          .toList();
    } else {
      throw Exception("Failed to fetch favorites (${response.statusCode})");
    }
  }

  Future<void> toggleFavorite(String movieId) async {
    final token = await SecureStorageHelper.getToken();

    final response = await dio.post(
      '$baseUrl/movie/favorite/$movieId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to toggle favorite (${response.statusCode})");
    }
  }
}
