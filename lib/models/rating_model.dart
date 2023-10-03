import 'dart:convert';

class RatingMd {
  final num rating;
  final String userId;

  RatingMd({
    required this.rating,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'userId': userId,
    };
  }

  factory RatingMd.fromMap(Map<String, dynamic> map) {
    return RatingMd(
      rating: map['rating'] ?? 0,
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingMd.fromJson(String source) =>
      RatingMd.fromMap(json.decode(source));
}
