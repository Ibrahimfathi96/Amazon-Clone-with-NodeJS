import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';

class OrdersMd {
  final String id;
  final List<ProductMd> products;
  final List<num> quantity;
  final String address;
  final String userId;
  final int status;
  final int orderedAt;
  final num totalPrice;

  OrdersMd({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.status,
    required this.orderedAt,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((e) => e.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'status': status,
      'orderedAt': orderedAt,
      'totalPrice': totalPrice,
    };
  }

  factory OrdersMd.fromMap(Map<String, dynamic> map) {
    return OrdersMd(
      id: map['_id'] ?? '',
      products: List<ProductMd>.from(
        map['products']?.map(
          (x) => ProductMd.fromMap(
            x['product'],
          ),
        ),
      ),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      status: map['status'] ?? 0,
      orderedAt: map['orderedAt'] ?? 0,
      totalPrice: map['totalPrice'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersMd.fromJson(String source) =>
      OrdersMd.fromMap(json.decode(source));
}
