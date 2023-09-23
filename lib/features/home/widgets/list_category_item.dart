import 'package:flutter/material.dart';

class ListCategoryItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ListCategoryItem({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
