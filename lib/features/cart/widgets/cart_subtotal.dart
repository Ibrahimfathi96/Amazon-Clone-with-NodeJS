import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    int sum = 0;
    userProvider.cart
        .map(((e) => sum += e['quantity'] * e['product']['price'] as int))
        .toList();
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            "Subtotal ",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            "\$$sum",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
