import 'package:flutter/material.dart';

class ProduceItemWidget extends StatelessWidget {
  final String imageUrl;
  const ProduceItemWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: 180,
          ),
        ),
      ),
    );
  }
}
