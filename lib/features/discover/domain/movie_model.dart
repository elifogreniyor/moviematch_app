class MovieModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  bool isFavorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    this.isFavorite = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? json['_id'] ?? '',
      title: json['Title'] ?? json['title'] ?? '',
      description: json['Plot'] ?? json['description'] ?? '',
      posterUrl: json['Poster'] ?? json['posterUrl'] ?? '',
    );
  }

  MovieModel copyWith({
    String? id,
    String? title,
    String? description,
    String? posterUrl,
    bool? isFavorite,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      posterUrl: posterUrl ?? this.posterUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
