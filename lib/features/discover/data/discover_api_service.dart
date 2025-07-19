import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sinflix/core/constants/app_constants.dart';
import 'package:sinflix/core/utils/secure_storage_helper.dart';
import 'package:sinflix/features/discover/domain/movie_model.dart';

class DiscoverApiService {
  final Dio dio;
  final String baseUrl;

  DiscoverApiService(this.dio, {this.baseUrl = AppConstants.baseUrl});

  Future<List<MovieModel>> fetchMovies(int page) async {
    final token = await SecureStorageHelper.getToken();
    debugPrint('fetchMovies token: $token'); // Token kontrol

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

    debugPrint(
      'fetchMovies response status: ${response.statusCode}',
    ); // Status kodu
    debugPrint('fetchMovies response data: ${response.data}'); // Gelen ham data

    if (response.statusCode == 200) {
      final body = response.data;
      final data = body['data'] ?? {};
      final List moviesJson = data['movies'] is List ? data['movies'] : [];
      final totalCount = data['totalCount']; 
      final totalPages = data['totalPages'];
      final currentPage = data['currentPage'];

      print('fetchMovies parsed movie count: ${moviesJson.length}');
      print("Toplam film sayısı: ${totalCount ?? '(API Dönmedi)'}");
      print("Toplam sayfa: $totalPages");
      print("Şu anki sayfa: $currentPage");

      // Eğer totalCount yoksa tahmini hesap:
      if (totalCount == null && totalPages != null) {
        print("Tahmini toplam film: ${totalPages * moviesJson.length}");
      }

      return moviesJson.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      debugPrint('fetchMovies failed with status code: ${response.statusCode}');
      throw Exception("Failed to fetch movies (${response.statusCode})");
    }
  }

  Future<List<String>> fetchFavoriteIds() async {
    final token = await SecureStorageHelper.getToken();
    debugPrint('fetchFavoriteIds token: $token');

    final response = await dio.get(
      '$baseUrl/movie/favorites',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    debugPrint('fetchFavoriteIds response status: ${response.statusCode}');
    debugPrint('fetchFavoriteIds response data: ${response.data}');

    if (response.statusCode == 200) {
      final data = response.data;
      final List movies = data['movies'] is List ? data['movies'] : [];
      final favoriteIds = movies
          .map<String>((e) => e['id'] ?? e['_id'] ?? '')
          .where((id) => id.isNotEmpty)
          .toList();
      debugPrint('fetchFavoriteIds favorite ids: $favoriteIds');
      return favoriteIds;
    } else {
      debugPrint(
        'fetchFavoriteIds failed with status code: ${response.statusCode}',
      );
      throw Exception("Failed to fetch favorites (${response.statusCode})");
    }
  }

  Future<void> toggleFavorite(String movieId) async {
    final token = await SecureStorageHelper.getToken();
    debugPrint('toggleFavorite token: $token');
    debugPrint('toggleFavorite movieId: $movieId');

    final response = await dio.post(
      '$baseUrl/movie/favorite/$movieId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    print('toggleFavorite response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      debugPrint(
        'toggleFavorite failed with status code: ${response.statusCode}',
      );
      throw Exception("Failed to toggle favorite (${response.statusCode})");
    } else {
      debugPrint('toggleFavorite success for movieId: $movieId');
    }
  }
}
