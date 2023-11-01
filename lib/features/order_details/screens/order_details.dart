import 'package:amazon_clone/models/orders_model.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/OrderDetailsScreen';
  final OrdersMd ordersMd;

  const OrderDetailsScreen({super.key, required this.ordersMd});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
