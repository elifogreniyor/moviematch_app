class PhotoUploadResponse {
  final String photoUrl;

  PhotoUploadResponse({required this.photoUrl});

  factory PhotoUploadResponse.fromJson(Map<String, dynamic> json) {
    return PhotoUploadResponse(photoUrl: json['photoUrl'] ?? '');
  }
}
