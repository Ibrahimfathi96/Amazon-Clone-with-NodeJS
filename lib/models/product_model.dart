import 'dart:convert';

import 'package:amazon_clone/models/rating_model.dart';

class ProductMd {
  final String name;
  final String description;
  final num quantity;
  final num price;
  final List<String> images;
  final String category;
  final String? id;
  final List<RatingMd>? ratings;

  ProductMd({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.images,
    required this.category,
    this.id,
    this.ratings,
  });

  factory ProductMd.fromMap(Map<String, dynamic> map) {
    return ProductMd(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      id: map['_id'],
      ratings: map['ratings'] != null
          ? List<RatingMd>.from(
              map['ratings']?.map(
                (x) => RatingMd.fromMap(x),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'category': category,
      'images': images,
      'ratings': ratings
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductMd.fromJson(String source) =>
      ProductMd.fromMap(json.decode(source));
}
