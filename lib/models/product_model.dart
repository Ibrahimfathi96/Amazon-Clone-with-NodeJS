import 'dart:convert';

class ProductMd {
  final String name;
  final String description;
  final double quantity;
  final double price;
  final List<String> images;
  final String category;
  final String? id;
  final String? userId;

  ProductMd({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.images,
    required this.category,
    this.id,
    this.userId,
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
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'category': category,
      'images': images
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductMd.fromJson(String source) =>
      ProductMd.fromMap(json.decode(source));
}
