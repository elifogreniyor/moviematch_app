class MovieModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String director;
  bool isFavorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.director,
    this.isFavorite = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    id: json['id'] ?? json['_id'] ?? "",
    title: json['title'] ?? json['Title'] ?? "",
    description: json['description'] ?? json['Plot'] ?? "",
    posterUrl: json['posterUrl'] ?? json['Poster'] ?? "",
    director: json['director'] ?? json['Director'] ?? "",
    isFavorite: json['isFavorite'] ?? false,
  );

  MovieModel copyWith({
    String? id,
    String? title,
    String? description,
    String? posterUrl,
    String? director,
    bool? isFavorite,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      posterUrl: posterUrl ?? this.posterUrl,
      director: director ?? this.director,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
